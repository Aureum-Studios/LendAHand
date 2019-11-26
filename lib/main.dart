import 'package:flutter/materialge:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';

void main() =>
    runApp(ChangeNotifierProvider<AuthService>(
        child: MyApp(),
        builder: (BuildContext context) {
          return AuthService();
        }));

class MyApp extends StatelessWidget {
  // This widget is the root of you/**/r application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LendAHAnd',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder(
          future: Provider.of<AuthService>(context).getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                print("error");
                return Text(snapshot.error.toString());
              }
              // redirect to the proper page, pass the user into the
              // `HomePage` so we can display the user email in welcome msg     ⇐ NEW
              return snapshot.hasData ? HomePage(snapshot.data) : LoginPage();
            } else {
              return LoadingCircle();
            }
          },
        ),
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
