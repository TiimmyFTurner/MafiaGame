import 'package:Mafia/pages/day.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/inGameAppBar.dart';
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
        appBar: InGameAppBar(title: "نمایش نقش ها"),
        body: _players.length == 0
            ? Center(
                child: Hero(
                  tag: "next",
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "شروع بازی",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3),
                      ),
                      onPressed: () {
                        Provider.of<RolesNPlayers>(context, listen: false)
                            .playGame();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Day()),
                        );
                      },
                    ),
                  ),
                ),
              )
            : GridView.count(
                crossAxisCount: 3,
                childAspectRatio: (2 / 1),
                children: List.generate(_players.length, (index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
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
}
