import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/pages/buoni_pasto/buono_pasto_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_action.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_state.dart';
import 'package:narnia_festival_app/utils/utils.dart';
import 'package:redux/redux.dart';

class BuoniPastoPage extends StatelessWidget {
  const BuoniPastoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (Store<AppState> store) =>
            store.dispatch(GetBuoniPastoAction()),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.buoniPastoStatus == BuoniPastoStatus.failure) {
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
          if (vm.buoniPastoStatus == BuoniPastoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (vm.buoniPastoStatus == BuoniPastoStatus.initial) {
            return Container();
          }
          Map<int, List<BuonoPasto>> buoniPastoByTipo = {};

          for (BuonoPasto buono in vm.buoniPasto) {
            if (buoniPastoByTipo.containsKey(buono.tipo)) {
              buoniPastoByTipo[buono.tipo]!.add(buono);
            } else {
              buoniPastoByTipo[buono.tipo] = [buono];
            }
          }
          return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: buoniPastoByTipo.length,
              itemBuilder: (context, index) {
                int tipo = buoniPastoByTipo.keys.elementAt(index);
                String tipoString = getTipoBuonoString(tipo);
                List<BuonoPasto> buoni = buoniPastoByTipo[tipo]!;
                return ExpansionTile(
                    title: Text(tipoString),
                    children: buoni
                        .map((buono) => ListTile(
                              title: Text(buono.idBuono.split('-')[0]),
                              subtitle:
                                  Text(buono.valido ? "Valido" : "Non valido"),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BuonoPastoPage(
                                          idBuono: buono.idBuono))),
                            ))
                        .toList());
              });
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store));
  }
}

class _ViewModel extends Equatable {
  final List<BuonoPasto> buoniPasto;
  final BuoniPastoStatus buoniPastoStatus;
  final String error;

  const _ViewModel({
    required this.buoniPasto,
    required this.buoniPastoStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        buoniPasto: store.state.buonoPastoState.buoniPasto,
        buoniPastoStatus: store.state.buonoPastoState.buoniPastoStatus,
        error: store.state.buonoPastoState.error);
  }

  @override
  List<Object?> get props => [buoniPasto, buoniPastoStatus];

  @override
  String toString() {
    return '_ViewModel{buoniPasto: $buoniPasto, buoniPastoStatus: $buoniPastoStatus, error: $error}';
  }
}
