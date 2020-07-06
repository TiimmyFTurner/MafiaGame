import 'package:Mafia/models/player.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class ListItemNight extends StatefulWidget {
  final Player _player;
  final int index;

  ListItemNight(this._player, this.index);

  @override
  _ListItemNightState createState() => _ListItemNightState();
}

class _ListItemNightState extends State<ListItemNight> {
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _player = widget._player;
    final index = widget.index;

    return AnimatedOpacity(
      duration: Duration(milliseconds: 400),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
        padding: _lock
            ? EdgeInsets.zero
            : EdgeInsets.only(top: MediaQuery.of(context).size.height),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            color: _player.status == 'alive'
                ? Colors.green[800]
                : _player.status == 'silent' ? Colors.grey : Colors.red[800],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<RolesNPlayers>(context, listen: false)
                              .killPlayer = index;
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.volume_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Provider.of<RolesNPlayers>(context, listen: false)
                              .silentPlayer = index;
                        }),
                  ],
                ),
                Text(_player.role.name, style: TextStyle(color: Colors.white)),
                Text(
                  _player.name,
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.person,
                      color: _player.role.type == 'C'
                          ? Colors.blue
                          : Colors.black),
                ),
              ],
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                  title: Text("وظیفه", textAlign: TextAlign.center),
                  content: SingleChildScrollView(
                    child: Text(_player.role.job, textAlign: TextAlign.center),
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
            );
          },
        ),
      ),
    );
  }
}
