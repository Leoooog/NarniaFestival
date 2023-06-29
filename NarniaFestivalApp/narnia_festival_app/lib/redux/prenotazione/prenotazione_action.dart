import 'package:narnia_festival_app/models/in.dart' as input;
import 'package:narnia_festival_app/models/out.dart' as output;

class GetPrenotazioniAction {
  @override
  String toString() {
    return 'GetPrenotazioniAction{}';
  }
}

class GetPrenotazioniSucceededAction {
  final List<input.Prenotazione> prenotazioni;

  const GetPrenotazioniSucceededAction({
    required this.prenotazioni,
  });

  @override
  String toString() {
    return 'GetPrenotazioniSucceededAction{prenotazioni: $prenotazioni}';
  }
}

class GetPrenotazioniFailedAction {
  final String error;

  const GetPrenotazioniFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetPrenotazioniFailedAction{error: $error}';
  }
}

class GetPrenotazioneAction {
  final String id;

  const GetPrenotazioneAction({
    required this.id,
  });

  @override
  String toString() {
    return 'GetPrenotazioneAction{id: $id}';
  }
}

class GetPrenotazioneSucceededAction {
  final input.Prenotazione prenotazione;

  const GetPrenotazioneSucceededAction({
    required this.prenotazione,
  });

  @override
  String toString() {
    return 'GetPrenotazioneSucceededAction{prenotazione: $prenotazione}';
  }
}

class GetPrenotazioneFailedAction {
  final String error;

  const GetPrenotazioneFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetPrenotazioneFailedAction{error: $error}';
  }
}

class CreatePrenotazioneAction {
  final output.Prenotazione prenotazione;

  const CreatePrenotazioneAction({
    required this.prenotazione,
  });

  @override
  String toString() {
    return 'CreatePrenotazioneAction{prenotazione: $prenotazione}';
  }
}

class CreatePrenotazioneSucceededAction {
  final input.Prenotazione prenotazione;

  const CreatePrenotazioneSucceededAction({
    required this.prenotazione,
  });

  @override
  String toString() {
    return 'CreatePrenotazioneSucceededAction{prenotazione: $prenotazione}';
  }
}

class CreatePrenotazioneFailedAction {
  final String error;

  const CreatePrenotazioneFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'CreatePrenotazioneFailedAction{error: $error}';
  }
}

class DeletePrenotazioneAction {
  final String id;

  const DeletePrenotazioneAction({
    required this.id,
  });

  @override
  String toString() {
    return 'DeletePrenotazioneAction{id: $id}';
  }
}

class DeletePrenotazioneSucceededAction {
  @override
  String toString() {
    return 'DeletePrenotazioneSucceededAction{}';
  }
}

class DeletePrenotazioneFailedAction {
  final String error;

  const DeletePrenotazioneFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'DeletePrenotazioneFailedAction{error: $error}';
  }
}

class UpdatePrenotazioneAction {
  final String id;
  final output.Prenotazione prenotazione;

  const UpdatePrenotazioneAction({
    required this.id,
    required this.prenotazione,
  });

  @override
  String toString() {
    return 'UpdatePrenotazioneAction{id: $id, prenotazione: $prenotazione}';
  }
}

class UpdatePrenotazioneSucceededAction {
  final input.Prenotazione prenotazione;

  const UpdatePrenotazioneSucceededAction({
    required this.prenotazione,
  });

  @override
  String toString() {
    return 'UpdatePrenotazioneSucceededAction{prenotazione: $prenotazione}';
  }
}

class UpdatePrenotazioneFailedAction {
  final String error;

  const UpdatePrenotazioneFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'UpdatePrenotazioneFailedAction{error: $error}';
  }
}
