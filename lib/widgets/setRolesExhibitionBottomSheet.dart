import 'dart:ui';
import 'dart:math';
import 'package:mafia/pages/showRoles.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/listItemRole.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double minHeight = 90;

class SetRolesExhibitionBottomSheet extends StatefulWidget {
  @override
  _SetRolesExhibitionBottomSheetState createState() =>
      _SetRolesExhibitionBottomSheetState();
}

class _SetRolesExhibitionBottomSheetState
    extends State<SetRolesExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  double get maxHeight => MediaQuery.of(context).size.height / 1.13;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _animationController.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight, maxHeight),
          bottom: 0,
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: _toggle,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.4),
                      blurRadius: 10,
                      offset: Offset(-3, -.5))
                ],
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  RotationTransition(
                                      turns:
                                          AlwaysStoppedAnimation(lerp(0, .5)),
                                      child: Icon(Icons.keyboard_arrow_up)),
                                  Expanded(
                                    child: Text(
                                      'نقش های انتخاب شده',
                                      style: TextStyle(fontSize: lerp(17, 20)),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, right: 10, left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              Text(
                                                " ${Provider.of<RolesNPlayers>(context).selectedMafia}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Colors.green,
                                                size: 18,
                                              ),
                                              Text(
                                                " ${Provider.of<RolesNPlayers>(context).selectedCitizen - Provider.of<RolesNPlayers>(context).selectedIndependent}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, right: 10, left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: Colors.orange,
                                                size: 18,
                                              ),
                                              Text(
                                                " ${Provider.of<RolesNPlayers>(context).selectedIndependent}",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45,
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
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).textTheme.button.color,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("پخش نقش"),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                            onPressed: () {
                              if (!Provider.of<RolesNPlayers>(context,
                                      listen: false)
                                  .selectedRoles
                                  .isEmpty) {
                                Provider.of<RolesNPlayers>(context,
                                        listen: false)
                                    .saveRoles();
                                Provider.of<RolesNPlayers>(context,
                                        listen: false)
                                    .setPlayers();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => ShowRoles()),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    _buildSelectedItemList(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggle() {
    setState(() {});
    final bool isOpen =
        _animationController.status == AnimationStatus.completed;
    _animationController.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _animationController.fling(velocity: max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _animationController.fling(velocity: min(-2.0, -flingVelocity));
    else
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
  }

  Widget _buildSelectedItemList() {
    dynamic roles = Provider.of<RolesNPlayers>(context).selectedRoles;
    return roles.length != 0
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: (2 / 1),
                children: List.generate(
                  roles.length,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(20),
                    radius: 200,
                    child: ListItemRole(roles[index]),
                    onTap: () {
                      Provider.of<RolesNPlayers>(context, listen: false)
                          .removeRole = roles[index];
                    },
                    onLongPress: () => showRoleJob(context, roles[index]),
                  ),
                ),
              ),
            ),
          )
        : AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: lerp(0, 1) > .8
                ? Column(
                    children: [
                      Image.asset("asset/images/empty.png"),
                      Text(
                        'نقشی انتخاب نشده',
                        style: TextStyle(fontSize: 22),
                      ),
                      Opacity(
                        opacity: .6,
                        child: Text(
                          "برای شروع بازی نقش های دلخواه خود را انتخاب کنید ",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  )
                : Container(),
          );
  }

  showRoleJob(_, role) {
    return showDialog(
      context: _,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
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
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).textTheme.button.color),
              ),
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
