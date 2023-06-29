import 'package:narnia_festival_app/models/in.dart';

class GetRistorantiAction {
  @override
  String toString() {
    return 'GetRistorantiAction{}';
  }
}

class GetRistorantiSucceededAction {
  final List<Ristorante> ristoranti;

  const GetRistorantiSucceededAction({
    required this.ristoranti,
  });

  @override
  String toString() {
    return 'GetRistorantiSucceededAction{ristoranti: $ristoranti}';
  }
}

class GetRistorantiFailedAction {
  final String error;

  const GetRistorantiFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetRistorantiFailedAction{error: $error}';
  }
}

class GetRistoranteAction {
  final String id;

  const GetRistoranteAction({
    required this.id,
  });

  @override
  String toString() {
    return 'GetRistoranteAction{id: $id}';
  }
}

class GetRistoranteSucceededAction {
  final Ristorante ristorante;

  const GetRistoranteSucceededAction({
    required this.ristorante,
  });

  @override
  String toString() {
    return 'GetRistoranteSucceededAction{ristorante: $ristorante}';
  }
}

class GetRistoranteFailedAction {
  final String error;

  const GetRistoranteFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetRistoranteFailedAction{error: $error}';
  }
}
