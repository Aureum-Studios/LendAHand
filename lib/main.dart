import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/account_creation.dart';
import 'package:lend_a_hand/pages/chat_list.dart';
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
                print("error");
                return Text('${snapshot.error.toString()}');
              }
              return snapshot.hasData ? HomePage() : LoginPage();
            } else {
              return LoadingCircle();
            }
          },
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (context) => HomePage());
              break;
            case '/accountCreation':
              return MaterialPageRoute(builder: (context) => AccountCreation());
              break;
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginPage());
              break;
            case '/loadLocation':
              return MaterialPageRoute(builder: (context) => LoadingLocation());
              break;
            case '/editLocation':
              return MaterialPageRoute(builder: (context) => EditLocation());
              break;
            case '/chatList':
              return MaterialPageRoute(builder: (context) => ChatList());
              break;
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
