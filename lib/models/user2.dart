
// part 'user.g.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class User {
  final String? userId;
  final String? email;
  final String? phone;
  final String? login;
  final String? password;
  final String? photo;
  final String? username;
  final String? birthday;
  final String? phone2;
  final String? car;
  // final List<String>? cars;
  final String? address;

  User(
      {this.userId,
        this.email,
        this.phone,
        this.login,
        this.password,
        this.photo,
        this.username,
        this.birthday,
        this.phone2,
        this.car,
        // this.cars,
        this.address});

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      userId: jsonData['userId'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      login: jsonData['login'],
      password: jsonData['password'],
      photo: jsonData['photo'],
      username: jsonData['username'],
      birthday: jsonData['birthday'],
      phone2: jsonData['phone2'],
      car: jsonData['car'],
      // cars: jsonData['cars'],
      address: jsonData['address'],
    );

  }

  @override
  String toString() => 'UserId: $userId, Phone: $phone, Email: $email';

// Future<User> getUser() async {
//  const url = 'http://localhost/test/edit.php';
//  // const url = 'https://about.google/static/data/locations.json';
//
//   final response = await http.post(Uri.parse(url));
//
//   if(response.statusCode == 200) {
//     return User.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
// }

  // Future<List<User>> getUser() async {
  //   final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> userJson = json.decode(response.body);
  //     return userJson.map((json) => User.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Error fetching users');
  //   }
  // }

  Future<List<User>> getUser(userId) async {
    print('getUser user2');
    print('userId: $userId');

    String apiurl = "http://localhost/test/get_user.php"; // get jsonplaceholder
    // final response = await http.post(Uri.parse(apiurl), body:{'userId': userId});
    var birthday;
    var phone;
    var email;
    final response = await http.post(Uri.parse(apiurl), body:{'userId': userId, 'phone': phone,'email': email, 'birthday': birthday},headers: {'Accept':'application/json, charset=utf-8',"Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS"});

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      final List<dynamic> userJson = json.decode(response.body);
      print('userJson user2');
      print(userJson);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['userId'] = this.userId;
//   data['email'] = this.email;
//   data['phone'] = this.phone;
//   data['login'] = this.login;
//   data['password'] = this.password;
//   if (this.photo != null) {
//     data['photo'] = this.photo!.toJson();
//   }
//   data['name'] = this.name;
//   data['birthday'] = this.birthday;
//   data['phone2'] = this.phone2;
//   data['car'] = this.car;
//   data['address'] = this.address;
//   return data;
// }
}

// class XFile {
//     XFileImage? photo1;
//
// }
//
class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}

// class Cars {
//   String? photo1;
//   String? photo2;
//   String? photo3;
//
//
//   Cars({this.photo1, this.photo2, this.photo3});
//
//   Cars.fromJson(Map<String, dynamic> json) {
//     photo1 = json['photo1'];
//     photo2 = json['photo2'];
//     photo3 = json['photo3'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['photo1'] = this.photo1;
//     data['photo2'] = this.photo2;
//     data['photo3'] = this.photo2;
//     return data;
//   }
// }
//
// class User {
//
//   late dynamic userId;
//   late dynamic name;
//   late dynamic login;
//   late dynamic birthday;
//   late dynamic email;
//   late dynamic password;
//   late dynamic phone;
//   late dynamic type;
//   late dynamic car;
//   late final dynamic token;
//   late final dynamic renewalToken;
//   late final dynamic photo;
//   late final dynamic cars;
//
//   User({
//     this.userId = '5555',
//     this.name = 'ivan',
//     this.login = 'ivan@mail.ru"',
//     this.birthday = '19.04.1972',
//     this.email = 'ivan@mail.ru"',
//     this.phone = '123456789',
//     this.password = '123',
//     this.type = 'text',
//     this.car = 'cadillac',
//     this.token = '123',
//     this.renewalToken = '123456',
//     this.photo = 'assets/images/avatar.png',
//     this.cars = const [ 'assets/images/cadillac-eldorado.png',
//       "assets/images/cadillac-escalada.png",
//       "assets/images/cadillac-orange.png",
//     ],
//   });
//
//
//   factory User.fromJson(Map<String, dynamic> responseData) {
//     return User(
//         userId: responseData['userId'],
//         name: responseData['name'],
//         login: responseData['login'],
//         birthday: responseData['birthday'],
//         email: responseData['email'],
//         phone: responseData['phone'],
//         password: responseData['password'],
//         type: responseData['type'],
//         token: responseData['access_token'],
//         renewalToken: responseData['renewal_token'],
//         photo: responseData['photo'],
//         cars: responseData['cars'],
//     );
//   }
//
//   @override
//   String toString() => 'Phone: $phone, Email: $email';
// }
