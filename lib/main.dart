import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lend_a_hand/pages/account_creation.dart';
import 'package:lend_a_hand/pages/chat_list_page.dart';
import 'package:lend_a_hand/pages/edit_location.dart';
import 'package:lend_a_hand/pages/loading_location.dart';
import 'package:lend_a_hand/services/app_localizations.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() => runApp(ChangeNotifierProvider<AuthService>(
    child: MyApp(),
    create: (BuildContext context) {
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
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.error != null) {
                  return Text(snapshot.error.toString());
                }
                return snapshot.hasData ? HomePage() : LoginPage();
              default:
                return new Text('');
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
            case '/chatList':
              return MaterialPageRoute(builder: (context) => ChatList());
            default:
              return MaterialPageRoute(builder: (context) => HomePage());
          }
        },
        supportedLocales: [const Locale('en', 'US'), const Locale('es', 'ES')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false);
  }
}
