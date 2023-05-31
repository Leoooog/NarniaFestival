import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/register_bloc/register_bloc.dart';
import 'package:narnia_festival_app/blocs/register_bloc/register_event.dart';
import 'package:narnia_festival_app/blocs/register_bloc/register_state.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class RegisterScreen extends StatefulWidget {
  final Repository repository;

  const RegisterScreen({Key? key, required this.repository}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registrati"),
        ),
        body: BlocProvider(
          create: (context) {
            return RegisterBloc(repository: widget.repository);
          },
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                // Utente registrato con successo, puoi eseguire l'azione desiderata, ad esempio navigare a una nuova schermata
                Navigator.pushNamed(context, "/verifica_codice");
              } else if (state is RegisterError) {
                // Errore durante la registrazione, mostra un messaggio di errore
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: "Nome"),
                      ),
                      TextFormField(
                        controller: _surnameController,
                        decoration: const InputDecoration(labelText: "Cognome"),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration:
                            const InputDecoration(labelText: "Username"),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          final name = _nameController.text;
                          final surname = _surnameController.text;
                          final username = _usernameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          // Emetti l'evento di registrazione con i dati inseriti dall'utente
                          BlocProvider.of<RegisterBloc>(context).add(
                            RegisterUser(
                              name: name,
                              surname: surname,
                              username: username,
                              email: email,
                              password: password,
                            ),
                          );
                        },
                        child: const Text("Registrati"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
