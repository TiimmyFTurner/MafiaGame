import 'package:Mafia/pages/howToPlay.dart';
import 'package:Mafia/pages/setPlayers.dart';
import 'package:Mafia/pages/setting.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("asset/images/homeWP.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: 55,
              child: Hero(
                tag: "play",
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "شروع",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SetPlayers()),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).accentColor,
                child: Text(
                  "روش بازی",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HowToPlay()),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              height: 40,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).accentColor,
                child: Text(
                  "تنظیمات",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      );
}
