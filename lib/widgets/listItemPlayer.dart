import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class ListItemPlayer extends StatefulWidget {
  final _player;

  ListItemPlayer(this._player);

  @override
  _ListItemPlayerState createState() => _ListItemPlayerState();
}

class _ListItemPlayerState extends State<ListItemPlayer> {
  @override
  Widget build(BuildContext context) {
    final _player = widget._player;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Provider.of<RolesNPlayers>(context, listen: false)
                    .removePlayer = _player;
              }),
          Text(
            _player,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.person, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
