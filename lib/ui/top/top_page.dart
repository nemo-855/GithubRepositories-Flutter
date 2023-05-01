import 'dart:ui';
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
      body: _buildScaffoldBody(
          state: state,
          onProjectCardPressed: () => {
            // TODO 実装
          },
      )
    );
  }
  
  Widget _buildScaffoldBody({
    required TopUiState state,
    required VoidCallback onProjectCardPressed,
  }) {
    if (state.isLoading) {
      return const SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          )
      );
    } else {
      return SafeArea(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            children: state.projects
                .map((e) => _buildProjectCard(uiModel: e, onPressed: onProjectCardPressed))
                .toList(),
          )
      );
    }
  }

  Widget _buildProjectCard({
    required ProjectUiModel uiModel,
    required VoidCallback onPressed,
  }) {
    return Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Expanded(
                  child: Image.network(uiModel.ownerImage)
              ),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: ClipRect(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white.withOpacity(0.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                                    uiModel.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                )
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              constraints: const BoxConstraints(),
                              onPressed: onPressed,
                              icon: const Icon(Icons.arrow_circle_right_sharp),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}