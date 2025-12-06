class Inventory {
  String? id;
  String? nama;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  String? tanggalKedaluwarsa;

  Inventory({
    this.id,
    this.nama,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.tanggalKedaluwarsa,
  });

  // Parsing dari JSON (dari API)
  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json["id"]?.toString(),
      nama: json["nama"] ?? '',
      harga: int.tryParse(json["harga"]?.toString() ?? '0') ?? 0,
      jumlah: int.tryParse(json["jumlah"]?.toString() ?? '0') ?? 0,
      tanggalMasuk: json["tanggal_masuk"] ?? '',
      tanggalKedaluwarsa: json["tanggal_kedaluwarsa"] ?? '',
    );
  }

  // Mengubah object menjadi Map untuk POST/PUT
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama ?? '',
      "harga": harga?.toString() ?? '0',
      "jumlah": jumlah?.toString() ?? '0',
      "tanggal_masuk": tanggalMasuk ?? '',
      "tanggal_kedaluwarsa": tanggalKedaluwarsa ?? '',
    };
  }
}
