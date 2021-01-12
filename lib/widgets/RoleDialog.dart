import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const double radius = 28.0;
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class RoleDialog extends StatefulWidget {
  final String title, desc, btn, more;
  final ImageProvider image;
  final backgroundColor;
  RoleDialog({
    @required this.title,
    @required this.desc,
    @required this.btn,
    @required this.more,
    this.backgroundColor,
    this.image,
  });

  @override
  _RoleDialogState createState() => _RoleDialogState();
}

class _RoleDialogState extends State<RoleDialog> {
  bool change = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.radius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(top: 66),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: change ? MediaQuery.of(context).size.height * .8 : 330,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(Radius.circular(Consts.radius)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70),
                  Text(widget.title,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl),
                  SizedBox(height: 12),
                  Text(widget.desc,
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            accentColor: Colors.blueGrey),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Consts.radius),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: ExpansionTile(
                              onExpansionChanged: (status) {
                                setState(() {
                                  change = status;
                                });
                              },
                              childrenPadding: EdgeInsets.only(
                                left: 12,
                                right: 12,
                                bottom: 12,
                              ),
                              title: Text("وظیفه"),
                              children: [
                                Text(
                                  widget.more,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.btn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            backgroundImage: widget.image,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}
