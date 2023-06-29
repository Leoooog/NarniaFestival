import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/in.dart' as input;
import 'package:narnia_festival_app/models/out.dart' as output;
import 'package:narnia_festival_app/repositories/repository.dart';

class PrenotazioniRepository extends Repository {
  PrenotazioniRepository._();

  static final PrenotazioniRepository _instance = PrenotazioniRepository._();

  static PrenotazioniRepository get instance => _instance;

  Future<List<input.Prenotazione>> getPrenotazioni() async {
    try {
      final http.Response response =
          await get('/api/utenti/{id}/prenotazioni', 200, true);
      final List jsonData = jsonDecode(response.body);
      final prenotazioni =
          jsonData.map((e) => input.Prenotazione.fromJson(e)).toList();
      return prenotazioni;
    } catch (e) {
      rethrow;
    }
  }

  Future<input.Prenotazione> getPrenotazione(String idBuono) async {
    try {
      final http.Response response =
          await get('/api/prenotazioni/$idBuono', 200, true);
      final jsonData = jsonDecode(response.body)[0];
      final prenotazione = input.Prenotazione.fromJson(jsonData);
      return prenotazione;
    } catch (e) {
      rethrow;
    }
  }

  Future<input.Prenotazione> createPrenotazione(
      output.Prenotazione prenotazione) async {
    try {
      final http.Response response =
          await post('/api/prenotazioni', prenotazione.toJson(), 201, true);
      final jsonData = jsonDecode(response.body)[0];
      final newPrenotazione = input.Prenotazione.fromJson(jsonData);
      return newPrenotazione;
    } catch (e) {
      rethrow;
    }
  }

  Future deletePrenotazione(String id) async {
    try {
      await delete('/api/prenotazioni/$id', 204, true);
    } catch (e) {
      rethrow;
    }
  }

  Future<input.Prenotazione> updatePrenotazione(
      String id, output.Prenotazione prenotazione) async {
    try {
      final http.Response response =
          await put('/api/prenotazioni/$id', prenotazione.toJson(), 200, true);
      final jsonData = jsonDecode(response.body)[0];
      final newPrenotazione = input.Prenotazione.fromJson(jsonData);
      return newPrenotazione;
    } catch (e) {
      rethrow;
    }
  }
}
