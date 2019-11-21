import 'package:flutter/material.dart';
import 'package:lend_a_hand/services/AccountService.dart';
import 'package:email_validator/email_validator.dart';

class AccountCreation extends StatefulWidget {
  @override
  _AccountCreationState createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  final GlobalKey<FormState> _accFormKey = new GlobalKey<FormState>();
  AccountService account = new AccountService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Sign up'
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Form(
          key: _accFormKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              new InputEmail(account: account),
              new InputName(account: account),
              new InputPassword(account: account),
              new SubmitButton(accFormKey: _accFormKey, account: account)
            ],
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    @required GlobalKey<FormState> accFormKey,
    @required this.account,
  }) : _accFormKey = accFormKey, super(key: key);

  final GlobalKey<FormState> _accFormKey;
  final AccountService account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
      child: RaisedButton(
        onPressed: () {
          if(_accFormKey.currentState.validate()) {
            _accFormKey.currentState.save();

            print(this.account.name);
            print(this.account.email);
            print(this.account.password);
            account.saveAccount();
          }
        },
        color: Colors.amber,
        child: Text('Sign Up'),
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key key,
    @required this.account,
  }) : super(key: key);

  final AccountService account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          labelText: 'PASSWORD',
        ),
        validator: (value) {
          if(value.length < 8)
            return 'Invalid password, minimum length: 8 characters';
          else if(value.length > 16)
            return 'Invalid password, maximum length 16 characters';
          else
            return null;
        },
        onSaved: (value) => account.password = value,
      ),
    );
  }
}

class InputName extends StatelessWidget {
  const InputName({
    Key key,
    @required this.account,
  }) : super(key: key);

  final AccountService account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 5.0),
      child: TextFormField(
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          hintText: 'Ex John Doe',
          labelText: 'NAME'
        ),
        validator: (value) => value.isNotEmpty ? null : 'Please enter a name',
        onSaved: (value) => account.name = value,
      ),
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key key,
    @required this.account,
  }) : super(key: key);

  final AccountService account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      child: TextFormField(
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0)
          ),
          hintText: 'Ex johndoe@email.com',
          labelText: 'EMAIL'
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => EmailValidator.validate(value) ? null : 'Please enter a valid email',
        onSaved: (value) => account.email = value,
      ),
    );
  }
}
