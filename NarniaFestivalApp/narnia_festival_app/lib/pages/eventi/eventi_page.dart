import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/pages/eventi/evento_page.dart';
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/evento/evento_action.dart';
import 'package:narnia_festival_app/redux/evento/evento_state.dart';
import 'package:redux/redux.dart';

class EventiPage extends StatelessWidget {
  const EventiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (Store<AppState> store) => store.dispatch(GetEventiAction()),
        onWillChange: (_ViewModel? prev, _ViewModel curr) {
          if (curr.eventiStatus == EventiStatus.failure) {
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
          if (vm.eventiStatus == EventiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (vm.eventiStatus == EventiStatus.initial) {
            return Container();
          }
          return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: vm.eventi.length,
              itemBuilder: (context, index) {
                final evento = vm.eventi[index];
                return ListTile(
                  title: Text(evento.titolo),
                  subtitle: Text(evento.sottotitolo),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                EventoPage(idEvento: evento.idEvento)));
                  },
                  leading: const Icon(Icons.event),
                  trailing: Text(evento.prezzo == 0
                      ? "Gratis"
                      : "Prezzo: €${evento.prezzo.toStringAsFixed(2)}"),
                );
              });
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store));
  }
}

class _ViewModel extends Equatable {
  final Function() refresh;
  final List<Evento> eventi;
  final EventiStatus eventiStatus;
  final String error;

  const _ViewModel({
    required this.refresh,
    required this.eventi,
    required this.eventiStatus,
    required this.error,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      refresh: () => store.dispatch(GetEventiAction()),
      eventi: store.state.eventoState.eventi,
      eventiStatus: store.state.eventoState.eventiStatus,
      error: store.state.eventoState.error);

  @override
  String toString() {
    return '_ViewModel{refresh: $refresh, eventi: $eventi, eventiStatus: $eventiStatus, error: $error}';
  }

  @override
  List<Object?> get props => [eventi, eventiStatus, error];
}
