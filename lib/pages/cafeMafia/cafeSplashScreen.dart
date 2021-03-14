import 'package:mafia/pages/cafeMafia/loginSignup.dart';
import 'package:mafia/pages/cafeMafia/mainEventList.dart';
import 'package:mafia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CafeSplashScreen extends StatefulWidget {
  @override
  _CafeSplashScreenState createState() => _CafeSplashScreenState();
}

class _CafeSplashScreenState extends State<CafeSplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CafeMafia>(context, listen: false)
        .initCafeCheck()
        .then((value) {
      if (value == true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainEventList()));
        return true;
      }
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginSignup()));
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              "asset/images/splashWP.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[900],
              highlightColor: Colors.red[100],
              child: Text(
                "CAFE MAFIA",
                style: TextStyle(fontSize: 55, fontFamily: "Piedra"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
