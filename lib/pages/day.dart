import 'dart:async';
import 'package:mafia/helpers/lockScreenTimer.dart';
import 'package:mafia/helpers/persianNumber.dart';
import 'package:mafia/pages/night.dart';
import 'package:mafia/pages/vote.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/inGameAppBar.dart';
import 'package:mafia/widgets/listItemDay.dart';
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
    Future.delayed(Duration.zero, () {
      var _winner =
          Provider.of<RolesNPlayers>(context, listen: false).winnerCheck();
      if (_winner != null)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              title: Text(
                  (_winner == 'C'
                          ? 'تیم شهروند'
                          : _winner == 'M'
                              ? 'تیم مافیا'
                              : 'نقش مستقل') +
                      ' پیروز این بازی شد ',
                  textAlign: TextAlign.center),
              actions: <Widget>[
                ButtonBar(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button.color),
                      ),
                      child: Text("بازی جدید"),
                      onPressed: () {
                        Provider.of<RolesNPlayers>(context, listen: false)
                            .newGame();
                        Provider.of<Note>(context, listen: false).clearNote();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button.color),
                      ),
                      child: Text("ادامه بازی"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    int dayN = Provider.of<RolesNPlayers>(context).day;

    List _players = Provider.of<RolesNPlayers>(context).playersWithRoles;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: InGameAppBar(
            title:
                "روز ${persianNumber(Provider.of<RolesNPlayers>(context).day)}"),
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
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button.color,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timer),
                        Text(
                          " ${_current.toString()}",
                          style: TextStyle(
                            fontSize: 29,
                          ),
                        ),
                      ],
                    ),
                    onPressed: startTimer,
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button.color,
                      ),
                    ),
                    child: Row(
                      children: [Text("رای گیری"), Icon(Icons.navigate_next)],
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
    _current = 31;
    if (_timer != null) _timer.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {
        _current = _current - 1;
        if (_current < 1) time.cancel();
      });
    });
  }
}
