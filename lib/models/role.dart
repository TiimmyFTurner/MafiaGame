import 'package:flutter/material.dart';

class Role {
  String name, type, job;
  int order;

  Role({
    @required this.name,
    @required this.type,
    @required this.job,
    @required this.order,
  });

  @override
  String toString() {
    return "name: " + name + " type: " + type + " order: " + order.toString();
  }
}
