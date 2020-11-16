import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Lock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SlideAction(
              text: "برای باز کردن قفل بکشید",
              innerColor: Theme.of(context).iconTheme.color,
              onSubmit: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}
