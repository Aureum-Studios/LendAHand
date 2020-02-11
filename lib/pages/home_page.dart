import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/pages/chat_list_page.dart';
import 'package:lend_a_hand/pages/edit_location.dart';
import 'package:lend_a_hand/pages/jobs_page.dart';
import 'package:lend_a_hand/pages/user_profile_page.dart';
import 'package:lend_a_hand/services/app_localizations.dart';
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
  static FirebaseUser _firebaseUser;

  final PageStorageBucket bucket = PageStorageBucket();

  //TODO: Replace for rest of pages
  List<Widget> _pages = [
    JobsPage(key: PageStorageKey('JobsPage')),
    ChatList(key: PageStorageKey('ChatList'), firebaseUser: _firebaseUser),
    UserProfile(),
    EditLocation(),
    JobsPage(key: PageStorageKey('JobsPage3')),
  ];

  // TODO - Debug as to why provider.getUser() does not work will passed to future widgets.
  @override
  void initState() {
    super.initState();
    //getCurrentUser();
    test(FirebaseAuth.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context).translate('home_page_title')),
          actions: <Widget>[
            PopupMenuButton<String>( // Put type of below widget here
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                //TODO: Create widget that take text and icon, return here.
                return [PopupMenuItem(value: AppLocalizations.of(context)
                    .translate('logout_button'),
                    child: Text(AppLocalizations.of(context).translate(
                        'logout_button')))
                ];
              },
            ),
          ],
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
                title: new Text(
                    AppLocalizations.of(context).translate('home_bar_item')),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.mail),
                title: new Text(AppLocalizations.of(context).translate(
                    'messages_bar_item')),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text(AppLocalizations.of(context).translate
                    ('profile_bar_item'))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  title: Text(AppLocalizations.of(context).translate
                    ('location_bar_item'))),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context).translate
                    ('settings_bar_item')))
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

  void getCurrentUser() async {
    _firebaseUser = await Provider.of<AuthService>(context).getUser();
  }

  void test(FirebaseAuth _auth) async {
    _firebaseUser = await _auth.currentUser();
  }

  void _select(String value) async {
    await Provider.of<AuthService>(context).logout();
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));
    return null;
  }
}
