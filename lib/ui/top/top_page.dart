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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).text("floor_map"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2,
                    ),
                    primary: false,
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      return _buildProjectCard(
                        uiModel: state.projects[index],
                        onPressed: onProjectCardPressed,
                      );
                    }
                )
              ],
            ),
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
                        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white.withOpacity(0.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                                    uiModel.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                )
                            ),
                            const Icon(Icons.arrow_circle_right_sharp),
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