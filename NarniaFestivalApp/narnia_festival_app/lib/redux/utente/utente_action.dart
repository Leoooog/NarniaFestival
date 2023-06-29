import 'package:narnia_festival_app/models/in.dart' as input;
import 'package:narnia_festival_app/models/out.dart' as output;

class GetUtenteAction {
  @override
  String toString() {
    return 'GetUtenteAction{}';
  }
}

class GetUtenteSucceededAction {
  final input.Utente utente;

  const GetUtenteSucceededAction({
    required this.utente,
  });

  @override
  String toString() {
    return 'GetUtenteSucceededAction{utente: $utente}';
  }
}

class GetUtenteFailedAction {
  final String error;

  const GetUtenteFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetUtenteFailedAction{error: $error}';
  }
}

class UpdateUtenteAction {
  final output.UpdateUtente utente;

  const UpdateUtenteAction({
    required this.utente,
  });

  @override
  String toString() {
    return 'UpdateUtenteAction{utente: $utente}';
  }
}

class UpdateUtenteSucceededAction {
  final input.Utente utente;

  const UpdateUtenteSucceededAction({
    required this.utente,
  });

  @override
  String toString() {
    return 'UpdateUtenteSucceededAction{utente: $utente}';
  }
}

class UpdateUtenteFailedAction {
  final String error;

  const UpdateUtenteFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'UpdateUtenteFailedAction{error: $error}';
  }
}
