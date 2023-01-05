import 'package:flutter/foundation.dart';
import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/models/index.dart';
import 'package:gad7/src/reducer/auth_reducer.dart';
import 'package:gad7/src/reducer/location_reducer.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  (AppState state, dynamic action) {
    if (kDebugMode) {
      print(action);
    }
    return state;
  },
  _reducer,
  TypedReducer<AppState, LogoutSuccessful>(_logoutSuccessful),
]);

AppState _reducer(AppState state, dynamic action) {
  return state.copyWith(
    auth: authReducer(state.auth, action),
    location: locationReducer(state.location, action),
  );
}

AppState _logoutSuccessful(AppState state, LogoutSuccessful action) {
  return const AppState();
}
