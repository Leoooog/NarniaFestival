import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/in.dart' as input;
import 'package:narnia_festival_app/models/out.dart' as output;
import 'package:narnia_festival_app/repositories/repository.dart';

class UtenteRepository extends Repository {
  UtenteRepository._();

  static final UtenteRepository _instance = UtenteRepository._();

  static UtenteRepository get instance => _instance;

  Future<input.Utente> getMe() async {
    try {
      final http.Response response = await get('/api/utenti/me', 200, true);
      final jsonData = jsonDecode(response.body)[0];
      final input.Utente utente = input.Utente.fromJson(jsonData);
      return utente;
    } catch (e) {
      rethrow;
    }
  }

  Future<input.Utente> update(output.UpdateUtente updateUtente) async {
    try {
      final http.Response response =
          await put('/api/utenti/{id}', updateUtente.toJson(), 200, true);
      final jsonData = jsonDecode(response.body)[0];
      final input.Utente newUtente = input.Utente.fromJson(jsonData);
      return newUtente;
    } catch (e) {
      rethrow;
    }
  }
}
