import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/services/app_localizations.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('login_page_title')),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('login_header'),
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                        onSaved: (value) => _email = value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .translate('email'))),
                    TextFormField(
                        onSaved: (value) => _password = value,
                        obscureText: true,
                        decoration: InputDecoration(labelText:
                        AppLocalizations.of(context).translate('password'),)),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          child: Text(AppLocalizations.of(context).translate(
                              'login_button')),
                          onPressed: () async {
                            final form = _formKey.currentState;
                            form.save();

                            if (form.validate()) {
                              try {
                                FirebaseUser result =
                                await Provider.of<AuthService>(context)
                                    .loginUser(
                                    email: _email, password: _password);
                                print(result);
                              } on AuthException catch (error) {
                                return _buildErrorDialog(
                                    context, error.message);
                              } on Exception catch (error) {
                                return _buildErrorDialog(
                                    context, error.toString());
                              }
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          child: Text(AppLocalizations.of(context).translate
                            ('login_button_facebook')),
                          onPressed: () async {
                            try {
                              FirebaseUser result =
                              await Provider.of<AuthService>(context)
                                  .loginWithFacebook();
                              print(result);
                            } on AuthException catch (error) {
                              return _buildErrorDialog(context, error.message);
                            } on Exception catch (error) {
                              return _buildErrorDialog(context, error
                                  .toString());
                            }
                          }),
                    ),
                    RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        child: Text(AppLocalizations.of(context).translate
                          ('login_button_google')),
                        onPressed: () async {
                          try {
                            FirebaseUser result =
                            await Provider.of<AuthService>(context)
                                .loginWithGoogle();
                            print(result);
                          } on AuthException catch (error) {
                            return _buildErrorDialog(context, error.message);
                          } on Exception catch (error) {
                            return _buildErrorDialog(context, error.toString());
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          child: Text(AppLocalizations.of(context).translate
                            ('create_account')),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/accountCreation');
                          }),
                    ),
                  ],
                ))),
      ),
    );
  }
}

Future _buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context).translate('error_message')),
        content: Text(_message),
        actions: [
          FlatButton(
              child: Text(AppLocalizations.of(context).translate('cancel')),
              onPressed: () async {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
