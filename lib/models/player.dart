import 'package:Mafia/models/role.dart';
import 'package:flutter/material.dart';

class Player {
  String name, status;
  Role role;

  Player({
    @required this.name,
    @required this.role,
    @required this.status,
  });
  @override
  String toString() {
    return "name: " + name + " role: " + role.name;
  }
}
