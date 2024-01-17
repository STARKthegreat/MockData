import 'dart:convert';

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User {
  String id;
  String? avatar;
  String firstName;
  String lastName;
  String email;
  String role;

  User({
    required this.id,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        role: json["role"],
      );
  static List<User> fromJsonToList(userDataJson) {
    var list = <User>[];
    for (var usr in userDataJson) {
      list.add(
        User(
          id: usr['id'],
          email: usr['email'],
          firstName: usr['first_name'],
          lastName: usr['last_name'],
          role: usr['role'],
          avatar: usr['avatar'],
        ),
      );
    }
    return list;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "avatar": avatar,
      };
}
