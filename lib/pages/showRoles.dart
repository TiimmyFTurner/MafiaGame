import 'package:mafia/pages/day.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/RoleDialog.dart';
import 'package:mafia/widgets/inGameAppBar.dart';
import 'package:mafia/widgets/listItemShowRole.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ShowRoles extends StatefulWidget {
  @override
  _ShowRolesState createState() => _ShowRolesState();
}

class _ShowRolesState extends State<ShowRoles> {
  @override
  Widget build(BuildContext context) {
    List _players = Provider.of<RolesNPlayers>(context).playersWithRolesFoShow;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: InGameAppBar(title: "نمایش نقش ها"),
        body: _players.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SlideAction(
                    text: "برای شروع بازی بکشید",
                    innerColor: Theme.of(context).iconTheme.color,
                    onSubmit: () {
                      Provider.of<LastMoveProvider>(context, listen: false)
                          .newGame();
                      Provider.of<RolesNPlayers>(context, listen: false)
                          .playGame();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Day()),
                      );
                    },
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: (2 / 1),
                  children: List.generate(_players.length, (index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      child: ListItemShowRole(_players[index]),
                      onTap: () {
                        String role = _players[index].role.type == 'C'
                            ? "شهروند"
                            : _players[index].role.type == 'M'
                                ? "مافیا"
                                : "مستقل";
                        showModalBottomSheet(
                          context: context,
                          enableDrag: true,
                          isScrollControlled: true,
                          builder: (builder) => RoleDialog(
                            title: _players[index].name,
                            desc: "نقش: " +
                                _players[index].role.name +
                                "\nگروه: " +
                                role,
                            btn: "فهمیدم",
                            more: _players[index].role.job,
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            image: AssetImage(
                              "asset/images/" +
                                  _players[index].role.type +
                                  ".jpg",
                            ),
                          ),
                        ).then(
                          (value) => setState(() {
                            _players.remove(_players[index]);
                          }),
                        );
                      },
                    );
                  }),
                ),
              ),
      ),
    );
  }
}
