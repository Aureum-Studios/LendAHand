import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/account_creation.dart';
import 'package:lend_a_hand/pages/edit_location.dart';
import 'package:lend_a_hand/pages/loading_location.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() => runApp(ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    builder: (BuildContext context) {
      return AuthService();
    }));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LendAHand',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder(
          future: Provider.of<AuthService>(context).getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                print(snapshot.error.toString());
                return Text(snapshot.error.toString());
              }
              print('no error, ready to go');
              return snapshot.hasData ? HomePage() : LoginPage();
            } else {
              print('loading circle');
              return LoadingCircle();
            }
          },
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (context) => HomePage());
            case '/accountCreation':
              return MaterialPageRoute(builder: (context) => AccountCreation());
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginPage());
            case '/loadLocation':
              return MaterialPageRoute(builder: (context) => LoadingLocation());
            case '/editLocation':
              return MaterialPageRoute(builder: (context) => EditLocation());
            default:
              return MaterialPageRoute(builder: (context) => HomePage());
          }
        },
        debugShowCheckedModeBanner: false);
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
