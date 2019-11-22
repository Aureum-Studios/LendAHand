import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/account_creation.dart';
import 'package:lend_a_hand/pages/loading_account.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/accountCreation',
  routes: {
    '/': (context) => LoadingAccount(),
    '/accountCreation': (context) => AccountCreation()
  },
));