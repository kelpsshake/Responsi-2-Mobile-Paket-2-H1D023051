import 'package:flutter/material.dart';
import '../model/inventory.dart';
import '../bloc/inventory_bloc.dart';

class InventoryForm extends StatefulWidget {
  final Inventory? item; // null = tambah, tidak null = edit
  InventoryForm({this.item});

  @override
  _InventoryFormState createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _hargaController;
  late TextEditingController _jumlahController;
  late TextEditingController _tanggalMasukController;
  late TextEditingController _tanggalKedaluwarsaController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.item?.nama ?? '');
    _hargaController = TextEditingController(text: widget.item?.harga.toString() ?? '');
    _jumlahController = TextEditingController(text: widget.item?.jumlah.toString() ?? '');
    _tanggalMasukController = TextEditingController(text: widget.item?.tanggalMasuk ?? '');
    _tanggalKedaluwarsaController = TextEditingController(text: widget.item?.tanggalKedaluwarsa ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _jumlahController.dispose();
    _tanggalMasukController.dispose();
    _tanggalKedaluwarsaController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    int harga = int.tryParse(_hargaController.text) ?? 0;
    int jumlah = int.tryParse(_jumlahController.text) ?? 0;

    Inventory newItem = Inventory(
      id: widget.item?.id,
      nama: _namaController.text,
      harga: harga,
      jumlah: jumlah,
      tanggalMasuk: _tanggalMasukController.text,
      tanggalKedaluwarsa: _tanggalKedaluwarsaController.text,
    );

    bool success;
    if (widget.item == null) {
      success = await InventoryBloc.add(newItem);
      print("ADD SUCCESS: $success");
    } else {
      success = await InventoryBloc.update(newItem);
      print("UPDATE SUCCESS: $success");
    }

    if (success) {
      Navigator.pop(context, true); // kembali ke InventoryPage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Inventaris" : "Tambah Inventaris")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value) => value!.isEmpty ? "Nama wajib diisi" : null,
              ),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Harga wajib diisi" : null,
              ),
              TextFormField(
                controller: _jumlahController,
                decoration: InputDecoration(labelText: "Jumlah"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Jumlah wajib diisi" : null,
              ),
              TextFormField(
                controller: _tanggalMasukController,
                decoration: InputDecoration(labelText: "Tanggal Masuk (yyyy-mm-dd)"),
              ),
              TextFormField(
                controller: _tanggalKedaluwarsaController,
                decoration: InputDecoration(labelText: "Kedaluwarsa (yyyy-mm-dd)"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(isEdit ? "Update" : "Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
