import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/AccountCreation.dart';
import 'package:lend_a_hand/pages/LoadingAccount.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/accountCreation',
  routes: {
    '/': (context) => LoadingAccount(),
    '/accountCreation': (context) => AccountCreation()
  },
));