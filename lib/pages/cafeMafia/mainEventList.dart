import 'package:flutter/material.dart';
import 'package:mafia/widgets/cafeMafia/searchField.dart';

class MainEventList extends StatelessWidget {
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
            ],
          ),
        ),
      ),
    );
  }
}
