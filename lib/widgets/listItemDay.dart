import 'package:mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class ListItemDay extends StatefulWidget {
  final _player, index;

  ListItemDay(this._player, this.index);

  @override
  _ListItemDayState createState() => _ListItemDayState();
}

class _ListItemDayState extends State<ListItemDay> {
  @override
  Widget build(BuildContext context) {
    final _player = widget._player;
    final index = widget.index;

    return Card(
      color: _player.status == 'alive'
          ? Colors.green[800]
          : _player.status == 'silent'
              ? Colors.grey
              : Colors.red[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<RolesNPlayers>(context, listen: false).killPlayer =
                    index;
              }),
          Expanded(
            child: Text(
              _player.role.name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              _player.name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.person,
                color: _player.role.type == 'C'
                    ? Colors.blue
                    : _player.role.type == 'M'
                        ? Colors.black
                        : Colors.orange),
          ),
        ],
      ),
    );
  }
}
