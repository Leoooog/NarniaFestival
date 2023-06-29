import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/prenotazione/prenotazione_action.dart';
import 'package:narnia_festival_app/repositories/prenotazioni_repository.dart';
import 'package:redux/redux.dart';

void prenotazioneMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is GetPrenotazioniAction) {
    PrenotazioniRepository.instance
        .getPrenotazioni()
        .then((prenotazioni) => store.dispatch(
            GetPrenotazioniSucceededAction(prenotazioni: prenotazioni)))
        .catchError((error) => store
            .dispatch(GetPrenotazioniFailedAction(error: error.toString())));
  } else if (action is GetPrenotazioneAction) {
    PrenotazioniRepository.instance
        .getPrenotazione(action.id)
        .then((prenotazione) => store.dispatch(
            GetPrenotazioneSucceededAction(prenotazione: prenotazione)))
        .catchError((error) => store
            .dispatch(GetPrenotazioneFailedAction(error: error.toString())));
  } else if (action is CreatePrenotazioneAction) {
    PrenotazioniRepository.instance
        .createPrenotazione(action.prenotazione)
        .then((prenotazione) => store.dispatch(
            CreatePrenotazioneSucceededAction(prenotazione: prenotazione)))
        .catchError((error) => store
            .dispatch(CreatePrenotazioneFailedAction(error: error.toString())));
  } else if (action is DeletePrenotazioneAction) {
    PrenotazioniRepository.instance
        .deletePrenotazione(action.id)
        .then((_) => store.dispatch(DeletePrenotazioneSucceededAction()))
        .catchError((error) => store
            .dispatch(DeletePrenotazioneFailedAction(error: error.toString())));
  } else if (action is UpdatePrenotazioneAction) {
    PrenotazioniRepository.instance
        .updatePrenotazione(action.id, action.prenotazione)
        .then((prenotazione) => store.dispatch(
            UpdatePrenotazioneSucceededAction(prenotazione: prenotazione)))
        .catchError((error) => store
            .dispatch(UpdatePrenotazioneFailedAction(error: error.toString())));
  }
  next(action);
}
