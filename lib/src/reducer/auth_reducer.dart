import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authReducer = combineReducers(<Reducer<AuthState>>[
  TypedReducer<AuthState, LoginSuccessful>(_loginSuccessful),
  TypedReducer<AuthState, CreateUserSuccessful>(_createUserSuccessful),
  TypedReducer<AuthState, GetUserSuccessful>(_getUserSuccessful),
  TypedReducer<AuthState, OnUsersEvent>(_onUserEvent)
]);
AuthState _loginSuccessful(AuthState state, LoginSuccessful action) {
  return state.copyWith(user: action.user);
}

AuthState _createUserSuccessful(AuthState state, CreateUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AuthState _getUserSuccessful(AuthState state, GetUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AuthState _onUserEvent(AuthState state, OnUsersEvent action) {
  return state.copyWith(users: action.users);
}
