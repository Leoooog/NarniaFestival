import 'package:narnia_festival_app/redux/prenotazione/prenotazione_action.dart';
import 'package:redux/redux.dart';

import 'prenotazione_state.dart';

PrenotazioneState getPrenotazioniReducer(
    PrenotazioneState state, GetPrenotazioniAction action) {
  return state.copyWith(getPrenotazioniStatus: GetPrenotazioniStatus.loading);
}

PrenotazioneState getPrenotazioniSucceededReducer(
    PrenotazioneState state, GetPrenotazioniSucceededAction action) {
  return state.copyWith(
      getPrenotazioniStatus: GetPrenotazioniStatus.success,
      prenotazioni: action.prenotazioni);
}

PrenotazioneState getPrenotazioniFailedReducer(
    PrenotazioneState state, GetPrenotazioniFailedAction action) {
  return state.copyWith(
      getPrenotazioniStatus: GetPrenotazioniStatus.failure,
      error: action.error);
}

PrenotazioneState getPrenotazioneReducer(
    PrenotazioneState state, GetPrenotazioneAction action) {
  return state.copyWith(getPrenotazioneStatus: GetPrenotazioneStatus.loading);
}

PrenotazioneState getPrenotazioneSucceededReducer(
    PrenotazioneState state, GetPrenotazioneSucceededAction action) {
  return state.copyWith(
      getPrenotazioneStatus: GetPrenotazioneStatus.success,
      prenotazione: action.prenotazione);
}

PrenotazioneState getPrenotazioneFailedReducer(
    PrenotazioneState state, GetPrenotazioneFailedAction action) {
  return state.copyWith(
      getPrenotazioneStatus: GetPrenotazioneStatus.failure,
      error: action.error);
}

PrenotazioneState createPrenotazioneReducer(
    PrenotazioneState state, CreatePrenotazioneAction action) {
  return state.copyWith(
      createPrenotazioneStatus: CreatePrenotazioneStatus.loading);
}

PrenotazioneState createPrenotazioneSucceededReducer(
    PrenotazioneState state, CreatePrenotazioneSucceededAction action) {
  return state.copyWith(
      createPrenotazioneStatus: CreatePrenotazioneStatus.success,
      prenotazione: action.prenotazione);
}

PrenotazioneState createPrenotazioneFailedReducer(
    PrenotazioneState state, CreatePrenotazioneFailedAction action) {
  return state.copyWith(
      createPrenotazioneStatus: CreatePrenotazioneStatus.failure,
      error: action.error);
}

PrenotazioneState deletePrenotazioneReducer(
    PrenotazioneState state, DeletePrenotazioneAction action) {
  return state.copyWith(
      deletePrenotazioneStatus: DeletePrenotazioneStatus.loading);
}

PrenotazioneState deletePrenotazioneSucceededReducer(
    PrenotazioneState state, DeletePrenotazioneSucceededAction action) {
  return state.copyWith(
    deletePrenotazioneStatus: DeletePrenotazioneStatus.success,
  );
}

PrenotazioneState deletePrenotazioneFailedReducer(
    PrenotazioneState state, DeletePrenotazioneFailedAction action) {
  return state.copyWith(
      deletePrenotazioneStatus: DeletePrenotazioneStatus.failure,
      error: action.error);
}

PrenotazioneState updatePrenotazioneReducer(
    PrenotazioneState state, UpdatePrenotazioneAction action) {
  return state.copyWith(
      updatePrenotazioneStatus: UpdatePrenotazioneStatus.loading);
}

PrenotazioneState updatePrenotazioneSucceededReducer(
    PrenotazioneState state, UpdatePrenotazioneSucceededAction action) {
  return state.copyWith(
    updatePrenotazioneStatus: UpdatePrenotazioneStatus.success,
  );
}

PrenotazioneState updatePrenotazioneFailedReducer(
    PrenotazioneState state, UpdatePrenotazioneFailedAction action) {
  return state.copyWith(
      updatePrenotazioneStatus: UpdatePrenotazioneStatus.failure,
      error: action.error);
}

Reducer<PrenotazioneState> prenotazioneReducer = combineReducers([
  TypedReducer<PrenotazioneState, GetPrenotazioniAction>(
      getPrenotazioniReducer),
  TypedReducer<PrenotazioneState, GetPrenotazioniSucceededAction>(
      getPrenotazioniSucceededReducer),
  TypedReducer<PrenotazioneState, GetPrenotazioniFailedAction>(
      getPrenotazioniFailedReducer),
  TypedReducer<PrenotazioneState, GetPrenotazioneAction>(
      getPrenotazioneReducer),
  TypedReducer<PrenotazioneState, GetPrenotazioneSucceededAction>(
      getPrenotazioneSucceededReducer),
  TypedReducer<PrenotazioneState, GetPrenotazioneFailedAction>(
      getPrenotazioneFailedReducer),
  TypedReducer<PrenotazioneState, CreatePrenotazioneAction>(
      createPrenotazioneReducer),
  TypedReducer<PrenotazioneState, CreatePrenotazioneSucceededAction>(
      createPrenotazioneSucceededReducer),
  TypedReducer<PrenotazioneState, CreatePrenotazioneFailedAction>(
      createPrenotazioneFailedReducer),
  TypedReducer<PrenotazioneState, DeletePrenotazioneAction>(
      deletePrenotazioneReducer),
  TypedReducer<PrenotazioneState, DeletePrenotazioneSucceededAction>(
      deletePrenotazioneSucceededReducer),
  TypedReducer<PrenotazioneState, DeletePrenotazioneFailedAction>(
      deletePrenotazioneFailedReducer),
  TypedReducer<PrenotazioneState, UpdatePrenotazioneAction>(
      updatePrenotazioneReducer),
  TypedReducer<PrenotazioneState, UpdatePrenotazioneSucceededAction>(
      updatePrenotazioneSucceededReducer),
  TypedReducer<PrenotazioneState, UpdatePrenotazioneFailedAction>(
      updatePrenotazioneFailedReducer),
]);
