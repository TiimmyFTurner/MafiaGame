import 'package:mafia/pages/helpRoles.dart';
import 'package:mafia/pages/howToPlay.dart';
import 'package:mafia/pages/setPlayers.dart';
import 'package:mafia/pages/setting.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("asset/images/homeWP.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              PhysicalModel(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black,
                shadowColor: Theme.of(context).primaryColor,
                elevation: 10,
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Hero(
                    tag: "play",
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Text(
                        "شروع",
                        style: TextStyle(
                            color: Theme.of(context).textTheme.button.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3),
                      ),
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => SetPlayers()),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Text(
                          "روش بازی",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.button.color,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 3),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HowToPlay()),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Text(
                          "نقش ها",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.button.color,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 3),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HelpRoles()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Text(
                    "تنظیمات",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button.color,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
