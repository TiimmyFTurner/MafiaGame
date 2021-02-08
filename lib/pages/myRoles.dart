import 'package:Mafia/models/role.dart';
import 'package:Mafia/providers/providers.dart';
import 'package:Mafia/widgets/listItemRole.dart';
import 'package:flutter/material.dart';

class MyRoles extends StatefulWidget {
  @override
  _MyRolesState createState() => _MyRolesState();
}

class _MyRolesState extends State<MyRoles> {
  final Map<String, dynamic> _addRoleFormData = {
    'name': null,
    'job': null,
    'type': null,
    'order': null
  };
  final GlobalKey<FormState> _addRoleFormKey = GlobalKey<FormState>();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    List statusIcon = [
      IconButton(
          key: ValueKey(1),
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              status = !status;
            });
          }),
      IconButton(
        key: ValueKey(2),
        icon: Icon(Icons.list),
        onPressed: () {
          setState(() {
            status = !status;
          });
        },
      ),
    ];
    return Container(
      height: MediaQuery.of(context).size.height / 1.13,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context)),
              ),
              Text("نقش های من", style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: statusIcon[status ? 1 : 0],
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(child: child, scale: animation),
                ),
              ),
            ],
          ),
          _body()
        ],
      ),
    );
  }

  Widget _body() {
    if (status) {
      return Form(
        key: _addRoleFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Flexible(child: _buildRoleTypeDropDownField()),
                  SizedBox(width: 10),
                  Flexible(child: _buildRoleNameTextField()),
                ],
              ),
              SizedBox(height: 10),
              _buildRoleJobTextField(),
              _buildAddBtnTextField()
            ],
          ),
        ),
      );
    } else {
      if (Provider.of<RolesNPlayers>(context).customRoles.isEmpty ||
          Provider.of<RolesNPlayers>(context).customRoles == null) {
        return Column(
          children: [
            Image.asset("asset/images/empty.png"),
            Text(
              'نقشی وجود نداره',
              style: TextStyle(fontSize: 22),
            ),
            Opacity(
              opacity: .6,
              child: Text(
                "برای اضافه کردن نقش جدید از ' + ' استفاده کنید ",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        );
      } else {
        return _roleGeidView(
            roles: Provider.of<RolesNPlayers>(context).customRoles);
      }
    }
  }

  Widget _roleGeidView({List roles}) {
    return GridView.count(
      padding: EdgeInsets.all(10),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
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
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                  ),
                  child: _roleDatails(context, roles[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _roleDatails(context, role) {
    String type = role.type == 'C'
        ? "شهروند"
        : role.type == 'M'
            ? "مافیا"
            : "مستقل";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () => showAlertDialog(context, role),
              ),
            ],
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

  showAlertDialog(BuildContext context, Role role) {
    Widget cancelButton = FlatButton(
      child: Text("بازگشت",
          style: TextStyle(color: Theme.of(context).textTheme.button.color)),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("حذف", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Provider.of<RolesNPlayers>(context, listen: false).removeCustomRole =
            role;
      },
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      backgroundColor: Theme.of(context).accentColor,
      title: Text("نقش مورد نظر حذف شود ؟"),
      actions: [
        ButtonBar(
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(textDirection: TextDirection.rtl, child: alert);
      },
    );
  }

  Widget _buildRoleNameTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: TextFormField(
          onSaved: (String value) {
            _addRoleFormData['name'] = value;
          },
          validator: (String value) => value.isEmpty || value.length < 1
              ? 'نام نقش نمیتواند خالی باشد'
              : null,
          decoration: InputDecoration(
            labelText: 'نام نقش',
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleTypeDropDownField() {
    String roleType;
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField(
          validator: (String value) =>
              value == null ? 'نوع نقش را انتخاب کنید' : null,
          dropdownColor: Theme.of(context).accentColor,
          value: roleType,
          items: [
            {'name': 'مافیا', 'value': 'M'},
            {'name': 'شهروند', 'value': 'C'},
            {'name': 'مستقل', 'value': 'I'}
          ].map(
            (item) {
              return DropdownMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      item['name'],
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                value: item['value'],
              );
            },
          ).toList(),
          onChanged: (value) {
            _addRoleFormData['type'] = value;
            _addRoleFormData['order'] = value == 'M'
                ? 15
                : value == 'C'
                    ? 43
                    : 59;
          },
          decoration: InputDecoration(
            labelText: 'نوع نقش',
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleJobTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: TextFormField(
          maxLines: 2,
          onSaved: (String value) {
            _addRoleFormData['job'] = value;
          },
          validator: (String value) => value.isEmpty || value.length < 1
              ? 'وظیفه نقش نمیتواند خالی باشد'
              : null,
          decoration: InputDecoration(
            labelText: 'وظیفه',
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
          ),
        ),
      ),
    );
  }

  Widget _buildAddBtnTextField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: PhysicalModel(
        borderRadius: BorderRadius.circular(40),
        color: Colors.black,
        shadowColor: Theme.of(context).primaryColor,
        elevation: 15,
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: RaisedButton(
            elevation: 0,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Text(
              'اضافه کردن',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w300, letterSpacing: 3),
            ),
            onPressed: () {
              if (_addRoleFormKey.currentState.validate()) {
                _addRoleFormKey.currentState.save();

                Provider.of<RolesNPlayers>(context, listen: false)
                    .addCustomRole = Role.fromMap(_addRoleFormData);
                setState(() {
                  status = !status;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
