import 'package:flutter/material.dart';
import 'app_root.dart';
import 'app_theme.dart';

class GithubRepositoriesApp extends StatelessWidget {
  const GithubRepositoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: const AppRoot(),
    );
  }
}
