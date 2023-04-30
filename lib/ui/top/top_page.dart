import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/ui/top/top_ui_state.dart';
import 'package:github_repositories_flutter/ui/top/top_view_model.dart';

class TopPage extends ConsumerStatefulWidget {
  const TopPage({super.key});

  @override
  TopPageState createState() => TopPageState();
}

class TopPageState extends ConsumerState<TopPage> {
  @override
  void initState() {
    super.initState();

    final topViewModel = ref.read(topViewModelProvider.notifier);
    topViewModel.onInitialized();
  }

  @override
  Widget build(BuildContext context) {
    final topViewModel = ref.watch(topViewModelProvider.notifier);
    final state = ref.watch(topViewModelProvider);

    return Scaffold(
      body: _buildScaffoldBody(state)
    );
  }
  
  Widget _buildScaffoldBody(TopUiState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text("TopPage"),
      );
    }
  }
}