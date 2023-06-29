import 'package:narnia_festival_app/redux/authentication/authentication_action.dart';
import 'package:narnia_festival_app/redux/authentication/authentication_state.dart';
import 'package:redux/redux.dart';

AuthenticationState registerReducer(
    AuthenticationState state, RegisterAction action) {
  return state.copyWith(status: AuthenticationStatus.registerLoading);
}

AuthenticationState registerSucceededReducer(
    AuthenticationState state, RegisterSucceededAction action) {
  return state.copyWith(
      status: AuthenticationStatus.registerSuccess, idUtente: action.idUtente);
}

AuthenticationState registerFailedReducer(
    AuthenticationState state, RegisterFailedAction action) {
  return state.copyWith(
      status: AuthenticationStatus.registerFailure, error: action.error);
}

AuthenticationState loginReducer(
    AuthenticationState state, LoginAction action) {
  return state.copyWith(status: AuthenticationStatus.loginLoading);
}

AuthenticationState loginSucceededReducer(
    AuthenticationState state, LoginSucceededAction action) {
  return state.copyWith(
      status: AuthenticationStatus.loginSuccess, token: action.token);
}

AuthenticationState loginNotVerifiedReducer(
    AuthenticationState state, LoginNotVerifiedAction action) {
  return state.copyWith(status: AuthenticationStatus.loginNotVerified);
}

AuthenticationState loginFailedReducer(
    AuthenticationState state, LoginFailedAction action) {
  return state.copyWith(
      status: AuthenticationStatus.loginFailure, error: action.error);
}

AuthenticationState logoutReducer(
    AuthenticationState state, LogoutAction action) {
  return state.copyWith(
    status: AuthenticationStatus.logoutLoading,
  );
}

AuthenticationState logoutSucceededReducer(
    AuthenticationState state, LogoutSucceededAction action) {
  return state.copyWith(
    status: AuthenticationStatus.logoutSuccess,
  );
}

AuthenticationState logoutFailedReducer(
    AuthenticationState state, LogoutFailedAction action) {
  return state.copyWith(
      status: AuthenticationStatus.logoutFailure, error: action.error);
}

Reducer<AuthenticationState> authenticationReducer = combineReducers([
  TypedReducer<AuthenticationState, RegisterAction>(registerReducer),
  TypedReducer<AuthenticationState, RegisterSucceededAction>(
      registerSucceededReducer),
  TypedReducer<AuthenticationState, RegisterFailedAction>(
      registerFailedReducer),
  TypedReducer<AuthenticationState, LoginAction>(loginReducer),
  TypedReducer<AuthenticationState, LoginSucceededAction>(
      loginSucceededReducer),
  TypedReducer<AuthenticationState, LoginFailedAction>(loginFailedReducer),
  TypedReducer<AuthenticationState, LogoutAction>(logoutReducer),
  TypedReducer<AuthenticationState, LogoutSucceededAction>(
      logoutSucceededReducer),
  TypedReducer<AuthenticationState, LogoutFailedAction>(logoutFailedReducer),
  TypedReducer<AuthenticationState, LoginNotVerifiedAction>(
      loginNotVerifiedReducer)
]);
