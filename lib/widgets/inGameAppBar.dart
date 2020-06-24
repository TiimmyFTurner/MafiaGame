import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class InGameAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  InGameAppBar({Key key, @required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _InGameAppBarState createState() => _InGameAppBarState();
}

class _InGameAppBarState extends State<InGameAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      leading: Container(),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.fiber_new),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                  title: Text(
                    "بازی جدید ؟",
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    ButtonBar(
                      children: [
                        FlatButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text("خیر")),
                        FlatButton(
                          child: Text("بله"),
                          onPressed: () {
                            Provider.of<RolesNPlayers>(context, listen: false)
                                .newGame();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
