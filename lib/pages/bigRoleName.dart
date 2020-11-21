import 'package:flutter/material.dart';

class BigRoleName extends StatelessWidget {
  final String _roleName;
  BigRoleName(this._roleName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                _roleName,
                style: TextStyle(fontSize: 60),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 25),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
