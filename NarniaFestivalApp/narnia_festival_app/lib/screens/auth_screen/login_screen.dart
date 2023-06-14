import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_bloc.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_event.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_state.dart';
import 'package:narnia_festival_app/main.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class LoginScreen extends StatefulWidget {
  final Repository repository;

  const LoginScreen({Key? key, required this.repository}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              repository: widget.repository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Utente registrato con successo, puoi eseguire l'azione desiderata, ad esempio navigare a una nuova schermata
              Navigator.pushNamed(context, "/events");
            } else if (state is LoginFailure) {
              // Errore durante la registrazione, mostra un messaggio di errore
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is LoginLoading) {}
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;

                        // Emetti l'evento di registrazione con i dati inseriti dall'utente
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(
                            email: username,
                            password: password,
                          ),
                        );
                      },
                      child: const Text("Log in"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
