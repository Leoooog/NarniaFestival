import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_action.dart';
import 'package:redux/redux.dart';

import 'buono_pasto_state.dart';

BuonoPastoState getBuoniPastoReducer(
    BuonoPastoState state, GetBuoniPastoAction action) {
  return state.copyWith(buoniPastoStatus: BuoniPastoStatus.loading);
}

BuonoPastoState getBuoniPastoSucceededReducer(
    BuonoPastoState state, GetBuoniPastoSucceededAction action) {
  return state.copyWith(
      buoniPastoStatus: BuoniPastoStatus.success,
      buoniPasto: action.buoniPasto);
}

BuonoPastoState getBuoniPastoFailedReducer(
    BuonoPastoState state, GetBuoniPastoFailedAction action) {
  return state.copyWith(
      buoniPastoStatus: BuoniPastoStatus.failure, error: action.error);
}

BuonoPastoState getBuonoPastoReducer(
    BuonoPastoState state, GetBuonoPastoAction action) {
  return state.copyWith(buonoPastoStatus: BuonoPastoStatus.loading);
}

BuonoPastoState getBuonoPastoSucceededReducer(
    BuonoPastoState state, GetBuonoPastoSucceededAction action) {
  return state.copyWith(
      buonoPastoStatus: BuonoPastoStatus.success,
      buonoPasto: action.buonoPasto);
}

BuonoPastoState getBuonoPastoFailedReducer(
    BuonoPastoState state, GetBuonoPastoFailedAction action) {
  return state.copyWith(
      buonoPastoStatus: BuonoPastoStatus.failure, error: action.error);
}

Reducer<BuonoPastoState> buonoPastoReducer = combineReducers([
  TypedReducer<BuonoPastoState, GetBuoniPastoAction>(getBuoniPastoReducer),
  TypedReducer<BuonoPastoState, GetBuoniPastoSucceededAction>(
      getBuoniPastoSucceededReducer),
  TypedReducer<BuonoPastoState, GetBuoniPastoFailedAction>(
      getBuoniPastoFailedReducer),
  TypedReducer<BuonoPastoState, GetBuonoPastoAction>(getBuonoPastoReducer),
  TypedReducer<BuonoPastoState, GetBuonoPastoSucceededAction>(
      getBuonoPastoSucceededReducer),
  TypedReducer<BuonoPastoState, GetBuonoPastoFailedAction>(
      getBuonoPastoFailedReducer),
]);
