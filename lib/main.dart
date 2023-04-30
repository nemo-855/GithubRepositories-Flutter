import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/ui/designsystem/github_repositories_app.dart';

void main() {
  runApp(
    const ProviderScope(
        child: GithubRepositoriesApp()
    )
  );
}
