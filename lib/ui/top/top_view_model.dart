import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';
import 'package:github_repositories_flutter/domain/repository/github_repository.dart';
import 'package:github_repositories_flutter/ui/top/top_ui_state.dart';
import '../../data/repository/github_repository_impl.dart';

final topViewModelProvider = StateNotifierProvider.autoDispose<
    TopViewModel,
    TopUiState>(
      (ref) => TopViewModel(ref.watch(githubRepositoryProvider)),
);

class TopViewModel extends StateNotifier<TopUiState> {
  final GithubRepository _githubRepository;
  TopViewModel(this._githubRepository) : super(
      TopUiState(
          isLoading: true,
          projectsSectionTitle: "",
          projects: List<ProjectUiModel>.empty()
      )
  );

  void onInitialized() async {
    try {
      final List<GithubProject> projects = await _githubRepository.getAllProjects();
      state = state.onProjectsUpdated(projects);
    } catch (e) {
      // TODO Snackbar State的なものを作る
    }
  }

  void onProjectsTitleSet({required String title}) {
    state = state.onProjectsTitleSet(title);
  }
}
