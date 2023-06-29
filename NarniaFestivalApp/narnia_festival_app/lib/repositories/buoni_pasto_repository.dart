import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class BuoniPastoRepository extends Repository {
  BuoniPastoRepository._();

  static final BuoniPastoRepository _instance = BuoniPastoRepository._();

  static BuoniPastoRepository get instance => _instance;

  Future<List<BuonoPasto>> getBuoniPasto() async {
    try {
      final http.Response response =
          await get('/api/utenti/{id}/buoni_pasto', 200, true);
      final List jsonData = jsonDecode(response.body);
      final buoniPasto = jsonData.map((e) => BuonoPasto.fromJson(e)).toList();
      return buoniPasto;
    } catch (e) {
      rethrow;
    }
  }

  Future<BuonoPasto> getBuonoPasto(String idBuono) async {
    try {
      final http.Response response =
          await get('/api/buoni_pasto/$idBuono', 200, true);
      final jsonData = jsonDecode(response.body)[0];
      final buonoPasto = BuonoPasto.fromJson(jsonData);
      return buonoPasto;
    } catch (e) {
      rethrow;
    }
  }
}
