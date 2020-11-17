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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Text(
                      _role.name,
                      maxLines: 2,
                      style: TextStyle(height: 1.2),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Icon(Icons.person,
                    color: _role.type == 'C'
                        ? Colors.green
                        : _role.type == 'M' ? Colors.red : Colors.orange),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
