import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class ListItemPlayer extends StatefulWidget {
  final _player;

  ListItemPlayer(this._player);

  @override
  _ListItemPlayerState createState() => _ListItemPlayerState();
}

class _ListItemPlayerState extends State<ListItemPlayer> {
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
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        ),
      ),
    );
  }
}
