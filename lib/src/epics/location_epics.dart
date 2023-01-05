import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/data/location_api.dart';
import 'package:gad7/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class LocationEpics {
  LocationEpics(this._api);

  final LocationApi _api;

  Epic<AppState> get epic {
    return combineEpics(
      <Epic<AppState>>[TypedEpic<AppState, GetLocationStart>(_getLocationStart), _listenForLocationsStart],
    );
  }

  Stream<dynamic> _getLocationStart(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<GetLocationStart>().flatMap((GetLocationStart action) {
      return Stream<void>.value(null)
          .flatMap<dynamic>((_) => _api.getLocation(store.state.auth.user!.uid))
          .mapTo<dynamic>(null)
          .takeUntil(actions.whereType<GetLocationDone>())
          .onErrorReturnWith((Object error, StackTrace stackTrace) => GetLocation.error(error, stackTrace));
    });
  }

  Stream<dynamic> _listenForLocationsStart(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ListenForLocationsStart>().flatMap((ListenForLocationsStart action) {
      return Stream<void>.value(null)
          .flatMap((_) => _api.listenLocations())
          .map((List<UserLocation> locations) => ListenForLocations.event(locations))
          .takeUntil(actions.whereType<ListenForLocationsDone>())
          .onErrorReturnWith((Object error, StackTrace stacktrace) => ListenForLocations.error(error, stacktrace));
    });
  }
}
