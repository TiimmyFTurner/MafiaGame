import 'package:mafia/helpers/lockScreenTimer.dart';
import 'package:mafia/helpers/persianNumber.dart';
import 'package:mafia/pages/day.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/inGameAppBar.dart';
import 'package:mafia/widgets/listItemNight.dart';
import 'package:flutter/material.dart';

class Night extends StatefulWidget {
  @override
  _NightState createState() => _NightState();
}

class _NightState extends State<Night> {
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
        appBar: InGameAppBar(
            title:
                "شب ${persianNumber(Provider.of<RolesNPlayers>(context).night)}"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _players.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                      index < _players.length
                          ? ListItemNight(_players[index], index)
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
                        Theme.of(context).colorScheme.secondary,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button.color,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text("موزیک", textDirection: TextDirection.rtl),
                        Icon(
                          Provider.of<Music>(context).isPlaying
                              ? Icons.stop
                              : Icons.play_arrow,
                        ),
                      ],
                    ),
                    onPressed: () =>
                        Provider.of<Music>(context, listen: false).toggle(),
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [Text("روز"), Icon(Icons.navigate_next)],
                    ),
                    onPressed: () {
                      Provider.of<Music>(context, listen: false).stop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Day()),
                      );
                      Provider.of<RolesNPlayers>(context, listen: false)
                          .startDay();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
