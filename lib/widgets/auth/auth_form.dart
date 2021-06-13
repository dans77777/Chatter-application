import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  String _userEmail = '';
  String _userPassword = '';
  String _userName = '';
  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || (!value.contains('@'))) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  onSaved: (val) {
                    _userEmail = val;
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'please enter atleast 4 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'UserName'),
                  onSaved: (val) {
                    _userName = val;
                  },
                ),
                if (!isLogin)
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'passwords must be atleast 7 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (val) {
                      _userPassword = val;
                    },
                  ),
                SizedBox(
                  height: 13,
                ),
                RaisedButton(
                  onPressed: _saveForm,
                  child: Text('Submit'),
                ),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? Text('create new account')
                        : Text('I alredy have an account'))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
