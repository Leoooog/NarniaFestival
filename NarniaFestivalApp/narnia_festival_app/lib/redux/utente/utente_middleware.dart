import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/utente/utente_action.dart';
import 'package:narnia_festival_app/repositories/utente_repository.dart';
import 'package:redux/redux.dart';

void utenteMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is GetUtenteAction) {
    UtenteRepository.instance
        .getMe()
        .then((utente) =>
            store.dispatch(GetUtenteSucceededAction(utente: utente)))
        .catchError((error) =>
            store.dispatch(GetUtenteFailedAction(error: error.toString())));
  } else if (action is UpdateUtenteAction) {
    UtenteRepository.instance
        .update(action.utente)
        .then((utente) =>
            store.dispatch(UpdateUtenteSucceededAction(utente: utente)))
        .catchError((error) =>
            store.dispatch(UpdateUtenteFailedAction(error: error.toString())));
  }
  next(action);
}
