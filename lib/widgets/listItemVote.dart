import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class ListItemVote extends StatefulWidget {
  final _player, index;

  ListItemVote(this._player, this.index);

  @override
  _ListItemVoteState createState() => _ListItemVoteState();
}

class _ListItemVoteState extends State<ListItemVote> {
  @override
  Widget build(BuildContext context) {
    final _player = widget._player;
    final index = widget.index;

    return Card(
      color: _player.status == 'alive'
          ? Colors.green[800]
          : _player.status == 'judge'
              ? Colors.yellow[800]
              : _player.status == 'silent' ? Colors.grey : Colors.red[800],
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
          IconButton(
              icon: Icon(
                Icons.gavel,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<RolesNPlayers>(context, listen: false).judgePlayer =
                    index;
              }),
          Expanded(
            flex: 1,
            child: Text(
              _player.role.name,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
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
                        : Colors.deepOrangeAccent),
          ),
        ],
      ),
    );
  }
}
