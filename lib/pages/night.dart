import 'package:Mafia/pages/day.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemNight.dart';
import 'package:flutter/material.dart';

class Night extends StatelessWidget {
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => Day()),
            );
            Provider.of<RolesNPlayers>(context, listen: false).startDay();
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
                    ListItemNight(_players[index], index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(context) => AppBar(
        title:
            Text("شب " + Provider.of<RolesNPlayers>(context).night.toString()),
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
