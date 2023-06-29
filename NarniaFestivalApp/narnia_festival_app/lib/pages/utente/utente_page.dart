import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:narnia_festival_app/models/in.dart' as input;
import 'package:narnia_festival_app/pages/welcome/welcome_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_action.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_state.dart';
import 'package:narnia_festival_app/redux/utente/utente_action.dart';
import 'package:narnia_festival_app/redux/utente/utente_state.dart';
import 'package:redux/redux.dart';

class UtentePage extends StatelessWidget {
  const UtentePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      distinct: true,
      onInit: (Store<AppState> store) => store.dispatch(GetUtenteAction()),
      onWillChange: (_ViewModel? prev, _ViewModel curr) {
        if (curr.getUtenteStatus == GetUtenteStatus.failure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error!"),
                content: Text(curr.utenteError),
              );
            },
          );
        } else if (curr.authenticationStatus ==
            AuthenticationStatus.logoutFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error!"),
                content: Text(curr.logoutError),
              );
            },
          );
        }
      },
      builder: (context, vm) {
        if (vm.getUtenteStatus == GetUtenteStatus.initial) {
          return Container();
        } else if (vm.getUtenteStatus == GetUtenteStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
            child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(vm.utente.nome,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(width: 6),
                Text(vm.utente.cognome,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  vm.utente.email,
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              const SizedBox(height: 60),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text('Username: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(vm.utente.username,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 25),
              Row(children: [
                const Text('Registrato il: ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                    DateFormat('dd/MM/yyyy \'alle\' HH:mm')
                        .format(vm.utente.dataCreazione),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400))
              ]),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  vm.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => WelcomePage()),
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ));
      },
    );
  }
}

class _ViewModel extends Equatable {
  final input.Utente utente;
  final String utenteError;
  final GetUtenteStatus getUtenteStatus;
  final AuthenticationStatus authenticationStatus;
  final String logoutError;
  final Function() logout;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        utente: store.state.utenteState.utente,
        utenteError: store.state.utenteState.error,
        logoutError: store.state.authenticationState.error,
        authenticationStatus: store.state.authenticationState.status,
        getUtenteStatus: store.state.utenteState.getUtenteStatus,
        logout: () {
          store.dispatch(LogoutAction());
        });
  }

  @override
  String toString() {
    return '_ViewModel{utente: $utente, logout: $logout}';
  }

  @override
  List<Object?> get props =>
      [utente, utenteError, getUtenteStatus, authenticationStatus, logoutError];

  const _ViewModel({
    required this.utente,
    required this.utenteError,
    required this.getUtenteStatus,
    required this.authenticationStatus,
    required this.logoutError,
    required this.logout,
  });
}
