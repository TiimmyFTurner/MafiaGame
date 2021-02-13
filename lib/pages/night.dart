import 'package:Mafia/helpers/lockScreenTimer.dart';
import 'package:Mafia/helpers/persianNumber.dart';
import 'package:Mafia/pages/day.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/inGameAppBar.dart';
import 'package:Mafia/widgets/listItemNight.dart';
import 'package:flutter/material.dart';

class Night extends StatefulWidget {
  @override
  _NightState createState() => _NightState();
}

class _NightState extends State<Night> {
  @override
  void initState() {
    lockTimer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List _players = Provider.of<RolesNPlayers>(context).playersWithRoles;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: InGameAppBar(
            title:
                "شب ${persianNumber(Provider.of<RolesNPlayers>(context).night)}"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _players.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                      index < _players.length
                          ? ListItemNight(_players[index], index)
                          : SizedBox(height: 75),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Theme.of(context).backgroundColor, Colors.transparent],
            ),
          ),
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 45,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Theme.of(context).accentColor,
                    child: Row(
                      children: [
                        Text("موزیک", textDirection: TextDirection.rtl),
                        Icon(
                          Provider.of<Music>(context).isPlaying
                              ? Icons.stop
                              : Icons.play_arrow,
                        ),
                      ],
                    ),
                    onPressed: () =>
                        Provider.of<Music>(context, listen: false).toggle(),
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 45,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("ادامه"), Icon(Icons.navigate_next)],
                    ),
                    onPressed: () {
                      Provider.of<Music>(context, listen: false).stop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Day()),
                      );
                      Provider.of<RolesNPlayers>(context, listen: false)
                          .startDay();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
