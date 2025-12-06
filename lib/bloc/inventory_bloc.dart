import 'dart:convert';
import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../model/inventory.dart';

class InventoryBloc {

  static Future<List<Inventory>> getInventories() async {
    var response = await Api().get(ApiUrl.listInventories);

    print("GET LIST RESPONSE: ${response.body}");

    if (response.statusCode != 200) return [];

    var jsonObj = json.decode(response.body);
    List list = jsonObj['data'];
    return list.map((e) => Inventory.fromJson(e)).toList();
  }

  static Future<bool> add(Inventory item) async {
    var body = {
      "nama": item.nama ?? "",
      "harga": item.harga.toString(),
      "jumlah": item.jumlah.toString(),
      "tanggal_masuk": item.tanggalMasuk ?? "",
      "tanggal_kedaluwarsa": item.tanggalKedaluwarsa ?? ""
    };

    // Gunakan postJson agar response selalu valid
    var response = await Api().postJson(ApiUrl.createInventory, body);

    print("BODY SENT: ${jsonEncode(body)}");
    print("ADD RESPONSE: ${response.body}");
    print("STATUS CODE: ${response.statusCode}");

    return response.statusCode == 201; // created
  }

  static Future<bool> update(Inventory item) async {
    var body = {
      "nama": item.nama ?? "",
      "harga": item.harga.toString(),
      "jumlah": item.jumlah.toString(),
      "tanggal_masuk": item.tanggalMasuk ?? "",
      "tanggal_kedaluwarsa": item.tanggalKedaluwarsa ?? ""
    };

    // Gunakan putJson agar response selalu valid
    var response = await Api().putJson(
      ApiUrl.updateInventory(int.parse(item.id!)),
      body,
    );

    print("BODY SENT: ${jsonEncode(body)}");
    print("UPDATE RESPONSE: ${response.body}");
    print("STATUS CODE: ${response.statusCode}");

    return response.statusCode == 200;
  }

  static Future<bool> delete(int id) async {
    var response = await Api().delete(ApiUrl.deleteInventory(id));

    print("DELETE RESPONSE: ${response.body}");
    print("STATUS CODE: ${response.statusCode}");

    return response.statusCode == 200;
  }
}
