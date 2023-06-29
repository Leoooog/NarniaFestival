import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/pages/ristoranti/ristorante_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/evento/evento_action.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_action.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_state.dart';
import 'package:redux/redux.dart';

class RistorantiPage extends StatelessWidget {
  const RistorantiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (Store<AppState> store) =>
            store.dispatch(GetRistorantiAction()),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.ristorantiStatus == RistorantiStatus.failure) {
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
          if (vm.ristorantiStatus == RistorantiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (vm.ristorantiStatus == RistorantiStatus.initial) {
            return Container();
          }
          return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: vm.ristoranti.length,
              itemBuilder: (context, index) {
                final ristorante = vm.ristoranti[index];
                return ListTile(
                  title: Text(ristorante.nome),
                  subtitle: Text(ristorante.descrizione),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RistorantePage(
                                idRistorante: ristorante.idRistorante)));
                  },
                  leading: const Icon(Icons.event),
                );
              });
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store));
  }
}

class _ViewModel extends Equatable {
  final Function() refresh;
  final List<Ristorante> ristoranti;
  final RistorantiStatus ristorantiStatus;
  final String error;

  const _ViewModel({
    required this.refresh,
    required this.ristoranti,
    required this.ristorantiStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      refresh: () => store.dispatch(GetEventiAction()),
      ristoranti: store.state.ristoranteState.ristoranti,
      ristorantiStatus: store.state.ristoranteState.ristorantiStatus,
      error: store.state.ristoranteState.error);

  @override
  String toString() {
    return '_ViewModel{refresh: $refresh, ristoranti: $ristoranti, ristorantiStatus: $ristorantiStatus, error: $error}';
  }

  @override
  List<Object?> get props => [ristoranti, ristorantiStatus, error];
}
