import 'dart:convert';
import 'package:flutter/material.dart';
import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../helpers/user_info.dart';
import 'inventory_page.dart';
import 'registrasi_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _login() async {
    var body = {
      "email": email.text,
      "password": password.text,
    };

    var response = await Api().postJson(ApiUrl.login, body);
    print("LOGIN RAW RESPONSE: ${response.body}");

    try {
      var jsonObj = json.decode(response.body);

      if (jsonObj["status"] == true) {
        var data = jsonObj['data'];
        String token = '';

        if (data is List && data.isNotEmpty) {
          token = data[0]['token'];
        } else if (data is Map) {
          token = data['token'] ?? '';
        }

        if (token.isNotEmpty) {
          await UserInfo().setToken(token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InventoryPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Token tidak ditemukan")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login gagal: ${jsonObj['message']}")),
        );
      }
    } catch (e) {
      print("JSON ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Server tidak mengirim JSON")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Bunga Mart"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _login,
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegistrasiPage()));
              },
              child: Text("Belum punya akun? Registrasi"),
            )
          ],
        ),
      ),
    );
  }
}
