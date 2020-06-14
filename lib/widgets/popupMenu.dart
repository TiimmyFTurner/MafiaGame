import 'package:Mafia/pages/home.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            "بازیابی بازیکنان",
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "خانه",
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          Provider.of<RolesNPlayers>(context, listen: false)
              .recoverLastPlayers();
        } else if (value == 2) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        }
      },
    );
  }
}
