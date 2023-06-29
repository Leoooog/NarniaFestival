import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_action.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_state.dart';
import 'package:redux/redux.dart';

class RistorantePage extends StatelessWidget {
  final String idRistorante;

  const RistorantePage({required this.idRistorante, super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (store) =>
            store.dispatch(GetRistoranteAction(id: idRistorante)),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.ristoranteStatus == RistoranteStatus.failure) {
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
          if (vm.ristoranteStatus == RistoranteStatus.initial) {
            return Container();
          } else if (vm.ristoranteStatus == RistoranteStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(title: Text(vm.ristorante.nome)),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vm.ristorante.nome,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
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
                      vm.ristorante.descrizione,
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
                      vm.ristorante.indirizzo,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Menu:',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.memory(
                        Uint8List.fromList(vm.ristorante.menu.codeUnits)),
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
  final Ristorante ristorante;
  final RistoranteStatus ristoranteStatus;
  final String error;

  const _ViewModel({
    required this.ristorante,
    required this.ristoranteStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      ristorante: store.state.ristoranteState.ristorante,
      ristoranteStatus: store.state.ristoranteState.ristoranteStatus,
      error: store.state.ristoranteState.error);

  @override
  List<Object?> get props => [ristorante, ristoranteStatus, error];

  @override
  String toString() {
    return '_ViewModel{ristorante: $ristorante, ristoranteStatus: $ristoranteStatus, error: $error}';
  }
}
