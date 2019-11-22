import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAccount extends StatefulWidget {
  @override
  _LoadingAccountState createState() => _LoadingAccountState();
}

class _LoadingAccountState extends State<LoadingAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
