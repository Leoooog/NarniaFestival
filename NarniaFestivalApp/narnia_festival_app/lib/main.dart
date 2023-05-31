import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_event.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_event.dart';
import 'package:narnia_festival_app/blocs/register_bloc/register_bloc.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_bloc.dart';
import 'package:narnia_festival_app/repositories/repository.dart';
import 'package:narnia_festival_app/screens/auth_screen/login_screen.dart';
import 'package:narnia_festival_app/screens/events_screen/events_screen.dart';
import 'package:narnia_festival_app/screens/register_screen/register_screen.dart';
import 'package:narnia_festival_app/screens/verify_code_screen/verify_code_screen.dart';

void main() {
  final Repository repository = Repository();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final Repository repository;

  MyApp({required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(repository: repository)..add(AppStarted()),
        ),
        BlocProvider<EventsBloc>(
          create: (context) =>
              EventsBloc(repository: repository)..add(FetchEvents()),
        ),
        BlocProvider<VerificationBloc>(
            create: (context) => VerificationBloc(repository: repository)),
        BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(repository: repository)),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/events',
        routes: {
          '/events': (context) => EventsScreen(repository: repository),
          '/login': (context) => LoginScreen(repository: repository),
          '/register': (context) => RegisterScreen(repository: repository),
          '/verifica_codice': (context) =>
              VerifyCodeScreen(repository: repository)
        },
      ),
    );
  }
}
