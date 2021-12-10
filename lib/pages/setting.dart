import 'package:mafia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool platformDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget themeNote() => platformDarkMode
        ? Padding(
            padding: EdgeInsets.only(right: 15, left: 12, bottom: 15),
            child: Text(
                "در صورت فعال بودن تم تاریک دستکاه نمیتوانید تم را تغییر دهید"))
        : Container();
    Widget starRoleNote() => Provider.of<RolesNPlayers>(context).limitLock
        ? Padding(
            padding: EdgeInsets.only(right: 15, left: 12, bottom: 15),
            child: Text(
                "در صورت فعال بودن محدودیت نسبت نمیتوانید از نقش های ستاره دار استفاده کنید"))
        : Container();
    return Scaffold(
      appBar: AppBar(title: Text("تنظیمات"), centerTitle: true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12),
            Card(
              child: SwitchListTile(
                title: Text("تم تاریک"),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: platformDarkMode
                    ? true
                    : Provider.of<Settings>(context).darkMode,
                onChanged: platformDarkMode
                    ? null
                    : (value) => Provider.of<Settings>(context, listen: false)
                        .switchDarkMode = value,
              ),
            ),
            themeNote(),
            Card(
              child: SwitchListTile(
                title: Text("محدودیت نسبت "),
                subtitle: Text(
                  "به طور معمول نسبت تعداد مافیا به شهروند یک به دو میباشد در صورت نیاز برای سناریو های مختلف میتوانید این محدودیت را غیر فعال کنید",
                ),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: Provider.of<RolesNPlayers>(context).limitLock,
                onChanged: (value) =>
                    Provider.of<RolesNPlayers>(context, listen: false)
                        .limitLock = value,
              ),
            ),
            Card(
              child: SwitchListTile(
                title: Text("نقش ستاره دار"),
                subtitle: Text(
                  'در صورت نیاز استفاده از یک نقش بیش از یک بار برای سناریو های مختلف میتوانید این ویژگی را فعال کنید',
                ),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: Provider.of<RolesNPlayers>(context).starRole,
                onChanged: Provider.of<RolesNPlayers>(context).limitLock
                    ? null
                    : (value) =>
                        Provider.of<RolesNPlayers>(context, listen: false)
                            .starRole = value,
              ),
            ),
            starRoleNote(),
            Center(
              child: Column(
                children: [
                  Text(
                    "\nMafia Game 3.7.0\nCopyright \u00a9 2021 Timothy F. Turner (Arman Askari Sh.)",
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
