import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mafia/models/event.dart';
import 'package:shamsi_date/shamsi_date.dart';

class EventCardList extends StatelessWidget {
  final List<Event> data;
  Random rnd = Random();
  EventCardList(this.data);

  String formatter(Date d) {
    final f = d.formatter;
    return "${f.wN} ${f.d} ${f.mN} ${f.y}";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text('مکان: ',
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                            Expanded(
                              child: Text(data[index].locatioan,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('زمان: ',
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                            Text(
                                formatter(
                                    Gregorian.fromDateTime(data[index].date)
                                        .toJalali()),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(14)),
                    child: ClipPath(
                      clipper: CardImageClippr(),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('asset/images/card' +
                            (1 + rnd.nextInt(3)).toString() +
                            '.jpg'),
                        width: 175,
                        height: 96,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class CardImageClippr extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width - 40, size.height)
      ..lineTo(size.width - 5, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
