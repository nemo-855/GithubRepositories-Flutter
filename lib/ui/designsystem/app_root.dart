import 'package:flutter/material.dart';
import 'package:github_repositories_flutter/ui/chat/chat_page.dart';
import 'package:github_repositories_flutter/ui/menu/menu_page.dart';
import 'package:github_repositories_flutter/ui/talk/talk_page.dart';
import 'package:github_repositories_flutter/ui/top/top_page.dart';
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
      body: IndexedStack(
        index: _selectedTab.index,
        children: const [
          TopPage(),
          TalkPage(),
          ChatPage(),
          MenuPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: AppTab.values
            .map((e) => BottomNavigationBarItem(
                  icon: e.icon,
                  label: e.name,
                ))
            .toList(),
        currentIndex: _selectedTab.index,
        onTap: (int tabIndex) {
          setState(
            () {
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
