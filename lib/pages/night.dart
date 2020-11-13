import 'package:Mafia/helpers/lockScreenTimer.dart';
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: InGameAppBar(
            title:
                "شب " + Provider.of<RolesNPlayers>(context).night.toString()),
        floatingActionButton: FloatingActionButton(
          heroTag: "next",
          child: Icon(Icons.navigate_next),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => Day()),
            );
            Provider.of<RolesNPlayers>(context, listen: false).startDay();
          },
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _players.length,
                itemBuilder: (BuildContext context, int index) =>
                    ListItemNight(_players[index], index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
