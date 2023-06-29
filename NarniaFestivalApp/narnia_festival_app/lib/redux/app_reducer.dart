import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_reducer.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_reducer.dart';
import 'package:narnia_festival_app/redux/evento/evento_reducer.dart';
import 'package:narnia_festival_app/redux/pages/tab_reducer.dart';
import 'package:narnia_festival_app/redux/prenotazione/prenotazione_reducer.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_reducer.dart';
import 'package:narnia_festival_app/redux/utente/utente_reducer.dart';
import 'package:narnia_festival_app/redux/verify_email/verify_email_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return state.copyWith(
      authenticationState:
          authenticationReducer(state.authenticationState, action),
      buonoPastoState: buonoPastoReducer(state.buonoPastoState, action),
      eventoState: eventoReducer(state.eventoState, action),
      ristoranteState: ristoranteReducer(state.ristoranteState, action),
      prenotazioneState: prenotazioneReducer(state.prenotazioneState, action),
      utenteState: utenteReducer(state.utenteState, action),
      verifyEmailState: verifyEmailReducer(state.verifyEmailState, action),
      pageIndex: tabReducer(state.tabState, action));
}
