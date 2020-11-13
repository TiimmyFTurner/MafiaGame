import 'dart:async';
import 'package:Mafia/pages/lock.dart';
import 'package:flutter/material.dart';

void lockTimer(BuildContext context) {
  Timer(Duration(minutes: 5), () {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => Lock()))
        .then((value) => lockTimer(context));
  });
}
