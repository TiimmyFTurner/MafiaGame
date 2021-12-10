import 'package:mafia/pages/myRoles.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/listItemRole.dart';
import 'package:flutter/material.dart';

class HelpRoles extends StatelessWidget {
  Widget _roleDetails(context, role) {
    String type = role.type == 'C'
        ? "شهروند"
        : role.type == 'M'
            ? "مافیا"
            : "مستقل";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        SizedBox(height: 25),
        Text("نقش: " + role.name + "\nگروه: " + type,
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl),
        SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    role.job,
                    style: TextStyle(fontSize: 16),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _rNPProviderListener = Provider.of<RolesNPlayers>(context);
    List _mafia = _rNPProviderListener.mafia;
    List _citizen = _rNPProviderListener.citizen;
    List _independent = _rNPProviderListener.independent;
    Widget _roleGridView({List roles}) {
      return GridView.count(
        padding: EdgeInsets.all(10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        childAspectRatio: (2 / 1),
        children: List.generate(
          roles.length,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(20),
            child: ListItemRole(roles[index]),
            onTap: () {
              showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                builder: (builder) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    ),
                    child: _roleDetails(context, roles[index]),
                  );
                },
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("نقش ها"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Text(
                    "نقش های من",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button.color,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      isScrollControlled: true,
                      builder: (builder) => MyRoles())
                      .then((value) => Provider.of<RolesNPlayers>(context, listen: false)
                      .saveCustomRoles()),
                ),
              ),
            ),
            Text('مافیا', style: TextStyle(color: Colors.red, fontSize: 18)),
            _roleGridView(roles: _mafia),
            Text('شهروند', style: TextStyle(color: Colors.green, fontSize: 18)),
            _roleGridView(roles: _citizen),
            Text('مستقل', style: TextStyle(color: Colors.orange, fontSize: 18)),
            _roleGridView(roles: _independent),
          ],
        ),
      ),
    );
  }
}
