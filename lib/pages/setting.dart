import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تنظیمات"), centerTitle: true),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Switch(
                  activeColor: Theme.of(context).accentColor,
                  value: Provider.of<Settings>(context).darkMode,
                  onChanged: (value) =>
                      Provider.of<Settings>(context, listen: false)
                          .switchDarkMode = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text("تم تیره"),
              ),
            ],
          ),
          Divider(height: 1)
        ],
      ),
    );
  }
}
