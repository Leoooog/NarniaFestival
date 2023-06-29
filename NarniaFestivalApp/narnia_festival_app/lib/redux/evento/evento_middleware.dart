import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/evento/evento_action.dart';
import 'package:narnia_festival_app/repositories/eventi_repository.dart';
import 'package:redux/redux.dart';

void eventoMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is GetEventiAction) {
    EventiRepository.instance.getEventi().then((eventi) {
      return store.dispatch(GetEventiSucceededAction(eventi: eventi));
    }).catchError((error) {
      store.dispatch(GetEventiFailedAction(error: error.toString()));
    });
  } else if (action is GetEventoAction) {
    EventiRepository.instance
        .getEvento(action.id)
        .then((evento) =>
            store.dispatch(GetEventoSucceededAction(evento: evento)))
        .catchError((error) =>
            store.dispatch(GetEventoFailedAction(error: error.toString())));
  }
  next(action);
}
