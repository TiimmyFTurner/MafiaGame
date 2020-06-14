import 'package:Mafia/pages/home.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Settings()),
        ChangeNotifierProvider(create: (_) => RolesNPlayers())
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
  void initState() {
    Provider.of<Settings>(context, listen: false).readSetting();
    Provider.of<RolesNPlayers>(context, listen: false).initRNPSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mafia',
      theme: Provider.of<Settings>(context).themeData,
      darkTheme: Provider.of<Settings>(context).darkTheme,
      home: Home(),
    );
  }
}
