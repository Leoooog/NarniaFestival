import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/evento/evento_action.dart';
import 'package:narnia_festival_app/redux/evento/evento_state.dart';
import 'package:redux/redux.dart';

class EventoPage extends StatelessWidget {
  final String idEvento;

  const EventoPage({required this.idEvento, super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (store) => store.dispatch(GetEventoAction(id: idEvento)),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.eventoStatus == EventoStatus.failure) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error!"),
                    content: Text(curr.error),
                  );
                });
          }
        },
        builder: (context, vm) {
          if (vm.eventoStatus == EventoStatus.initial) {
            return Container();
          } else if (vm.eventoStatus == EventoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(title: Text(vm.evento.titolo)),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vm.evento.titolo,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      vm.evento.sottotitolo,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Descrizione:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      vm.evento.descrizione,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Data:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy \'alle\' HH:mm')
                          .format(vm.evento.data),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Luogo:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      vm.evento.luogo,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Prezzo:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      vm.evento.prezzo.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store));
  }
}

class _ViewModel extends Equatable {
  final Evento evento;
  final EventoStatus eventoStatus;
  final String error;

  const _ViewModel({
    required this.evento,
    required this.eventoStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      evento: store.state.eventoState.evento,
      eventoStatus: store.state.eventoState.eventoStatus,
      error: store.state.eventoState.error);

  @override
  List<Object?> get props => [evento, eventoStatus, error];

  @override
  String toString() {
    return '_ViewModel{evento: $evento, eventoStatus: $eventoStatus, error: $error}';
  }
}
