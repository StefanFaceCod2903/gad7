import 'package:flutter/material.dart';
import 'package:gad7/src/models/index.dart';
import 'package:gad7/src/presentation/containers/user_container.dart';
import 'package:gad7/src/presentation/home_page.dart';
import 'package:gad7/src/presentation/login_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        if (user == null) {
          return const LoginPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
