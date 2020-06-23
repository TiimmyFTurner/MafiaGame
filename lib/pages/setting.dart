import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool platformDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget themeNote() => platformDarkMode
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
                "در صورت فعال بودن تم تاریک دستکاه نمیتوانید تم را تغییر دهید"))
        : Container();
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
                  value: platformDarkMode
                      ? true
                      : Provider.of<Settings>(context).darkMode,
                  onChanged: platformDarkMode
                      ? null
                      : (value) => Provider.of<Settings>(context, listen: false)
                          .switchDarkMode = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text("تم تاریک"),
              ),
            ],
          ),
          themeNote(),
          Divider(height: 1)
        ],
      ),
    );
  }
}
