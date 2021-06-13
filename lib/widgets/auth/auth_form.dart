import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx) _submitAuthForm;
  bool isLoading;
  AuthForm(this._submitAuthForm, this.isLoading);
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
      widget._submitAuthForm(_userEmail.trim(), _userName.trim(),
          _userPassword.trim(), isLogin, context);
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
                  key: ValueKey('email'),
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
                  key: ValueKey('username'),
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
                    key: ValueKey('password'),
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
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _saveForm,
                    child: Text('Submit'),
                  ),
                if (!widget.isLoading)
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
