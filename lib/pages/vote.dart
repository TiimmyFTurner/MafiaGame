import 'package:Mafia/helpers/lockScreenTimer.dart';
import 'package:Mafia/pages/night.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/inGameAppBar.dart';
import 'package:Mafia/widgets/listItemVote.dart';
import 'package:flutter/material.dart';

class Vote extends StatefulWidget {
  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
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
        appBar: InGameAppBar(title: "رای دهی"),
        floatingActionButton: FloatingActionButton(
          heroTag: "next",
          child: Icon(Icons.navigate_next),
          onPressed: () {
            Provider.of<RolesNPlayers>(context, listen: false).startNight();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => Night()),
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _players.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ListItemVote(_players[index], index),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 16, left: 8),
                    child: Chip(
                      backgroundColor: Colors.blue,
                      label: Text(
                        'زنده: ' +
                            Provider.of<RolesNPlayers>(context)
                                .alive
                                .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 16, left: 8),
                    child: Chip(
                      backgroundColor: Colors.yellow[800],
                      label: Text(
                        'دادگاهی: ' +
                            Provider.of<RolesNPlayers>(context)
                                .voteToJudge
                                .toString() +
                            '  ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 16, left: 8),
                    child: Chip(
                      backgroundColor: Colors.red[800],
                      label: Text(
                        'مرگ: ' +
                            Provider.of<RolesNPlayers>(context)
                                .voteToDead
                                .toString() +
                            '  ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
