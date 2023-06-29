import 'package:narnia_festival_app/redux/app_state.dart';
import 'package:narnia_festival_app/redux/verify_email/verify_email_action.dart';
import 'package:narnia_festival_app/repositories/verify_email_repository.dart';
import 'package:redux/redux.dart';

void verifyEmailMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) {
  if (action is VerifyEmailAction) {
    VerifyEmailRepository.instance
        .verifyEmail(action.code)
        .then((_) => store.dispatch(VerifyEmailSucceededAction()))
        .catchError((error) =>
            store.dispatch(VerifyEmailFailedAction(error: error.toString())));
  } else if (action is NewCodeAction) {
    VerifyEmailRepository.instance
        .sendNewCode()
        .then((value) => store.dispatch(NewCodeSucceededAction()))
        .catchError((error) =>
            store.dispatch(NewCodeFailedAction(error: error.toString())));
  }
  next(action);
}
