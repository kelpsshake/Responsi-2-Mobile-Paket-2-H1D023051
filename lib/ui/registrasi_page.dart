import 'dart:convert';
import 'package:flutter/material.dart';
import '../helpers/api.dart';
import '../helpers/api_url.dart';
import 'login.dart';

class RegistrasiPage extends StatefulWidget {
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _registrasi() async {
    print("REGISTER BUTTON PRESSED");

    var body = {
      "nama": nama.text,
      "email": email.text,
      "password": password.text,
    };

    var response = await Api().postJson(ApiUrl.registrasi, body);
    print("REGISTER RAW RESPONSE: ${response.body}");

    try {
      var jsonObj = json.decode(response.body);

      if (jsonObj["status"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registrasi berhasil")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registrasi gagal: ${jsonObj['message']}")),
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
        title: Text("Registrasi Bunga Mart"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nama,
              decoration: InputDecoration(labelText: "Nama"),
            ),
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
              onPressed: _registrasi,
              child: Text("Registrasi"),
            ),
          ],
        ),
      ),
    );
  }
}
