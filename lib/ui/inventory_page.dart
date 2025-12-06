import 'package:flutter/material.dart';
import 'package:responsi2mobile_paket2_h1d023051/helpers/user_info.dart';
import '../model/inventory.dart';
import '../bloc/inventory_bloc.dart';
import 'inventory_form.dart';
import 'inventory_detail.dart';
import 'login.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late Future<List<Inventory>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = InventoryBloc.getInventories();
  }

  // fungsi refresh data dari API
  void _refreshData() async {
    print("Refreshing data...");
    var data = await InventoryBloc.getInventories();
    print("REFRESH DATA NAMES: ${data.map((e) => e.nama).toList()}");
    setState(() {
      futureData = Future.value(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventaris Bunga Mart"),
       backgroundColor: Colors.green, // ← ini yang bikin hijau
        ),

      // FAB tambah data
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => InventoryForm()),
          ).then((value) {
            print("Returned from Form: $value");
            if (value == true) _refreshData(); // reload list kalau sukses
          });
        },
      ),

      body: FutureBuilder<List<Inventory>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.green));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Belum ada data inventaris"));
          }

          var list = snapshot.data!;
          print("Displaying list: ${list.map((e) => e.nama).toList()}");

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              var item = list[i];
              return ListTile(
                title: Text(item.nama ?? "-"),
                subtitle: Text("Jumlah: ${item.jumlah ?? 0}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => InventoryDetail(item: item)),
                  ).then((value) => _refreshData()); // reload setelah edit/hapus
                },
              );
            },
          );
        },
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('Menu Bunga Mart', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: Icon(Icons.inventory_2),
              title: Text('Inventaris'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => InventoryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Tambah Inventaris'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InventoryForm()),
                ).then((value) => _refreshData());
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout'),
              onTap: () async {
                await UserInfo().logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
