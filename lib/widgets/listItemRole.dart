import 'package:flutter/material.dart';

class ListItemRole extends StatefulWidget {
  final role;

  ListItemRole(this.role);

  @override
  _ListItemRoleState createState() => _ListItemRoleState();
}

class _ListItemRoleState extends State<ListItemRole> {
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
    final _role = widget.role;

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.person,
                  color: _role.type == 'C' ? Colors.green : Colors.red),
              Text(
                _role.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
