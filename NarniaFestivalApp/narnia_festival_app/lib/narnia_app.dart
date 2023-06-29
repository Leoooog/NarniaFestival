import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/errors/errors.dart';
import 'package:narnia_festival_app/models/in.dart' as input;
import 'package:narnia_festival_app/pages/home/home_page.dart';
import 'package:narnia_festival_app/pages/welcome/welcome_page.dart';
import 'package:narnia_festival_app/redux/app_middleware.dart';
import 'package:narnia_festival_app/redux/app_reducer.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/repositories/utente_repository.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final Store<AppState> store;

void main() {
  store = Store<AppState>(reducer,
      initialState: AppState.initial(), middleware: appMiddleware());
  runApp(NarniaApp());
}

class NarniaApp extends StatelessWidget {
  NarniaApp({super.key});

  final Future<bool> _loggedIn = Future(() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("token")) {
      try {
        input.Utente utente = await UtenteRepository.instance.getMe();
        preferences.setString("id", utente.idUtente);
      } on CustomError catch (e, _) {
        if (e.codice == 1008) {
          preferences.remove("id");
          preferences.remove("token");
        }
        return false;
      }
      return true;
    } else {
      return false;
    }
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: "Narnia Festival App",
          debugShowCheckedModeBanner: false,
          color: Colors.blue,
          home: FutureBuilder(
              future: _loggedIn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return HomePage();
                  } else {
                    return WelcomePage();
                  }
                } else if (snapshot.hasError) {
                  return WelcomePage();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
              accentColor: Colors.blueAccent,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.blue,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ));
  }
}
