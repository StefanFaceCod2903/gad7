import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gad7/firebase_options.dart';
import 'package:gad7/src/data/auth_api.dart';
import 'package:gad7/src/epics/app_epics.dart';
import 'package:gad7/src/models/index.dart';
import 'package:gad7/src/presentation/home.dart';
import 'package:gad7/src/reducer/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final AuthApi api = AuthApi(auth: FirebaseAuth.instance);
  final AppEpics epics = AppEpics(api);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epic),
    ],
  );
  runApp(GroupApp(
    store: store,
  ));
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
