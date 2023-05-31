import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/models/event.dart';
import 'package:narnia_festival_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static const String apiUrl = "http://girasoli35.ddns.net:1880";
  final String loginUrl = "$apiUrl/api/login";
  final String verifyUrl = "$apiUrl/api/utenti/verifica_codice";

  Future<bool> hasToken() async {
    var token = await getToken();
    return token != null;
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token");
    return token;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", token);
  }

  Future<void> deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("token");
  }

  Future<String> login(String username, String password) async {
    final response = await http.post(Uri.parse(loginUrl),
        body: {"Username": username, "Password": generateHash(password)});
    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      if (error['Codice'] == 1017) {
        throw Exception('1017');
      }
      throw Exception(response.body);
    }
    return response.body; //token
  }

  Future<List<Event>> getEvents() async {
    final response = await http.get(Uri.parse('$apiUrl/api/eventi'));
    if (response.statusCode == 200) {
      List<Event> events = [];
      for (var json in jsonDecode(response.body)) {
        events.add(Event.fromJson(json));
      }
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  String generateHash(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> verifyCode(String code) async {
    final response = await http.post(Uri.parse(verifyUrl), body: {
      "Codice": code,
    });
    return response.statusCode == 200;
  }

  Future<void> newCode() async {
    var id = getUserId();
    final response =
        await http.post(Uri.parse("$apiUrl/api/utenti/$id/new_code"));
    if (response.statusCode != 200) throw Exception(response.body);
  }

  Future<void> deleteUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("userid");
  }

  Future<void> saveUserId(String userid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("userid", userid);
  }

  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userid = preferences.getString("userid");
    return userid;
  }

  Future<void> registerUser(String nome, String cognome, String username,
      String email, String password) async {
    final response = await http.post(Uri.parse("$apiUrl/api/utenti"), body: {
      "Nome": nome,
      "Cognome": cognome,
      "Username": username,
      "Email": email,
      "PasswordHash": generateHash(password)
    });
    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
    var json = jsonDecode(response.body);
    var userid = json[0]['IdUtente'];
    await saveUserId(userid);
  }

  Future<bool> verifyToken() async {
    var token = await getToken();
    if (token != null) {
      final response = await http.get(Uri.parse('$apiUrl/api/utenti/me'),
          headers: {'Authorization': 'Bearer $token'});
      return response.statusCode == 200;
    }
    return false;
  }

  Future<User> getMe() async {
    var token = await getToken();
    final response = await http.get(Uri.parse('$apiUrl/api/utenti/me'),
        headers: {'Authorization': 'Bearer $token'});
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)[0];
      User user = User.fromJson(json);
      return user;
    } else {
      throw (Exception(response.body));
    }
  }
}
