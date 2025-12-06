class ApiUrl {
  static const String baseUrl = "http://192.168.1.14/supermarket-api/public";

  static const String registrasi = "$baseUrl/registrasi";
  static const String login = "$baseUrl/login";

  static const String listInventories = "$baseUrl/inventories";
  static const String createInventory = "$baseUrl/inventories";

  static String updateInventory(int id) => "$baseUrl/inventories/$id";
  static String deleteInventory(int id) => "$baseUrl/inventories/$id";
  static String showInventory(int id) => "$baseUrl/inventories/$id";
}
