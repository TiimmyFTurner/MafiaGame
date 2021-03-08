import 'package:mafia/pages/lock.dart';
import 'package:mafia/providers/providers.dart';
import 'package:flutter/material.dart';

class InGameAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  InGameAppBar({Key key, @required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _InGameAppBarState createState() => _InGameAppBarState();
}

class _InGameAppBarState extends State<InGameAppBar> {
  TextEditingController noteController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.event_note),
          onPressed: () {
            noteController.text =
                Provider.of<Note>(context, listen: false).note;
            showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                builder: (builder) {
                  return Container(
                    height: MediaQuery.of(context).viewInsets.bottom == 0
                        ? MediaQuery.of(context).size.height / 1.2
                        : MediaQuery.of(context).size.height / 2,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.close),
                              ),
                              Text(
                                "یادداشت",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 16, bottom: 16),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: SingleChildScrollView(
                              child: TextField(
                                controller: noteController,
                                maxLines: 12,
                                autofocus: true,
                                decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: 'متن یاداشت را وارد کنید'),
                                onChanged: (value) {
                                  Provider.of<Note>(context, listen: false)
                                      .note = value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.lock_outline),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Lock()))),
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
                        TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).textTheme.button.color),
                            ),
                            onPressed: Navigator.of(context).pop,
                            child: Text("خیر")),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).textTheme.button.color),
                          ),
                          child: Text("بله"),
                          onPressed: () {
                            Provider.of<RolesNPlayers>(context, listen: false)
                                .newGame();
                            Provider.of<Note>(context, listen: false)
                                .clearNote();
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
