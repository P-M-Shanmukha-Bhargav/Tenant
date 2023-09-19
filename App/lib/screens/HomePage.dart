import 'package:flutter/material.dart';
import 'package:houseapp/screens/Tenant/HomeScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with RestorationMixin{
  final RestorableInt _currentIndex = RestorableInt(0);

  @override
  String? get restorationId => "";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: "Home"
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: "Account"
      )
    ];

    var navigationScreens = const [
      HomeScreen(),
      Center(
        child: Text("Settings"),
      )
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: navigationScreens[_currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20,
        unselectedFontSize: 10,
        onTap: (index) {
          setState(() {
            _currentIndex.value = index;
          });
        },
      ),
    );
  }
}