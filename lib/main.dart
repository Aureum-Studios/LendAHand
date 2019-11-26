import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/account_creation.dart';
import 'package:lend_a_hand/pages/loading_account.dart';
import 'package:lend_a_hand/pages/edit_location.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/location',
  routes: {
    '/': (context) => LoadingAccount(),
    '/accountCreation': (context) => AccountCreation(),
    '/location': (context) => Location()
  },
));