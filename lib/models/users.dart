class Users {
  String name = "";
  String email = "";
  String username = "";
  String phone = "";
  String token = "";

  Users({
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.token,
  });

  Users.fromMap(Map<String, dynamic> users) {
    name = users["name"];
    email = users["email"];
    username = users["username"];
    phone = users["phone"];
    token = users["token"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["email"] = email;
    data["username"] = username;
    data["phone"] = phone;
    data["token"] = token;
    return data;
  }
}
