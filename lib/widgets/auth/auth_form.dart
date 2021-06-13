import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
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
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'passwords must be atleast 7 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'UserName'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'please enter atleast 4 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 13,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Submit'),
                ),
                FlatButton(onPressed: () {}, child: Text('create new account'))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
