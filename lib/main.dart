import 'package:mafia/pages/splashScreen.dart';
import 'package:mafia/providers/providers.dart';
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Settings()),
        ChangeNotifierProvider(create: (_) => RolesNPlayers()),
        ChangeNotifierProvider(create: (_) => Note()),
        ChangeNotifierProvider(create: (_) => Music()),
        ChangeNotifierProvider(create: (_) => CafeMafia())
      ],
      child: MafiaApp(),
    ),
  );
}

class MafiaApp extends StatefulWidget {
  @override
  _MafiaAppState createState() => _MafiaAppState();
}

class _MafiaAppState extends State<MafiaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mafia',
      theme: Provider.of<Settings>(context).themeData,
      darkTheme: Provider.of<Settings>(context).darkTheme,
      home: SplashScreen(),
    );
  }
}
