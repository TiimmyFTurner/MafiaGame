import 'package:Mafia/pages/setRoles.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemPlayer.dart';
import 'package:Mafia/widgets/popupMenu.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 16),
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: _controller,
                  onChanged: (String value) => _name = value,
                  decoration: InputDecoration(
                    labelText: 'نام بازیکن',
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_name != '') {
                      _rNPProviderSetter.addPlayer = _name;
                      _name = '';
                      _controller.clear();
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: players.length,
                itemBuilder: (BuildContext context, int index) =>
                    ListItemPlayer(players[index])),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 45,
            child: Hero(
              tag: "play",
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
                  _rNPProviderSetter.savePlayers();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SetRoles()),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }

  AppBar _buildAppBar(context) => AppBar(
        title: Text("انتخاب بازیکن ها" +
            " (" +
            Provider.of<RolesNPlayers>(context).players.length.toString() +
            ")"),
        centerTitle: true,
        actions: <Widget>[PopupMenu()],
      );
}
