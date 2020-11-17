import 'package:Mafia/pages/showRoles.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemRole.dart';
import 'package:flutter/material.dart';

class SetRoles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _rNPProviderListener = Provider.of<RolesNPlayers>(context);
    final _rNPProviderSetter =
        Provider.of<RolesNPlayers>(context, listen: false);
    List _mafia = _rNPProviderListener.mafia;
    List _citizen = _rNPProviderListener.citizen;
    List _independent = _rNPProviderListener.independent;
    List _selectedRoles = _rNPProviderListener.selectedRoles;
    Widget _roleGeidView({int flex, List roles, String setter}) {
      return Expanded(
        flex: flex,
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: (2 / 1),
          children: List.generate(roles.length, (index) {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              radius: 200,
              child: ListItemRole(roles[index]),
              onTap: () {
                setter == "add"
                    ? _rNPProviderSetter.addRole = roles[index]
                    : _rNPProviderSetter.removeRole = roles[index];
              },
              onLongPress: () => showRoleJob(roles, roles[index]),
            );
          }),
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        heroTag: 'play',
        child: Icon(Icons.play_arrow),
        onPressed: () {
          _rNPProviderSetter.saveRoles();
          _rNPProviderSetter.setPlayers();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => ShowRoles()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Text('مافیا', style: TextStyle(color: Colors.red, fontSize: 18)),
            _roleGeidView(flex: 2, roles: _mafia, setter: "add"),
            Text('شهروند', style: TextStyle(color: Colors.green, fontSize: 18)),
            _roleGeidView(flex: 2, roles: _citizen, setter: "add"),
            Text('مستقل', style: TextStyle(color: Colors.orange, fontSize: 18)),
            _roleGeidView(flex: 1, roles: _independent, setter: "add"),
            Text('انتخاب شده',
                style: TextStyle(color: Colors.blue, fontSize: 18)),
            _roleGeidView(flex: 2, roles: _selectedRoles, setter: "remove"),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(context) => AppBar(
        title: Text("انتخاب نقش ها" +
            " (" +
            Provider.of<RolesNPlayers>(context).players.length.toString() +
            ")"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: () => Provider.of<RolesNPlayers>(context, listen: false)
                .recoverLastRoles(),
          ),
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () {
                  final snackBar = SnackBar(
                    content: Text("برای مشاهده وظیفه هر نقش آن را نگه دارید",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1),
                    backgroundColor: Theme.of(context).accentColor,
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                }),
          )
        ],
      );

  showRoleJob(_, role) {
    return showDialog(
      context: _,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            role.name,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Text(
              role.job,
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("فهمیدم"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
