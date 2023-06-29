import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_action.dart';
import 'package:narnia_festival_app/repositories/buoni_pasto_repository.dart';
import 'package:redux/redux.dart';

void buonoPastoMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is GetBuoniPastoAction) {
    BuoniPastoRepository.instance
        .getBuoniPasto()
        .then((buoniPasto) => store
            .dispatch(GetBuoniPastoSucceededAction(buoniPasto: buoniPasto)))
        .catchError((error) =>
            store.dispatch(GetBuoniPastoFailedAction(error: error.toString())));
  } else if (action is GetBuonoPastoAction) {
    BuoniPastoRepository.instance
        .getBuonoPasto(action.id)
        .then((buonoPasto) => store
            .dispatch(GetBuonoPastoSucceededAction(buonoPasto: buonoPasto)))
        .catchError((error) =>
            store.dispatch(GetBuonoPastoFailedAction(error: error.toString())));
  }
  next(action);
}
