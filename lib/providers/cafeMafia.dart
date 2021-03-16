import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mafia/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CafeMafia extends ChangeNotifier {
  static const String _HOST = '10.0.2.2:8000', _PATH = 'api/v2/';
  static const String _URL = 'http://' + _HOST + '/' + _PATH;
  User _user;
  SharedPreferences _prefs;

  Future<bool> initCafeCheck() async {
    _prefs = await SharedPreferences.getInstance();
    String _token = _prefs.getString('token');
    if (_token != null) {
      final response = await http.get(
        _URL + 'auth',
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Accept': 'application/json'
        },
      );
      _user = userDecode(response.body);
      _user.token = _token;
      return true;
    }
    return false;
  }

  get user => _user;

  Future<bool> signup(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.http(_HOST, _PATH + 'auth/signup'),
      headers: {'Accept': 'application/json'},
      body: userData,
    );

    if (response.statusCode == 200) {
      _user = userDecode(response.body);
      _prefs.setString('token', _user.token);
      return true;
    } else if (response.statusCode == 409)
      throw Exception('Douplicate');
    else
      throw Exception('Failed to create User.');
  }

  Future<bool> login(Map<String, dynamic> userData) async {
    userData.remove('name');
    final response = await http.post(
      Uri.http(_HOST, _PATH + 'auth/login'),
      headers: {'Accept': 'application/json'},
      body: userData,
    );
    print(response.body);
    if (response.statusCode == 200) {
      _user = userDecode(response.body);
      return true;
    } else if (response.statusCode == 401)
      throw Exception('Unauthorized');
    else
      throw Exception('Failed to login.');
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
