import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mafia/pages/cafeMafia/mainEventList.dart';
import 'package:mafia/providers/providers.dart';

enum Mode { Login, Signup }

class LoginSignup extends StatefulWidget {
  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  Mode _status = Mode.Login;
  Future<bool> _futureUser;

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'name': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEMailTextField() {
    return TextFormField(
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        labelText: 'ایمیل',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        return value.isEmpty ||
                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(value)
            ? 'فرم ورودی ایمیل صحیح نمیباشد'
            : null;
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildUsernameTextField() {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _status == Mode.Signup
            ? Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: TextFormField(
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    labelText: 'نام کاربری',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  validator: (String value) =>
                      value.isNotEmpty || _status == Mode.Login
                          ? null
                          : 'نام کاربری نمیتواند خالی باشد',
                  onSaved: (String value) => _formData['name'] = value,
                ),
              )
            : Container());
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        labelText: 'رمز عبور',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      obscureText: true,
      validator: (String value) => value.isEmpty || value.length < 6
          ? 'رمز عبور باید بیشتر از 6 کاراکتر باشد'
          : null,
      onSaved: (String value) => _formData['password'] = value,
    );
  }

  Widget _buildSubmitButton() {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(40),
      color: Colors.black,
      shadowColor: Theme.of(context).primaryColor,
      elevation: 10,
      child: SizedBox(
        height: 55,
        width: 1000,
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
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              setState(() {
                _futureUser = _status == Mode.Login
                    ? Provider.of<CafeMafia>(context, listen: false)
                        .login(_formData)
                    : Provider.of<CafeMafia>(context, listen: false)
                        .signup(_formData);
                _futureUser.then(
                  (value) {
                    if (value) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => MainEventList()));
                      return true;
                    }
                    return false;
                  },
                );
              });
            }
          },
          child: Text(
            _status == Mode.Login ? 'ورود' : 'ثبت نام',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeStatusButton() {
    return SizedBox(
      height: 55,
      width: 1000,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).accentColor,
          ),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).textTheme.button.color,
          ),
        ),
        onPressed: () {
          setState(() {
            _status = _status == Mode.Login ? Mode.Signup : Mode.Login;
          });
        },
        child: Text(
          _status == Mode.Login
              ? 'اکانت کافه مافیا ندارم'
              : 'اکانت کافه مافیا دارم',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/images/homeWP.jpg"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return (_futureUser == null)
                  ? SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                            minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      _buildUsernameTextField(),
                                      _buildEMailTextField(),
                                      SizedBox(height: 18),
                                      _buildPasswordTextField(),
                                      SizedBox(height: 24),
                                      _buildSubmitButton(),
                                      SizedBox(height: 16),
                                      _buildChangeStatusButton(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).accentColor.withOpacity(.8),
                            borderRadius: BorderRadius.circular(24)),
                        child: FutureBuilder<bool>(
                          future: _futureUser,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.toString());
                            } else if (snapshot.hasError) {
                              Future.delayed(
                                Duration(seconds: 3),
                                () => setState(() => _futureUser = null),
                              );
                              String error = snapshot.error.toString();
                              return Text(
                                error.contains('Douplicate')
                                    ? 'کاربری با ایمیل وارد شده وجود دارد'
                                    : error,
                                style: TextStyle(fontSize: 16),
                              );
                            }
                            return CircularProgressIndicator(
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.8),
                            );
                          },
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
