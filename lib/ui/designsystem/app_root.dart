import 'package:flutter/material.dart';
import 'app_tab.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  AppTab _selectedTab = AppTab.top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: AppTab.values.map((e) =>
          BottomNavigationBarItem(
              icon: e.icon,
              label: e.name,
          )
        ).toList(),
        currentIndex: _selectedTab.index,
        onTap: (int tabIndex) {
          // TODO 遷移処理
          setState(() {
              _selectedTab = AppTab.values[tabIndex];
            },
          );
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
