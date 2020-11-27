import 'package:Mafia/pages/home.dart';
import 'package:Mafia/pages/setRoles.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemPlayer.dart';
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
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Theme.of(context).primaryColor,
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
                            color: Theme.of(context).accentColor,
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
                    Scaffold.of(context).showSnackBar(snackBar);
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
                          color: Theme.of(context).accentColor,
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
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              },
            ),
          )
        ],
      );
}
