import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/ui/top/top_view_model.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _topViewModel = ref.watch(topViewModelProvider);

    return const Center(
        child: Text("TopPage")
    );
  }
}