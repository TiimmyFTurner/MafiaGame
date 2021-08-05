import 'package:mafia/pages/myRoles.dart';
import 'package:mafia/providers/providers.dart';
import 'package:mafia/widgets/listItemRole.dart';
import 'package:mafia/widgets/setRolesExhibitionBottomSheet.dart';
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

    Widget _roleGridView({int flex, List roles, String setter}) {
      return Expanded(
        flex: flex,
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: (2 / 1),
          children: List.generate(
            roles.length,
            (index) => index < roles.length
                ? InkWell(
                    borderRadius: BorderRadius.circular(20),
                    radius: 200,
                    child: ListItemRole(roles[index]),
                    onTap: () => _rNPProviderSetter.addRole = roles[index],
                    onLongPress: () => showRoleJob(context, roles[index]),
                  )
                : Container(),
          ),
        ),
      );
    }

    Widget _buildBody() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Text('مافیا', style: TextStyle(color: Colors.red, fontSize: 18)),
            _roleGridView(flex: 4, roles: _mafia, setter: "add"),
            Text('شهروند', style: TextStyle(color: Colors.green, fontSize: 18)),
            _roleGridView(flex: 5, roles: _citizen, setter: "add"),
            Text('مستقل', style: TextStyle(color: Colors.orange, fontSize: 18)),
            _roleGridView(flex: 3, roles: _independent, setter: "add"),
            SizedBox(height: 90)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: <Widget>[
          SafeArea(child: _buildBody()),
          SetRolesExhibitionBottomSheet(),
        ],
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
                      backgroundColor: Theme.of(context).accentColor,
                      title: Text("راهنما"),
                      content: Text(
                        "برای مشاهده وظیفه هر نقش آن را نگه دارید، برای دیدن یا حذف نقش های انتخاب شده قسمت 'نقش های انتخاب شده' را به سمت بالا بکشید " +
                            "\n\n" +
                            "برای بازگردانی نقش های بازی قبل از منوی بالا سمت راست گذینه بازگردانی را انتخاب کنید"
                                "\n\n" +
                            "برای اضافه کردن نقش های شخصی سازی شده از منوی بالا سمت راست گذینه نقش های من را انتخاب کرده نقش های خود را اضافه و مدیریت کنید"
                                "\n\n" +
                            "استفاده از نقش های ستاره دار یا غیر فعال کردن محدودیت نسبت را میتوانید از قسمت تنظیمات مدیریت کنید",
                      ),
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
          _popupMenuButton(context),
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

  _popupMenuButton(context) {
    return PopupMenuButton<int>(
      onSelected: (value) => _menuOnSelected(value, context),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("باز گردانی نقش ها", textDirection: TextDirection.rtl),
              SizedBox(width: 10),
              Icon(Icons.replay, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("نقش های من", textDirection: TextDirection.rtl),
              SizedBox(width: 10),
              Icon(Icons.list_alt, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ],
    );
  }

  _menuOnSelected(int value, BuildContext context) {
    switch (value) {
      case 1:
        Provider.of<RolesNPlayers>(context, listen: false).recoverLastRoles();
        break;
      case 2:
        showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                builder: (builder) => MyRoles())
            .then((value) => Provider.of<RolesNPlayers>(context, listen: false)
                .saveCustomRoles());
        break;
    }
  }
}
