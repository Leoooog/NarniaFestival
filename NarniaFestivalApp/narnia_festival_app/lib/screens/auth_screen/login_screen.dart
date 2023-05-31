import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:narnia_festival_app/blocs/login_bloc/login_bloc.dart';
import 'package:narnia_festival_app/repositories/repository.dart';
import 'package:narnia_festival_app/screens/auth_screen/login_form.dart';

class LoginScreen extends StatelessWidget {
  final Repository repository;

  const LoginScreen({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor, // Colore di sfondo dell'header
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Benvenuto!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/login");
                },
                leading: const Icon(Icons.login_outlined),
                title: const Text("Login")),
            ListTile(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/register");
                },
                leading: const Icon(Icons.app_registration_outlined),
                title: const Text("Registrati")),
            ListTile(
                onTap: () {
                  Navigator.of(context).popAndPushNamed("/events");
                },
                leading: const Icon(Icons.event),
                title: const Text("Eventi")),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              repository: repository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: LoginForm(
          repository: repository,
        ),
      ),
    );
  }
}
