# Aplikasi Inventaris Responsi 2 Mobile

**Nama:** Bunga Devina Firdaus  
**NIM:** H1D023051  
**Shift Baru:** D  
**Shift Asal:** A  

---

## Video Demo Aplikasi
[Link Video Demo](https://github.com/user-attachments/assets/e110c206-60d5-404d-a33c-0a96994b726e)


---

## Deskripsi Aplikasi
Aplikasi Inventaris Bunga Mart dibuat menggunakan **Flutter** untuk mobile dan **API berbasis PHP**. Aplikasi ini berfungsi untuk mengelola inventaris toko, dengan fitur:

- Login & Registrasi
- Menampilkan daftar inventaris
- Menambah, mengubah, dan menghapus item inventaris

---

## Spesifikasi API
| Method | Endpoint                     | Keterangan                          |
|--------|-----------------------------|------------------------------------|
| POST   | `/login`                     | Login user (mengembalikan token)   |
| POST   | `/registrasi`                | Registrasi user                     |
| GET    | `/inventories`               | Mengambil daftar inventaris         |
| POST   | `/inventories`               | Menambahkan inventaris baru         |
| PUT    | `/inventories/{id}`          | Mengupdate inventaris               |
| DELETE | `/inventories/{id}`          | Menghapus inventaris                |

**Catatan:**
- Semua request login/registrasi menggunakan **JSON**  
- Semua request inventaris menggunakan **JSON** + header **Authorization Bearer Token**  

---

## Penjelasan Kode

### `helpers/api.dart`
Class ini menangani semua request HTTP:
- `get(String url)` → GET request dengan token  
- `postJson(String url, Map body, {bool withToken = true})` → POST JSON  
- `putJson(String url, Map body)` → PUT JSON  
- `delete(String url)` → DELETE request  

### `helpers/api_url.dart`
Berisi URL endpoint API:
- `baseUrl` → URL utama API  
- `login`, `registrasi`, `listInventories`, `createInventory`, `updateInventory(id)`, `deleteInventory(id)`  

### `model/inventory.dart`
Class model inventaris:
- Properties: `id`, `nama`, `harga`, `jumlah`, `tanggalMasuk`, `tanggalKedaluwarsa`  
- `fromJson(Map<String, dynamic> json)` → konversi JSON menjadi objek Inventory  

### `bloc/inventory_bloc.dart`
Mengelola data inventaris:
- `getInventories()` → mengambil daftar inventaris  
- `add(Inventory item)` → menambah item baru  
- `update(Inventory item)` → mengupdate item  
- `delete(int id)` → menghapus item  

### `ui/login.dart`
- Form login email & password  
- Memanggil `Api().postJson()` untuk login  
- Menyimpan token ke `UserInfo()`  
- Redirect ke `InventoryPage` jika sukses  

### `ui/registrasi.dart`
- Form registrasi nama, email & password  
- Memanggil `Api().postJson()` untuk registrasi  
- Redirect ke halaman login jika sukses  

### `ui/inventory_page.dart`
- Menampilkan daftar inventaris  
- FAB untuk menambah item  
- Klik item → menuju `InventoryDetail`  
- Drawer untuk navigasi & logout  

### `ui/inventory_form.dart`
- Form tambah atau edit inventaris  
- Input nama, harga, jumlah, tanggal masuk & kedaluwarsa  
- Mengirim data ke API via `InventoryBloc.add()` atau `InventoryBloc.update()`  
- Refresh list otomatis setelah submit  

### `ui/inventory_detail.dart`
- Menampilkan detail item  
- Tombol Edit → menuju `InventoryForm` dengan data item  
- Tombol Hapus → memanggil `InventoryBloc.delete()`  
