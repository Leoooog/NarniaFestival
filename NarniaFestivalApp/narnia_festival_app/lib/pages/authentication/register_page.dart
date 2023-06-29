import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/out.dart' as output;
import 'package:narnia_festival_app/pages/email_verification/email_verification_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_action.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_state.dart';
import 'package:narnia_festival_app/utils/utils.dart';
import 'package:redux/redux.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registrazione'),
        ),
        body: StoreConnector<AppState, _ViewModel>(
            distinct: true,
            converter: (Store<AppState> store) => _ViewModel.fromStore(store),
            onWillChange: (_ViewModel? prev, _ViewModel curr) {
              if (curr.authenticationStatus ==
                  AuthenticationStatus.registerFailure) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error!"),
                        content: Text(curr.error),
                      );
                    });
              } else if (curr.authenticationStatus ==
                  AuthenticationStatus.registerSuccess) {
                _passwordController.clear();
                _emailController.clear();
                _usernameController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmailVerificationPage()),
                );
              }
            },
            builder: (context, vm) {
              if (vm.authenticationStatus ==
                  AuthenticationStatus.registerLoading) {
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
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _cognomeController,
                      decoration: const InputDecoration(
                        labelText: 'Cognome',
                      ),
                    ),
                    const SizedBox(height: 16.0),
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
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        String nome = _nomeController.text;
                        String cognome = _cognomeController.text;
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        String email = _emailController.text;

                        if (nome.isEmpty ||
                            cognome.isEmpty ||
                            username.isEmpty ||
                            password.isEmpty ||
                            email.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                    title: Text("Errore"),
                                    content: Text("Compila ogni campo"),
                                  ));
                        } else if (username.length < 5) {
                          showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                    title: Text("Errore"),
                                    content: Text(
                                        "L'username deve essere lungo almeno 5 caratteri"),
                                  ));
                        } else if (!validatePassword(password)) {
                          showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                    title: Text("Errore"),
                                    content: Text(
                                        "La password deve essere lunga almeno 8 caratteri e deve contenere almeno:\n- una lettera maiuscola\n- una lettera minuscola\n- una cifra\n- un carattere speciale"),
                                  ));
                        } else if (!validateEmail(email)) {
                          showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                    title: Text("Errore"),
                                    content: Text("Formato email non valido"),
                                  ));
                        } else {
                          output.RegisterUtente utente = output.RegisterUtente(
                              nome: nome,
                              cognome: cognome,
                              username: username,
                              passwordHash: generateHash(password),
                              email: email);
                          vm.register(utente);
                        }
                      },
                      child: const Text('Registrati'),
                    )
                  ],
                ),
              );
            }));
  }
}

class _ViewModel extends Equatable {
  final Function(output.RegisterUtente) register;
  final AuthenticationStatus authenticationStatus;
  final String error;

  const _ViewModel({
    required this.register,
    required this.authenticationStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        register: (utente) {
          store.dispatch(RegisterAction(utente: utente));
        },
        authenticationStatus: store.state.authenticationState.status,
        error: store.state.authenticationState.error);
  }

  @override
  List<Object?> get props => [authenticationStatus, error];

  @override
  String toString() {
    return '_ViewModel{register: $register, authenticationStatus: $authenticationStatus, error: $error}';
  }
}
