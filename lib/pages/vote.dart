import 'package:Mafia/pages/night.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemVote.dart';
import 'package:flutter/material.dart';

class Vote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List _players = Provider.of<RolesNPlayers>(context).playersWithRoles;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _buildAppBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<RolesNPlayers>(context,listen: false).startNight();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => Night()),
            );
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
                    ListItemVote(_players[index], index),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
                  child: Chip(
                    backgroundColor: Colors.blue,
                    label: Text(
                      'زنده: ' +
                          Provider.of<RolesNPlayers>(context).alive.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
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
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
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
    );
  }

  AppBar _buildAppBar(context) => AppBar(
        title: Text("رای دهی"),
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
}
