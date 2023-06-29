import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_action.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_state.dart';
import 'package:narnia_festival_app/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:redux/redux.dart';

class BuonoPastoPage extends StatelessWidget {
  const BuonoPastoPage({super.key, required this.idBuono});

  final String idBuono;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (store) => store.dispatch(GetBuonoPastoAction(id: idBuono)),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.buonoPastoStatus == BuonoPastoStatus.failure) {
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
          if (vm.buonoPastoStatus == BuonoPastoStatus.initial) {
            return Container();
          } else if (vm.buonoPastoStatus == BuonoPastoStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          String titolo = vm.buonoPasto.idBuono.split('-')[0];
          return Scaffold(
            appBar: AppBar(title: Text(titolo)),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTipoBuonoString(vm.buonoPasto.tipo),
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "€${getValoreBuonoPasto(vm.buonoPasto.tipo)}",
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
                      getDescrizioneBuonoPasto(vm.buonoPasto.tipo),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    if (vm.buonoPasto.valido)
                      QrImageView(
                        data: vm.buonoPasto.idBuono,
                        size: 400,
                      )
                    else
                      const Text("NON VALIDO")
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
  final BuonoPasto buonoPasto;
  final BuonoPastoStatus buonoPastoStatus;
  final String error;

  const _ViewModel({
    required this.buonoPasto,
    required this.buonoPastoStatus,
    required this.error,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
        buonoPasto: store.state.buonoPastoState.buonoPasto,
        buonoPastoStatus: store.state.buonoPastoState.buonoPastoStatus,
        error: store.state.buonoPastoState.error);
  }

  @override
  List<Object?> get props => [buonoPastoStatus, buonoPasto, error];

  @override
  String toString() {
    return '_ViewModel{buonoPasto: $buonoPasto, buonoPastoStatus: $buonoPastoStatus, error: $error}';
  }
}
