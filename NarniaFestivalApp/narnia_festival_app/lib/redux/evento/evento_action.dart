import 'package:narnia_festival_app/models/in.dart';

class GetEventiAction {
  @override
  String toString() {
    return 'GetEventiAction{}';
  }
}

class GetEventiSucceededAction {
  final List<Evento> eventi;

  const GetEventiSucceededAction({
    required this.eventi,
  });

  @override
  String toString() {
    return 'GetEventiSucceededAction{eventi: $eventi}';
  }
}

class GetEventiFailedAction {
  final String error;

  const GetEventiFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetEventiFailedAction{error: $error}';
  }
}

class GetEventoAction {
  final String id;

  const GetEventoAction({
    required this.id,
  });

  @override
  String toString() {
    return 'GetEventoAction{id: $id}';
  }
}

class GetEventoSucceededAction {
  final Evento evento;

  const GetEventoSucceededAction({
    required this.evento,
  });

  @override
  String toString() {
    return 'GetEventoSucceededAction{evento: $evento}';
  }
}

class GetEventoFailedAction {
  final String error;

  const GetEventoFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetEventoFailedAction{error: $error}';
  }
}
