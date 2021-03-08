import 'package:mafia/helpers/lockScreenTimer.dart';
import 'package:mafia/pages/night.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/inGameAppBar.dart';
import 'package:mafia/widgets/listItemVote.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                          ? ListItemVote(_players[index], index)
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
          )),
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 35,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.heartbeat,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                Text(
                                  " ${Provider.of<RolesNPlayers>(context).alive.toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.yellow[800],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.gavel,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                Text(
                                  " ${Provider.of<RolesNPlayers>(context).voteToJudge.toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.red[700],
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.skullCrossbones,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                Text(
                                  " ${Provider.of<RolesNPlayers>(context).voteToDead.toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button.color,
                      ),
                    ),
                    child: Row(
                      children: [Text("شب"), Icon(Icons.navigate_next)],
                    ),
                    onPressed: () {
                      Provider.of<RolesNPlayers>(context, listen: false)
                          .startNight();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Night()),
                      );
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
}
