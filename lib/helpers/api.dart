import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_info.dart';

class Api {
  // GET pakai token
  Future<http.Response> get(String url) async {
    String? token = await UserInfo().getToken();

    return await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  // POST JSON → untuk login, registrasi, dan inventory
  Future<http.Response> postJson(String url, Map body) async {
    String? token = await UserInfo().getToken();

    return await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
  }

  // PUT JSON → update data inventory
  Future<http.Response> putJson(String url, Map body) async {
    String? token = await UserInfo().getToken();

    return await http.put(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );
  }

  // DELETE
  Future<http.Response> delete(String url) async {
    String? token = await UserInfo().getToken();

    return await http.delete(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
