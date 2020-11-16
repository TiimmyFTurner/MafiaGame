import 'dart:async';
import 'package:Mafia/helpers/lockScreenTimer.dart';
import 'package:Mafia/pages/night.dart';
import 'package:Mafia/pages/vote.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/inGameAppBar.dart';
import 'package:Mafia/widgets/listItemDay.dart';
import 'package:flutter/material.dart';

class Day extends StatefulWidget {
  @override
  _DayState createState() => _DayState();
}

Timer _timer;
int _current = 30;

class _DayState extends State<Day> {
  @override
  void initState() {
    lockTimer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int dayN = Provider.of<RolesNPlayers>(context).day;

    List _players = Provider.of<RolesNPlayers>(context).playersWithRoles;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: InGameAppBar(
            title: "روز" + Provider.of<RolesNPlayers>(context).day.toString()),
        floatingActionButton: FloatingActionButton(
          heroTag: "next",
          child: Icon(Icons.navigate_next),
          onPressed: () {
            if (dayN == 1)
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Night()),
              );
            else
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Vote()),
              );
            Provider.of<RolesNPlayers>(context, listen: false).startVoting();
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
                    ListItemDay(_players[index], index),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: FloatingActionButton(
                    heroTag: 'timer',
                    child: Icon(Icons.timer),
                    onPressed: startTimer,
                  ),
                ),
                Text(
                  _current.toString(),
                  style: TextStyle(fontSize: 35),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    _current = 30;
    if (_timer != null) _timer.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {
        _current = _current - 1;
        if (_current < 1) time.cancel();
      });
    });
  }
}
