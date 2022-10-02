import 'package:bottom_navigator/tab_navigator.dart';
import 'package:flutter/material.dart';

import 'color_detail_page.dart';

enum TabItem { red, blue, green }

const Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.blue: 'blue',
  TabItem.green: 'green'
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.blue: Colors.blue,
  TabItem.green: Colors.green
};

class BottomnavigatorApp extends StatefulWidget {
  const BottomnavigatorApp({Key? key}) : super(key: key);

  @override
  State<BottomnavigatorApp> createState() => _BottomnavigatorAppState();
}

class _BottomnavigatorAppState extends State<BottomnavigatorApp> {
  var _currentTab = TabItem.red;

  void _selectTab(TabItem item) {
    setState(() {
      _currentTab = item;
    });
  }

  final navigatorKey = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKey[_currentTab]!.currentState!.maybePop(),
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(TabItem.red),
            _buildOffstageNavigator(TabItem.blue),
            _buildOffstageNavigator(TabItem.green),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    print("$_currentTab curren");
    print("$tabItem tabitem");
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKey[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }

  // Widget _buildBody() {
  //   return Container(
  //       color: activeTabColor[TabItem.red],
  //       alignment: Alignment.center,
  //       child: MaterialButton(
  //         onPressed: _push,
  //         child: const Text(
  //           'PUSH',
  //           style: TextStyle(fontSize: 32.0, color: Colors.white),
  //         ),
  //       ));
  // }

  // void _push() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     // we'll look at ColorDetailPage later
  //     builder: (context) => ColorsListPage(
  //       color: activeTabColor[TabItem.red],
  //       title: tabName[TabItem.red],
  //       onPush: (int value) {},
  //     ),
  //   ));
  // }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(color: Colors.red),
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.red),
        _buildItem(TabItem.blue),
        _buildItem(TabItem.green),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  MaterialColor? _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}
