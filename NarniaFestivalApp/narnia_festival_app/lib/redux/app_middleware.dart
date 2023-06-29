import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_middleware.dart';
import 'package:narnia_festival_app/redux/buono_pasto/buono_pasto_middleware.dart';
import 'package:narnia_festival_app/redux/evento/evento_middleware.dart';
import 'package:narnia_festival_app/redux/prenotazione/prenotazione_middleware.dart';
import 'package:narnia_festival_app/redux/ristorante/ristorante_middleware.dart';
import 'package:narnia_festival_app/redux/utente/utente_middleware.dart';
import 'package:narnia_festival_app/redux/verify_email/verify_email_middleware.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> appMiddleware() {
  return [
    registerMiddleware,
    loginMiddleware,
    logoutMiddleware,
    buonoPastoMiddleware,
    eventoMiddleware,
    prenotazioneMiddleware,
    ristoranteMiddleware,
    utenteMiddleware,
    verifyEmailMiddleware
  ];
}
