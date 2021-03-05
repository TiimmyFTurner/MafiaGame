import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum Mode { Login, Signup }

class LoginSignup extends StatefulWidget {
  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  Mode _status = Mode.Login;
  @override
  void initState() {
    super.initState();
  }

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'username': null
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
                  onSaved: (String value) => _formData['username'] = value,
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
        child: Hero(
          tag: 'cafe',
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            onPressed: () {
              if (_formKey.currentState.validate() &&
                  _formData['acceptTerms']) {
                _formKey.currentState.save();
                Navigator.pushReplacementNamed(context, '/main');
              }
            },
            child: Text(
              _status == Mode.Login ? 'ورود' : 'ثبت نام',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChangeStatusButton() {
    return SizedBox(
      height: 55,
      width: 1000,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
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
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
