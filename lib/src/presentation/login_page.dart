import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/models/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailValid(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _onResponse(dynamic action) {
    if (action is CreateUserError) {
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? error.code)));
      }
    } else if (action is LoginError) {
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? error.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (String? value) {
                    if (value == null || !isEmailValid(value)) {
                      return 'This is not a valid email!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.length < 6) {
                      return 'The password must be at least 6 characters long!';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                Builder(
                  builder: (BuildContext context) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!Form.of(context)!.validate()) {
                                return;
                              } else {
                                final Login action =
                                    Login(email: _email.text, password: _password.text, response: _onResponse);
                                StoreProvider.of<AppState>(context).dispatch(action);
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (!Form.of(context)!.validate()) {
                                return;
                              } else {
                                final CreateUser action =
                                    CreateUser(email: _email.text, password: _password.text, response: _onResponse);
                                StoreProvider.of<AppState>(context).dispatch(action);
                              }
                            },
                            child: const Text('Create user'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
