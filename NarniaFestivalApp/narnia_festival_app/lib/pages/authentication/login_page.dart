import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/out.dart';
import 'package:narnia_festival_app/pages/email_verification/email_verification_page.dart';
import 'package:narnia_festival_app/pages/home/home_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_action.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_state.dart';
import 'package:narnia_festival_app/utils/utils.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.authenticationStatus == AuthenticationStatus.loginFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Errore!"),
                  content: Text(curr.error),
                );
              },
            );
          } else if (curr.authenticationStatus ==
              AuthenticationStatus.loginSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (_) => false);
          } else if (curr.authenticationStatus ==
              AuthenticationStatus.loginNotVerified) {
            _passwordController.clear();
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => EmailVerificationPage()));
          }
        },
        builder: (context, vm) {
          if (vm.authenticationStatus == AuthenticationStatus.loginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    if (username.isEmpty || password.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                                title: Text("Errore"),
                                content: Text("Compila ogni campo"),
                              ));
                    } else {
                      vm.login(LoginUtente(
                          username: username,
                          password: generateHash(password)));
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final Function(LoginUtente) login;
  final AuthenticationStatus authenticationStatus;
  final String error;

  const _ViewModel({
    required this.login,
    required this.authenticationStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      login: (utente) {
        store.dispatch(LoginAction(utente: utente));
      },
      authenticationStatus: store.state.authenticationState.status,
      error: store.state.authenticationState.error,
    );
  }

  @override
  List<Object?> get props => [authenticationStatus, error];

  @override
  String toString() {
    return '_ViewModel{login: $login, authenticationStatus: $authenticationStatus, error: $error}';
  }
}
