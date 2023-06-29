import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:narnia_festival_app/errors/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authority = "girasoli35.ddns.net:1880";

abstract class Repository {
  @protected
  Future<http.Response> post(
      String route, Object body, int codeSuccess, bool authenticated) async {
    route = await _removePlaceholders(route);
    Uri url = Uri.http(authority, route);
    Map<String, String> headers;
    if (authenticated) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      if (token == null) throw Exception("token is null");
      headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {"Content-Type": "application/json"};
    }
    final http.Response response = await http
        .post(url, headers: headers, body: jsonEncode(body))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != codeSuccess) {
      var body = jsonDecode(response.body);
      var codice = body['Codice'];
      var messaggio = body['Messaggio'];
      if (codice == 1017) {
        throw NotVerifiedError(
            codice: codice, messaggio: messaggio, idUtente: body['IdUtente']);
      } else {
        throw CustomError(codice: codice, messaggio: messaggio);
      }
    }
    return response;
  }

  @protected
  Future<http.Response> put(
      String route, Object body, int codeSuccess, bool authenticated) async {
    route = await _removePlaceholders(route);
    Uri url = Uri.http(authority, route);
    Map<String, String> headers;
    if (authenticated) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      if (token == null) throw Exception("token is null");
      headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {"Content-Type": "application/json"};
    }
    final http.Response response = await http
        .put(url, headers: headers, body: body)
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != codeSuccess) {
      var body = jsonDecode(response.body);
      var codice = body['Codice'];
      var messaggio = body['Messaggio'];
      if (codice == 1017) {
        throw NotVerifiedError(
            codice: codice, messaggio: messaggio, idUtente: body['IdUtente']);
      } else {
        throw CustomError(codice: codice, messaggio: messaggio);
      }
    }
    return response;
  }

  @protected
  Future<http.Response> delete(
      String route, int codeSuccess, bool authenticated) async {
    route = await _removePlaceholders(route);
    Uri url = Uri.http(authority, route);
    Map<String, String> headers;
    if (authenticated) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      if (token == null) throw Exception("token is null");
      headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {"Content-Type": "application/json"};
    }
    final http.Response response = await http
        .delete(
          url,
          headers: headers,
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != codeSuccess) {
      var body = jsonDecode(response.body);
      var codice = body['Codice'];
      var messaggio = body['Messaggio'];
      if (codice == 1017) {
        throw NotVerifiedError(
            codice: codice, messaggio: messaggio, idUtente: body['IdUtente']);
      } else {
        throw CustomError(codice: codice, messaggio: messaggio);
      }
    }
    return response;
  }

  @protected
  Future<http.Response> get(
      String route, int codeSuccess, bool authenticated) async {
    route = await _removePlaceholders(route);
    Uri url = Uri.http(authority, route);
    Map<String, String> headers;
    if (authenticated) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      if (token == null) throw Exception("token is null");
      headers = {"Authorization": "Bearer $token"};
    } else {
      headers = {};
    }
    final http.Response response = await http
        .get(
          url,
          headers: headers,
        )
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != codeSuccess) {
      var body = jsonDecode(response.body);
      var codice = body['Codice'];
      var messaggio = body['Messaggio'];
      if (codice == 1017) {
        throw NotVerifiedError(
            codice: codice, messaggio: messaggio, idUtente: body['IdUtente']);
      } else {
        throw CustomError(codice: codice, messaggio: messaggio);
      }
    }
    return response;
  }

  Future<String> _removePlaceholders(String s) async {
    if (!s.contains("{id}")) return s;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString('id');
    if (userId == null) throw Exception("userId is null");
    return s.replaceAll("{id}", userId);
  }
}
