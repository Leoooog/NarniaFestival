import 'package:narnia_festival_app/errors/errors.dart';
import 'package:narnia_festival_app/models/out.dart' as output;
import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_action.dart';
import 'package:narnia_festival_app/repositories/authentication_repository.dart';
import 'package:narnia_festival_app/repositories/utente_repository.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is RegisterAction) {
    final output.RegisterUtente utente = action.utente;
    AuthenticationRepository.instance.register(utente).then((idUtente) {
      SharedPreferences.getInstance().then((preferences) {
        preferences.setString('id', idUtente);
      });
      store.dispatch(RegisterSucceededAction(idUtente: idUtente));
    }).catchError((error) =>
        store.dispatch(RegisterFailedAction(error: error.toString())));
  }
  next(action);
}

void loginMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is LoginAction) {
    final output.LoginUtente utente = action.utente;
    AuthenticationRepository.instance.login(utente).then((token) {
      SharedPreferences.getInstance().then((preferences) {
        preferences.setString('token', token);
      });
      UtenteRepository.instance.getMe().then((utente) {
        SharedPreferences.getInstance().then((preferences) {
          preferences.setString("id", utente.idUtente);
        });
      });
      store.dispatch(LoginSucceededAction(token: token));
    }).catchError((error) {
      if (error is NotVerifiedError) {
        SharedPreferences.getInstance().then(
            (preferences) => {preferences.setString('id', error.idUtente)});
        store.dispatch(LoginNotVerifiedAction());
      } else {
        store.dispatch(LoginFailedAction(error: error.toString()));
      }
    });
  }
  next(action);
}

void logoutMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is LogoutAction) {
    AuthenticationRepository.instance.logout().then((_) {
      store.dispatch(LogoutSucceededAction());
      SharedPreferences.getInstance().then((preferences) {
        preferences.remove('id');
        preferences.remove('token');
      });
    }).catchError(
        (error) => store.dispatch(LogoutFailedAction(error: error.toString())));
  }
  next(action);
}
