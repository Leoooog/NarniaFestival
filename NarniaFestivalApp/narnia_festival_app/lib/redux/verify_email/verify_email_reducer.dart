import 'package:narnia_festival_app/redux/verify_email/verify_email_action.dart';
import 'package:redux/redux.dart';

import 'verify_email_state.dart';

VerifyEmailState verifyEmailActionReducer(
    VerifyEmailState state, VerifyEmailAction action) {
  return state.copyWith(verifyEmailStatus: VerifyEmailStatus.loading);
}

VerifyEmailState verifyEmailSucceededReducer(
    VerifyEmailState state, VerifyEmailSucceededAction action) {
  return state.copyWith(verifyEmailStatus: VerifyEmailStatus.success);
}

VerifyEmailState verifyEmailFailedReducer(
    VerifyEmailState state, VerifyEmailFailedAction action) {
  return state.copyWith(
      verifyEmailStatus: VerifyEmailStatus.failure, error: action.error);
}

VerifyEmailState newCodeReducer(VerifyEmailState state, NewCodeAction action) {
  return state.copyWith(newCodeStatus: NewCodeStatus.loading);
}

VerifyEmailState newCodeSucceededReducer(
    VerifyEmailState state, NewCodeSucceededAction action) {
  return state.copyWith(newCodeStatus: NewCodeStatus.success);
}

VerifyEmailState newCodeFailedReducer(
    VerifyEmailState state, NewCodeFailedAction action) {
  return state.copyWith(
      newCodeStatus: NewCodeStatus.failure, error: action.error);
}

Reducer<VerifyEmailState> verifyEmailReducer = combineReducers([
  TypedReducer<VerifyEmailState, VerifyEmailAction>(verifyEmailActionReducer),
  TypedReducer<VerifyEmailState, VerifyEmailSucceededAction>(
      verifyEmailSucceededReducer),
  TypedReducer<VerifyEmailState, VerifyEmailFailedAction>(
      verifyEmailFailedReducer),
  TypedReducer<VerifyEmailState, NewCodeAction>(newCodeReducer),
  TypedReducer<VerifyEmailState, NewCodeSucceededAction>(
      newCodeSucceededReducer),
  TypedReducer<VerifyEmailState, NewCodeFailedAction>(newCodeFailedReducer),
]);
