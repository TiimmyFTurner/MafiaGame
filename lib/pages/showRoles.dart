import 'package:Mafia/pages/day.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemShowRole.dart';
import 'package:flutter/material.dart';

class ShowRoles extends StatefulWidget {
  @override
  _ShowRolesState createState() => _ShowRolesState();
}

class _ShowRolesState extends State<ShowRoles> {
  @override
  Widget build(BuildContext context) {
    List _players = Provider.of<RolesNPlayers>(context).playersWithRolesFoShow;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _buildAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_players.length == 0) {
              Provider.of<RolesNPlayers>(context, listen: false).playGame();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Day()),
              );
            }
          },
          child: Icon(Icons.play_arrow),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: (2 / 1),
          children: List.generate(_players.length, (index) {
            return InkWell(
              child: ListItemShowRole(_players[index]),
              onTap: () {
                String role =
                    _players[index].role.type == 'C' ? "شهروند" : "مافیا";
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      backgroundColor: Theme.of(context).accentColor,
                      title: Text(
                        _players[index].name,
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "نقش: " +
                                _players[index].role.name +
                                "\nگروه: " +
                                role,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("فهمیدم"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                ).then(
                  (value) => setState(() {
                    _players.remove(_players[index]);
                  }),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("نمایش نقش ها"),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[_simplePopup(context)],
      );

  Widget _simplePopup(context) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "بازی جدید",
            ),
          ),
        ],
        onSelected: (value) {
          Provider.of<RolesNPlayers>(context, listen: false).newGame();
          Navigator.of(context).pop();
        },
      );
}
