import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/jobs_page.dart';
import 'package:lend_a_hand/pages/loading_account.dart';
import 'package:lend_a_hand/services/auth_service.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  int _currentIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  //TODO: Replace for rest of pages
  List<Widget> _pages = [
    JobsPage(key: PageStorageKey('JobsPage')),
    LoadingAccount(),
    JobsPage(key: PageStorageKey('JobsPage2')),
    JobsPage(key: PageStorageKey('JobsPage3')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: new Icon(Icons.exit_to_app),
                onPressed: () async {
                  await Provider.of<AuthService>(context).logout();
                })
          ],
          title: Text("Home"),
          //actions: <Widget>[LogoutButton()],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabPressed,
            currentIndex: _currentIndex,
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                title: new Text('Messages'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('Settings'))
            ]),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: PageStorage(
            child: _pages[_currentIndex],
            bucket: bucket,
          ),
          onRefresh: _handleRefresh,
        ));
  }

  void onTabPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

Future<Null> _handleRefresh() async {
  await new Future.delayed(new Duration(seconds: 3));
  return null;
}
