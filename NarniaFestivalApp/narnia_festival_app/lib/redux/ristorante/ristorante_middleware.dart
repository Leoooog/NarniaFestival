import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_action.dart';
import 'package:narnia_festival_app/repositories/ristoranti_repository.dart';
import 'package:redux/redux.dart';

void ristoranteMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is GetRistorantiAction) {
    RistorantiRepository.instance
        .getRistoranti()
        .then((ristoranti) => store
            .dispatch(GetRistorantiSucceededAction(ristoranti: ristoranti)))
        .catchError((error) =>
            store.dispatch(GetRistorantiFailedAction(error: error.toString())));
  } else if (action is GetRistoranteAction) {
    RistorantiRepository.instance
        .getRistorante(action.id)
        .then((ristorante) => store
            .dispatch(GetRistoranteSucceededAction(ristorante: ristorante)))
        .catchError((error) =>
            store.dispatch(GetRistoranteFailedAction(error: error.toString())));
  }
  next(action);
}
