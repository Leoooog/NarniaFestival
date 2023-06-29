import 'package:narnia_festival_app/models/out.dart' as output;

class RegisterAction {
  final output.RegisterUtente utente;

  const RegisterAction({
    required this.utente,
  });

  @override
  String toString() {
    return 'RegisterAction{utente: $utente}';
  }
}

class RegisterSucceededAction {
  final String idUtente;

  const RegisterSucceededAction({
    required this.idUtente,
  });

  @override
  String toString() {
    return 'RegisterSucceededAction{idUtente: $idUtente}';
  }
}

class RegisterFailedAction {
  final String error;

  const RegisterFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'RegisterFailedAction{error: $error}';
  }
}

class LoginAction {
  final output.LoginUtente utente;

  const LoginAction({
    required this.utente,
  });

  @override
  String toString() {
    return 'LoginAction{utente: $utente}';
  }
}

class LoginSucceededAction {
  final String token;

  const LoginSucceededAction({
    required this.token,
  });

  @override
  String toString() {
    return 'LoginSucceededAction{token: $token}';
  }
}

class LoginNotVerifiedAction {
  @override
  String toString() {
    return 'LoginNotVerifiedAction{}';
  }
}

class LoginFailedAction {
  final String error;

  const LoginFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'LoginFailedAction{error: $error}';
  }
}

class LogoutAction {
  @override
  String toString() {
    return 'LogoutAction{}';
  }
}

class LogoutSucceededAction {
  @override
  String toString() {
    return 'LogoutSucceededAction{}';
  }
}

class LogoutFailedAction {
  final String error;

  const LogoutFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'LogoutFailedAction{error: $error}';
  }
}
