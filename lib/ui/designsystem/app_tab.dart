import 'package:flutter/material.dart';

enum AppTab {
  top(name: "Park", icon: Icon(Icons.home)),
  talk(name: "Talk", icon: Icon(Icons.phone)),
  chat(name: "Chat", icon: Icon(Icons.chat)),
  menu(name: "Menu", icon: Icon(Icons.person));

  const AppTab({
    required this.name,
    required this.icon,
  });

  final String name;
  final Icon icon;
}
