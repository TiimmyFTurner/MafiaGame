import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Divider(height: 1),
          Center(
            child: Column(
              children: [
                Text(
                  "\nMafia Game 3.0.0\nCopyright \u00a9 2020 Timothy F. Turner (Arman Askari Sh.)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                InkWell(
                  child: Text("TiimmyFTurner@gmail.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                  onTap: _sendMail,
                ),
                InkWell(
                  child: Text("T.me/TiimmyFTurner",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                  onTap: _openTelegram,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _sendMail() async {
    const url = 'mailto:TiimmyFTurner@gmail.com?subject=MafiaApp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openTelegram() async {
    const url = 'https://T.me/TiimmyFTurner';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
