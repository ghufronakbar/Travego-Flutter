// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConfig {
  static const baseUrl = "http://192.168.100.24:5001";
  // ! pastikan untuk mengubah IP ini dengan IP server
  static const String url = "$baseUrl/api";
  static const String tour_package_storage =
      "$baseUrl/storage/wisata";
  static const String transport_storage =
      "$baseUrl/storage/transport";
  static const String restaurant_storage =
      "$baseUrl/storage/rumahmakan";

  late http.Client client;

  // ? Login
  Future<Map> login(String username, String password) async {
    try {
      client = http.Client();
      final Map body = {
        "username": username,
        "password": password,
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/login"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        throw Exception(response.body);
      }
      Map result = jsonDecode(response.body);
      return Future.value(result);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Register
  Future<Map> register(
    String name,
    String email,
    String password,
    String username,
    String phone,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "nama": name,
        "email": email,
        "username": username,
        "password": password,
        "no_hp": phone,
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/register"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
        },
        body: body,
      )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Profile
  Future<Map> profile(
    String token,
  ) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/datadiri"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Edit Profile
  Future<Map> editProfile(
    String name,
    String email,
    String username,
    String phone,
    String token,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "nama": name,
        "email": email,
        "username": username,
        "no_hp": phone,
      };
      http.Response response = await client
          .put(
            Uri.parse("${url}/user/edituser"),
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'authorization': 'bearer $token',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Change Password
  Future<void> changePassword(
    String username,
    String old_pass,
    String new_pass,
    String token,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "username": username,
        "new_password": new_pass,
        "old_password": old_pass,
      };
      http.Response response = await client
          .put(
            Uri.parse("${url}/user/changepassword"),
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'authorization': 'bearer $token',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode != 200 || response.statusCode != 201) {
        throw Exception(response.body);
      }
    } catch (error) {
      return Future.error(error);
    }
  }


  // ? Get Tour Packages
  Future<List> getListTourPackages() async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/getPaketwisata"),
      )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Tours
  Future<List> getListTours() async {
    try {
      client = http.Client();
      http.Response response = await client
          .get(
            Uri.parse("${url}/user/getWisata"),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Transports
  Future<List> getListTransports() async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/getkendaraan"),
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get Restaurants
  Future<List> getListRestaurants() async {
    try {
      client = http.Client();
      http.Response response = await client
          .get(
            Uri.parse("${url}/user/getrumahmakan"),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Get List Transaction Package
  Future<List> getListTransactionPackage(String token) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/viewPesanan"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body)["data"];
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> getListTransactionPackageById(String token, String id) async {
    try {
      client = http.Client();
      http.Response response = await client.get(
        Uri.parse("${url}/user/viewPesanan/$id"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Add Transaction Tour Package
  Future<Map> addTransactionPackage(
    String token,
    DateTime order_date,
    String note,
    int package,
    int qty,
    int price,
    int subtotal,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "tgl_pesanan": order_date.toString(),
        "catatan": note,
        "id_paket": package.toString(),
        "qty": qty.toString(),
        "harga": price.toString(),
        "sub_total": subtotal.toString(),
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/createPesananWithDetails"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
        body: body,
      )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  // ? Add Transaction Tour Transport
  Future<Map> addTransactionTransport(
    String token,
    int transport,            
    String location,
    DateTime rent_date,
  ) async {
    try {
      client = http.Client();
      final Map body = {
        "tgl_pesanan": DateTime.now().toString(),
        "id_kendaraan": transport.toString(),                        
        "lokasi_penjemputan": location,
        "waktu_penjemputan": rent_date.toString(),
      };
      http.Response response = await client.post(
        Uri.parse("${url}/user/createPesananWithDetailsKendaraan"),
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'authorization': 'bearer $token',
        },
        body: body,
      )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map result = jsonDecode(response.body);
        return Future.value(result);
      }
      throw Exception(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }
}
