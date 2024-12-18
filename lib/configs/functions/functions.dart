// ignore_for_file: non_constant_identifier_names

import 'package:trevago_app/configs/api/api.dart';
import 'package:trevago_app/configs/preferences/preferences.dart';
import 'package:trevago_app/models/users.dart';

Preferences preferences = Preferences();
ApiConfig api = ApiConfig();

Future<Users> getExistingUser() async {
  final Users userInfo = await preferences.getUserProfile();
  return userInfo;
}

Future<Users> loginAction(
  String username,
  String password,
) async {
  try {
    final Map loginResponse = await api.login(username, password);
    final Map profileResponse = await api.profile(loginResponse["token"]);
    await preferences.setUserLogin(Users(
      token: loginResponse["token"] ?? "",
      username: profileResponse["username"],
      phone: profileResponse["no_hp"] ?? "",
      name: profileResponse["nama"] ?? "",
      email: profileResponse["email"] ?? "",
    ));
    final Users userInfo = await preferences.getUserProfile();
    if (userInfo.token.isEmpty) {
      throw "Credentials not match";
    }
    return userInfo;
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> registerAction(
  String name,
  String email,
  String password,
  String username,
  String phone,
) async {
  try {
    final Map registerResponse =
        await api.register(name, email, password, username, phone);
    return registerResponse;
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> logoutAction() async {
  try {
    await preferences.deleteUser();
  } catch (error) {
    return Future.error(error);
  }
}

Future<Users> getProfile() async {
  try {
    final Users oldUserInfo = await preferences.getUserProfile();
    final Map profileResponse = await api.profile(oldUserInfo.token);
    await preferences.setUserLogin(Users(
      token: oldUserInfo.token,
      username: profileResponse["username"],
      phone: profileResponse["no_hp"] ?? "",
      name: profileResponse["nama"] ?? "",
      email: profileResponse["email"] ?? "",
    ));
    final Users userInfo = await preferences.getUserProfile();
    return Future.value(userInfo);
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> editProfile(
  String name,
  String phone,
  String email,
  String username,
  String token,
) async {
  try {
    final Map newProfile =
        await api.editProfile(name, email, username, phone, token);
    await preferences.setUserLogin(Users(
      token: token,
      username: newProfile["username"] ?? "s",
      phone: newProfile["no_hp"] ?? "",
      name: newProfile["nama"] ?? "",
      email: newProfile["email"] ?? "",
    ));
  } catch (error) {
    return Future.error(error);
  }
}

Future<void> changePassword(
  String username,
  String old_pass,
  String new_pass,
  String token,
) async {
  try {
    await api.changePassword(username, old_pass, new_pass, token);
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTourPackages() async {
  try {
    final List packages = await api.getListTourPackages();
    return packages;
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTours() async {
  try {
    final List packages = await api.getListTours();
    return packages;
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTransports() async {
  try {
    final List transports = await api.getListTransports();
    return transports;
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getRestaurants() async {
  try {
    final List restaurants = await api.getListRestaurants();
    return restaurants;
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> newTransactionPackage(
  DateTime order_date,
  String note,
  int package,
  int qty,
  int price,
  int subtotal,
) async {
  try {
    final Users userInfo = await preferences.getUserProfile();
    return await api.addTransactionPackage(
      userInfo.token,
      order_date,
      note,
      package,
      qty,
      price,
      subtotal,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<Map> newTransactionTransport(
  int transport,
  String location,
  DateTime rent_date,
) async {
  try {
    final Users userInfo = await preferences.getUserProfile();
    return await api.addTransactionTransport(
      userInfo.token,
      transport,
      location,
      rent_date,
    );
  } catch (error) {
    return Future.error(error);
  }
}

Future<List> getTransactionsPackage() async {
  try {
    final Users userInfo = await preferences.getUserProfile();
    final List transports = await api.getListTransactionPackage(
      userInfo.token,
    );
    return Future.value(transports);
  } catch (error) {
    return Future.error(error);
  }
}

Future<bool> getTransactionsPackageById(String id) async {
  try {
    final Users userInfo = await preferences.getUserProfile();
    final bool transports =
        await api.getListTransactionPackageById(userInfo.token, id);
    return Future.value(transports);
  } catch (error) {
    return Future.error(error);
  }
}
