import 'package:narnia_festival_app/models/in.dart';

class GetBuoniPastoAction {
  @override
  String toString() {
    return 'GetBuoniPastoAction{}';
  }
}

class GetBuoniPastoSucceededAction {
  final List<BuonoPasto> buoniPasto;

  const GetBuoniPastoSucceededAction({
    required this.buoniPasto,
  });

  @override
  String toString() {
    return 'GetBuoniPastoSucceededAction{buoniPasto: $buoniPasto}';
  }
}

class GetBuoniPastoFailedAction {
  final String error;

  const GetBuoniPastoFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetBuoniPastoFailedAction{error: $error}';
  }
}

class GetBuonoPastoAction {
  final String id;

  const GetBuonoPastoAction({
    required this.id,
  });

  @override
  String toString() {
    return 'GetBuonoPastoAction{id: $id}';
  }
}

class GetBuonoPastoSucceededAction {
  final BuonoPasto buonoPasto;

  const GetBuonoPastoSucceededAction({
    required this.buonoPasto,
  });

  @override
  String toString() {
    return 'GetBuonoPastoSucceededAction{buonoPasto: $buonoPasto}';
  }
}

class GetBuonoPastoFailedAction {
  final String error;

  const GetBuonoPastoFailedAction({
    required this.error,
  });

  @override
  String toString() {
    return 'GetBuonoPastoFailedAction{error: $error}';
  }
}
