import 'package:narnia_festival_app/redux/utente/utente_action.dart';
import 'package:narnia_festival_app/redux/utente/utente_state.dart';
import 'package:redux/redux.dart';

UtenteState getUtenteReducer(UtenteState state, GetUtenteAction action) {
  return state.copyWith(getUtenteStatus: GetUtenteStatus.loading);
}

UtenteState getUtenteSucceededReducer(
    UtenteState state, GetUtenteSucceededAction action) {
  return state.copyWith(
      getUtenteStatus: GetUtenteStatus.success, utente: action.utente);
}

UtenteState getUtenteFailedReducer(
    UtenteState state, GetUtenteFailedAction action) {
  return state.copyWith(
      getUtenteStatus: GetUtenteStatus.failure, error: action.error);
}

UtenteState updateUtenteReducer(UtenteState state, UpdateUtenteAction action) {
  return state.copyWith(updateUtentiStatus: UpdateUtenteStatus.loading);
}

UtenteState updateUtenteSucceededReducer(
    UtenteState state, UpdateUtenteSucceededAction action) {
  return state.copyWith(
      updateUtentiStatus: UpdateUtenteStatus.success, utente: action.utente);
}

UtenteState updateUtenteFailedReducer(
    UtenteState state, UpdateUtenteFailedAction action) {
  return state.copyWith(
      updateUtentiStatus: UpdateUtenteStatus.failure, error: action.error);
}

Reducer<UtenteState> utenteReducer = combineReducers([
  TypedReducer<UtenteState, UpdateUtenteAction>(updateUtenteReducer),
  TypedReducer<UtenteState, UpdateUtenteSucceededAction>(
      updateUtenteSucceededReducer),
  TypedReducer<UtenteState, UpdateUtenteFailedAction>(
      updateUtenteFailedReducer),
  TypedReducer<UtenteState, GetUtenteAction>(getUtenteReducer),
  TypedReducer<UtenteState, GetUtenteSucceededAction>(
      getUtenteSucceededReducer),
  TypedReducer<UtenteState, GetUtenteFailedAction>(getUtenteFailedReducer),
]);
