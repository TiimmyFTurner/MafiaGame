import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class ListItemDay extends StatefulWidget {
  final _player, index;

  ListItemDay(this._player, this.index);

  @override
  _ListItemDayState createState() => _ListItemDayState();
}

class _ListItemDayState extends State<ListItemDay> {
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
              IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<RolesNPlayers>(context, listen: false)
                        .killPlayer = index;
                  }),
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
                        : _player.role.type == 'M'
                            ? Colors.black
                            : Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
