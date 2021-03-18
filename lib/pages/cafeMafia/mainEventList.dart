import 'package:flutter/material.dart';
import 'package:mafia/models/event.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/cafeMafia/eventCardList.dart';
import 'package:mafia/widgets/cafeMafia/searchField.dart';

class MainEventList extends StatefulWidget {
  @override
  _MainEventListState createState() => _MainEventListState();
}

class _MainEventListState extends State<MainEventList> {
  Future<List<Event>> eventList;
  @override
  void initState() {
    super.initState();
    eventList = Provider.of<CafeMafia>(context, listen: false).eventList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.person), onPressed: () {}),
                    Text(
                      'کافه مافیا',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 24),
                    ),
                    IconButton(icon: Icon(Icons.home), onPressed: () {}),
                  ],
                ),
              ),
              SearchField(),
              FutureBuilder<List<Event>>(
                future: eventList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(child: EventCardList(snapshot.data));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
