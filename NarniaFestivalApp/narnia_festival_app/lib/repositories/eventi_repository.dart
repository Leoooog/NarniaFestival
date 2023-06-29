import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/in.dart';
import 'package:narnia_festival_app/repositories/repository.dart';

class EventiRepository extends Repository {
  EventiRepository._();

  static final EventiRepository _instance = EventiRepository._();

  static EventiRepository get instance => _instance;

  Future<List<Evento>> getEventi() async {
    try {
      final http.Response response = await get('/api/eventi', 200, false);
      final List jsonData = jsonDecode(response.body);
      final eventi = jsonData.map((e) => Evento.fromJson(e)).toList();
      return eventi;
    } catch (e) {
      rethrow;
    }
  }

  Future<Evento> getEvento(String idEvento) async {
    try {
      final http.Response response =
          await get('/api/eventi/$idEvento', 200, false);
      final jsonData = jsonDecode(response.body)[0];
      final evento = Evento.fromJson(jsonData);
      return evento;
    } catch (e) {
      rethrow;
    }
  }
}
