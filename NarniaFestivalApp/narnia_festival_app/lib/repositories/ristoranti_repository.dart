import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class RistorantiRepository extends Repository {
  RistorantiRepository._();

  static final RistorantiRepository _instance = RistorantiRepository._();

  static RistorantiRepository get instance => _instance;

  Future<List<Ristorante>> getRistoranti() async {
    try {
      final http.Response response = await get('/api/ristoranti', 200, false);
      final List jsonData = jsonDecode(response.body);
      final ristoranti = jsonData.map((e) => Ristorante.fromJson(e)).toList();
      return ristoranti;
    } catch (e) {
      rethrow;
    }
  }

  Future<Ristorante> getRistorante(String idRistorante) async {
    try {
      final http.Response response =
          await get('/api/ristoranti/$idRistorante', 200, false);
      final jsonData = jsonDecode(response.body)[0];
      final ristorante = Ristorante.fromJson(jsonData);
      return ristorante;
    } catch (e) {
      rethrow;
    }
  }
}
