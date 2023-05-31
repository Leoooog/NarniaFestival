import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_event.dart';
import 'package:narnia_festival_app/blocs/auth_bloc/auth_state.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_bloc.dart';
import 'package:narnia_festival_app/blocs/events_bloc/events_event.dart';
import 'package:narnia_festival_app/blocs/verification_bloc/verification_bloc.dart';
import 'package:narnia_festival_app/models/user.dart';
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
      ],
      child: MaterialApp(
        title: 'NarniaFestivalApp',
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

class MyScaffold extends StatelessWidget {
  final Widget body;

  const MyScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(AppStarted());
    return Scaffold(
        appBar: AppBar(
          title: Text("NarniaFestivalApp"),
        ),
        drawer: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          print(state);
          if (state is AuthenticationAuthenticated) {
            return defaultDrawer(context, state.user);
          } else {
            return guestDrawer(context);
          }
        }),
        body: body);
  }

  Drawer defaultDrawer(BuildContext context, User user) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Benvenuto ${user.name}!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                // Aggiungi qui altri elementi personalizzati per gli utenti loggati
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).popAndPushNamed("/events");
            },
            leading: const Icon(Icons.event),
            title: const Text("Eventi"),
          ),
          ListTile(
            onTap: () {
              // Aggiungi qui altre opzioni per gli utenti loggati
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    icon: const Icon(Icons.handyman_outlined),
                    title: const Text('Lavori in corso'),
                    content: const Text(
                      'Questa funzione non è ancora supportata',
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            leading: const Icon(Icons.account_circle),
            title: const Text("Profilo"),
          ),
          ListTile(
            onTap: () {
              // Aggiungi qui altre opzioni per gli utenti loggati
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    icon: const Icon(Icons.handyman_outlined),
                    title: const Text('Lavori in corso'),
                    content: const Text(
                      'Questa funzione non è ancora supportata',
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            leading: const Icon(Icons.settings),
            title: const Text("Impostazioni"),
          ),
          ListTile(
            onTap: () {
              authenticationBloc.add(LoggedOut());
              Navigator.pop(context);
            },
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Drawer guestDrawer(BuildContext context) {
    return Drawer(
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
    );
  }
}

/*
FutureBuilder<bool>(
          future: authenticationBloc.isAuthenticated(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Visualizza uno schermo di caricamento mentre viene verificata l'autenticazione
              return const Center(
                child: CircularProgressIndicator(),

              );
            } else if (snapshot.hasError || snapshot.data == false) {
              return guestDrawer(context);
            } else {
              // L'utente è autenticato, mostra la schermata autenticata
              return defaultDrawer(context);
            }
          },),
 */
