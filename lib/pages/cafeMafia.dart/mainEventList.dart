import 'package:flutter/material.dart';
import 'package:mafia/providers/providers.dart';

class MainEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Provider.of<CafeMafia>(context).user.name),
      ),
    );
  }
}
