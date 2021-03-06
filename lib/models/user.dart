import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../variables.dart';


class UsersList {
  List<User>? users;
  UsersList({required this.users});

  factory UsersList.fromJson(Map<String, dynamic> json) {
    print('from json usersList');
    print(json);
    print(json['users']);
    // if (json['users'] != null) {
    var usersJson = json['users'] as List;

    print('usersJson');
    print(usersJson);

    List<User> usersList = usersJson.map((i) => User.fromJson(i)).toList();

    print('usersList');
    print(usersList);
    print(usersList.runtimeType);

    return UsersList(
      users: usersList,
    );
    //}

    // users = <Users>[];
    // json['users'].forEach((v) {
    //   users!.add(new Users.fromJson(v));
    // });
  }
}

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.users != null) {
//     data['users'] = this.users!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
//}


class User {
  late final String id;
  late final String userId;
  late final String phone;
  late final String email;
  late final String username;
  late final String birthday;

  late final String login;
  // late final String password;
  late final String carname;

  User({
    required this.id,
    required this.userId,
    required this.phone,
    required this.email,
    required this.username,
    required this.birthday,

    required this.login,
    // required this.password,
    required this.carname
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      userId: json['userId'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      birthday: json['birthday'] as String,

      login: json['login'] as String,
      // password: json['password'] as String,
      carname: json['carname'] as String,
    );

  }

  Future<UsersList> getUsersList() async {
    // const url = 'https://about.google/static/data/locations.json';
    // const url = 'http://localhost/test/users_list.php';
    const url = baseUrl + '/test/users_list.php';
    final response = await http.get(Uri.parse(url));
print('response body user getUsersList');
print('response body');
    if(response.statusCode == 200) {
      return UsersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['phone'] = phone;
    data['email'] = email;
    data['username'] = username;
    data['birthday'] = birthday;

    data['login'] = login;
    // data['password'] = this.password;
    data['carname'] = carname;
    return data;
  }
}

Future<UsersList> readJson() async {
  final String response = await rootBundle.loadString('assets/users.json');
  final data = await json.decode(response);
  return UsersList.fromJson(json.decode(response));

}

