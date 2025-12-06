import 'package:flutter/material.dart';
import '../model/inventory.dart';
import '../bloc/inventory_bloc.dart';
import 'inventory_form.dart';

class InventoryDetail extends StatelessWidget {
  final Inventory item;

  InventoryDetail({required this.item});

  void _hapus(BuildContext context) async {
    bool success = await InventoryBloc.delete(int.parse(item.id!));

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal menghapus")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Inventaris Bunga Mart")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: ${item.nama}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Harga: ${item.harga}"),
            Text("Jumlah: ${item.jumlah}"),
            Text("Tanggal Masuk: ${item.tanggalMasuk}"),
            Text("Kedaluwarsa: ${item.tanggalKedaluwarsa}"),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventoryForm(item: item),
                      ),
                    ).then((value) => Navigator.pop(context));
                  },
                  child: Text("Edit"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _hapus(context),
                  child: Text("Hapus"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
