import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/data/auth_api.dart';
import 'package:gad7/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AuthEpics {
  const AuthEpics(this._api);

  final AuthApi _api;

  Epic<AppState> get epic {
    return combineEpics(
      <Epic<AppState>>[
        TypedEpic<AppState, LoginStart>(_loginStart),
        TypedEpic<AppState, LogoutStart>(_logoutStart),
        TypedEpic<AppState, CreateUserStart>(_createUserStart),
        TypedEpic<AppState, GetUserStart>(_getUserStart),
        _listenForUsersStart,
      ],
    );
  }

  Stream<dynamic> _loginStart(Stream<LoginStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((LoginStart action) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.login(email: action.email, password: action.password))
          .expand(
            (AppUser user) =>
                <dynamic>[const ListenForLocations.start(), Login.successful(user), const ListenForUsers.start()],
          )
          .onErrorReturnWith((Object error, StackTrace stackTrace) => Login.error(error, stackTrace))
          .doOnData(action.response);
    });
  }

  Stream<dynamic> _logoutStart(Stream<LogoutStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((LogoutStart action) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.logout())
          .map((_) => const Logout.successful())
          .onErrorReturnWith((Object error, StackTrace stackTrace) => Logout.error(error, stackTrace));
    });
  }

  Stream<dynamic> _createUserStart(Stream<CreateUserStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((CreateUserStart action) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.createUser(email: action.email, password: action.password))
          .expand(
            (AppUser user) =>
                <dynamic>[const ListenForLocations.start(), CreateUser.successful(user), const ListenForUsers.start()],
          )
          .onErrorReturnWith((Object error, StackTrace stackTrace) => CreateUser.error(error, stackTrace))
          .doOnData(action.response);
    });
  }

  Stream<dynamic> _getUserStart(Stream<GetUserStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((GetUserStart action) {
      return Stream<void>.value(null)
          .asyncMap((_) => _api.getUser())
          .map((AppUser? user) => GetUser.successful(user))
          .onErrorReturnWith((Object error, StackTrace stackTrace) => GetUser.error(error, stackTrace));
    });
  }

  Stream<dynamic> _listenForUsersStart(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ListenForUsersStart>().flatMap((ListenForUsersStart action) {
      return Stream<void>.value(null)
          .flatMap((_) => _api.getUsers())
          .map((List<AppUser> users) => ListenForUsers.event(users))
          .takeUntil(actions.whereType<ListenForLocationsDone>())
          .onErrorReturnWith((Object error, StackTrace stacktrace) => ListenForUsers.error(error, stacktrace));
    });
  }
}
