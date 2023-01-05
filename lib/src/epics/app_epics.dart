import 'package:gad7/src/data/auth_api.dart';
import 'package:gad7/src/data/location_api.dart';
import 'package:gad7/src/epics/auth_epics.dart';
import 'package:gad7/src/epics/location_epics.dart';
import 'package:gad7/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';

class AppEpics {
  const AppEpics(this.authApi, this.locationApi);

  final AuthApi authApi;
  final LocationApi locationApi;

  Epic<AppState> get epic {
    return combineEpics(
      <Epic<AppState>>[
        AuthEpics(authApi).epic,
        LocationEpics(locationApi).epic,
      ],
    );
  }
}
