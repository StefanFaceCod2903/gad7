import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gad7/firebase_options.dart';
import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/data/auth_api.dart';
import 'package:gad7/src/data/location_api.dart';
import 'package:gad7/src/epics/app_epics.dart';
import 'package:gad7/src/models/index.dart';
import 'package:gad7/src/presentation/home.dart';
import 'package:gad7/src/reducer/reducer.dart';
import 'package:location/location.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final AuthApi authApi = AuthApi(FirebaseAuth.instance, fireStore);
  final LocationApi locationApi = LocationApi(location: Location(), fireStore);
  final AppEpics epics = AppEpics(authApi, locationApi);

  final StreamController<dynamic> controller = StreamController<dynamic>();
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epic),
      (Store<AppState> store, dynamic action, NextDispatcher next) {
        next(action);
        controller.add(action);
      }
    ],
  )
    ..dispatch(const GetUser())
    ..dispatch(const ListenForLocations.start());

  await controller.stream
      .where((dynamic action) => action is GetUserSuccessful || action is LoginSuccessful || action is GetUserError)
      .first;
  runApp(
    GroupApp(
      store: store,
    ),
  );
}

class GroupApp extends StatelessWidget {
  const GroupApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'GroupApp',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const Home(),
        },
      ),
    );
  }
}
