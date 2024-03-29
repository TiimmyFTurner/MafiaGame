import 'package:mafia/pages/home.dart';
import 'package:mafia/pages/setRoles.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/listItemPlayer.dart';
import 'package:flutter/material.dart';

class SetPlayers extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _rNPProviderListener = Provider.of<RolesNPlayers>(context);
    final _rNPProviderSetter =
        Provider.of<RolesNPlayers>(context, listen: false);
    String _name = '';
    List players = _rNPProviderListener.players;

    void _addPlayer([_]) {
      if (_name != '') {
        _rNPProviderSetter.addPlayer = _name;
        _name = '';
        _controller.clear();
      }
    }

    return Scaffold(
      appBar: _buildAppBar(context, players),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: _controller,
                onChanged: (String value) => _name = value,
                onSubmitted: _addPlayer,
                decoration: InputDecoration(
                  labelText: 'نام بازیکن',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addPlayer,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: players.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index < players.length
                      ? ListItemPlayer(players[index])
                      : SizedBox(height: 65);
                }),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 65,
        width: MediaQuery.of(context).size.width,
        child: Hero(
          tag: "play",
          child: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button.color,
                  ),
                ),
                child: Text(
                  "انتخاب نقش",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 3),
                ),
                onPressed: () {
                  if (players.length > 2) {
                    _rNPProviderSetter.savePlayers();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SetRoles()),
                    );
                  } else {
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(30)),
                        margin: EdgeInsets.only(bottom: 50),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("حداقل تعداد بازیکنان باید سه نفر باشد",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                      backgroundColor: Theme.of(context).backgroundColor,
                      elevation: 0,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(context, players) => AppBar(
        title:
            Text("انتخاب بازیکن ها" + " (" + players.length.toString() + ")"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      title: Text("راهنما"),
                      content: Text(
                          'در این قسمت شما میتوانید به هر تعدادی میخواهید بازیکن اضافه کنید'),
                      actions: [
                        ButtonBar(
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).textTheme.button.color),
                              ),
                              child: Text("بازگشت"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                if (!Provider.of<RolesNPlayers>(context, listen: false)
                    .recoverLastPlayers()) {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(bottom: 50),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("بازیکنی برای بازگردانی وجود ندارد",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    backgroundColor: Theme.of(context).backgroundColor,
                    elevation: 0,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          )
        ],
      );
}
