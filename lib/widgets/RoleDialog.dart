import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const double radius = 28.0;
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class RoleDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.radius),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / .9,
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.radius),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  desc,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Consts.radius)),
                    child: ListView(
                      children: [
                        Text(more),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                // Theme(
                //   data: Theme.of(context).copyWith(
                //       dividerColor: Colors.transparent,
                //       accentColor: Colors.blueGrey),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(Consts.radius),
                //       color: Theme.of(context).backgroundColor,
                //     ),
                //     child: ExpansionTile(
                //       childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                //       title: Text("وظیفه"),
                //       children: [
                //         Text(
                //           more,
                //           textAlign: TextAlign.center,
                //         ),
                //         SizedBox(height: 15.0),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(btn),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            backgroundImage: image,
            // backgroundColor: Colors.blueAccent,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}
