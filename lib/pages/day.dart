import 'dart:async';

import 'package:Mafia/pages/night.dart';
import 'package:Mafia/pages/vote.dart';
import 'package:Mafia/providers/providers.dart';
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
  Widget build(BuildContext context) {
    int dayN = Provider.of<RolesNPlayers>(context).day;

    List _players = Provider.of<RolesNPlayers>(context).playersWithRoles;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _buildAppBar(context),
        floatingActionButton: FloatingActionButton(
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
          child: Icon(Icons.play_arrow),
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

  AppBar _buildAppBar(context) => AppBar(
        title:
            Text("روز " + Provider.of<RolesNPlayers>(context).day.toString()),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[_simplePopup(context)],
      );

  Widget _simplePopup(context) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("بازی جدید"),
          ),
        ],
        onSelected: (value) {
          Provider.of<RolesNPlayers>(context, listen: false).newGame();
          Navigator.of(context).pop();
        },
      );

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
