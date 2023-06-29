import 'package:narnia_festival_app/redux/ristorante/ristorante_action.dart';
import 'package:redux/redux.dart';

import 'ristorante_state.dart';

RistoranteState getRistorantiReducer(
    RistoranteState state, GetRistorantiAction action) {
  return state.copyWith(ristorantiStatus: RistorantiStatus.loading);
}

RistoranteState getRistorantiSucceededReducer(
    RistoranteState state, GetRistorantiSucceededAction action) {
  return state.copyWith(
      ristorantiStatus: RistorantiStatus.success,
      ristoranti: action.ristoranti);
}

RistoranteState getRistorantiFailedReducer(
    RistoranteState state, GetRistorantiFailedAction action) {
  return state.copyWith(
      ristorantiStatus: RistorantiStatus.failure, error: action.error);
}

RistoranteState getRistoranteReducer(
    RistoranteState state, GetRistoranteAction action) {
  return state.copyWith(ristoranteStatus: RistoranteStatus.loading);
}

RistoranteState getRistoranteSucceededReducer(
    RistoranteState state, GetRistoranteSucceededAction action) {
  return state.copyWith(
      ristoranteStatus: RistoranteStatus.success,
      ristorante: action.ristorante);
}

RistoranteState getRistoranteFailedReducer(
    RistoranteState state, GetRistoranteFailedAction action) {
  return state.copyWith(
      ristoranteStatus: RistoranteStatus.failure, error: action.error);
}

Reducer<RistoranteState> ristoranteReducer = combineReducers([
  TypedReducer<RistoranteState, GetRistorantiAction>(getRistorantiReducer),
  TypedReducer<RistoranteState, GetRistorantiSucceededAction>(
      getRistorantiSucceededReducer),
  TypedReducer<RistoranteState, GetRistorantiFailedAction>(
      getRistorantiFailedReducer),
  TypedReducer<RistoranteState, GetRistoranteAction>(getRistoranteReducer),
  TypedReducer<RistoranteState, GetRistoranteSucceededAction>(
      getRistoranteSucceededReducer),
  TypedReducer<RistoranteState, GetRistoranteFailedAction>(
      getRistoranteFailedReducer),
]);
