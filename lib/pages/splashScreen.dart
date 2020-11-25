import 'package:Mafia/pages/home.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wakelock/wakelock.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initSetting().then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Home(),
        ),
      ),
    );
  }

  Future initSetting() async {
    await Future.delayed(Duration(milliseconds: 1500));
    await Provider.of<Settings>(context, listen: false).readSetting();
    await Provider.of<RolesNPlayers>(context, listen: false).initRNPSetting();
    await Wakelock.enable();
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
                child: Text("Mafia Night",
                    style: TextStyle(fontSize: 55, fontFamily: "Piedra")),
                baseColor: Colors.grey[900],
                highlightColor: Colors.red[100]),
          )
        ],
      ),
    );
  }
}
