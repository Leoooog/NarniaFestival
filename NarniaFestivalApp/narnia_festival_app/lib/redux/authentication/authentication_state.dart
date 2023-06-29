import 'package:equatable/equatable.dart';

enum AuthenticationStatus {
  initial,
  registerLoading,
  registerSuccess,
  registerFailure,
  loginLoading,
  loginSuccess,
  loginFailure,
  logoutLoading,
  logoutSuccess,
  logoutFailure,
  loginNotVerified
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final String error;
  final String token;
  final String idUtente;

  const AuthenticationState({
    required this.status,
    required this.error,
    required this.token,
    required this.idUtente,
  });

  @override
  List<Object?> get props => [status, error, token, idUtente];

  @override
  String toString() {
    return 'UtenteState{status: $status, error: $error, token: $token, idUtente: $idUtente}';
  }

  factory AuthenticationState.initial() {
    return const AuthenticationState(
        status: AuthenticationStatus.initial,
        error: '',
        token: '',
        idUtente: '');
  }

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    String? error,
    String? token,
    String? idUtente,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      error: error ?? this.error,
      token: token ?? this.token,
      idUtente: idUtente ?? this.idUtente,
    );
  }
}
