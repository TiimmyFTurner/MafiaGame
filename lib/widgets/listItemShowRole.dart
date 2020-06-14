import 'package:flutter/material.dart';

class ListItemShowRole extends StatefulWidget {
  final player;

  ListItemShowRole(this.player);

  @override
  _ListItemShowRoleState createState() => _ListItemShowRoleState();
}

class _ListItemShowRoleState extends State<ListItemShowRole> {
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
    final _player = widget.player;

    return AnimatedOpacity(
      duration: Duration(milliseconds: 650),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 350),
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
              SizedBox(),
              Text(
                _player.name,
              ),
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.person, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
