import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mafia/models/user.dart';

class CafeMafia extends ChangeNotifier {
  static const String HOST = '10.0.2.2:8000', PATH = 'api/v2/';
  User _user;
  get user => _user;

  Future<bool> signup(Map<String, dynamic> userData) async {
    print(userData);
    final response = await http.post(
      Uri.http(HOST, PATH + 'auth/signup'),
      headers: {'Accept': 'application/json'},
      body: userData,
    );

    if (response.statusCode == 200) {
      _user = userDecode(response.body);
      return true;
    } else if (response.statusCode == 409)
      throw Exception('Douplicate');
    else
      throw Exception('Failed to create User.');
  }

  Future<bool> login(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.https(HOST, PATH + 'auth/login'),
      headers: {'Accept': 'application/json'},
      body: userData,
    );
    if (response.statusCode == 200) {
      _user = userDecode(response.body);
      return true;
    } else if (response.statusCode == 409)
      throw Exception('Douplicate');
    else
      throw Exception('Failed to create User.');
  }
  // Future<Album> createAlbum(String title) async {
  //   final response = await http.post(
  //     Uri.https('jsonplaceholder.typicode.com', 'albums'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     return Album.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create album.');
  //   }
  // }

  // Future<http.Response> createAlbum(String title) {
  //   return http.post(
  //     Uri.https('jsonplaceholder.typicode.com', 'albums'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //     }),
  //   );
  // }

  // Future<User> fetchAlbum() async {
  //   final response =
  //       await http.get('https://jsonplaceholder.typicode.com/albums/1');

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     print(jsonDecode(response.body));
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  User userDecode(data) {
    Map user = jsonDecode(data)['data'];
    user['user']['token'] = user['token'];
    user = user['user'];
    return User.fromJson(user);
  }
}
