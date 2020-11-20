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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _players.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                      index < _players.length
                          ? ListItemDay(_players[index], index)
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
                        Icon(Icons.timer),
                        Text(
                          " ${_current.toString()}",
                          style: TextStyle(fontSize: 29),
                        ),
                      ],
                    ),
                    onPressed: startTimer,
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
                      children: [Text("ادامه"), Icon(Icons.navigate_next)],
                    ),
                    onPressed: () {
                      if (dayN == 1)
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Night()),
                        );
                      else
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Vote()),
                        );
                      Provider.of<RolesNPlayers>(context, listen: false)
                          .startVoting();
                    },
                  ),
                )
              ],
            ),
          ),
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
