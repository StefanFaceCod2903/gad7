import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/models/index.dart';
import 'package:gad7/src/presentation/containers/user_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        return Scaffold(
          appBar: AppBar(
            title: Text(user!.displayName),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context).dispatch(const Logout());
                },
                icon: const Icon(Icons.power_settings_new),
              )
            ],
          ),
        );
      },
    );
  }
}
