import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mafia/models/event.dart';
import 'package:mafia/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CafeMafia extends ChangeNotifier {
  static const String _HOST = '10.0.2.2:8000', _PATH = 'api/v2/';
  static const String _URL = 'http://' + _HOST + '/' + _PATH;
  User _user;
  SharedPreferences _prefs;
  String _token;

  Future<bool> initCafeCheck() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('token');
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

  User userDecode(data) {
    Map user = jsonDecode(data)['data'];
    user['user']['token'] = user['token'];
    user = user['user'];
    return User.fromJson(user);
  }

  Future<List<Event>> eventList() async {
    final response = await http.get(_URL + 'events', headers: {
      'Authorization': 'Bearer ' + _token,
      'Accept': 'application/json'
    });
    final List responseMap = jsonDecode(response.body)['data'];
    List<Event> eventList = [];
    responseMap.forEach((element) {
      eventList.add(Event.fromJson(element));
    });
    return eventList;
  }
}
