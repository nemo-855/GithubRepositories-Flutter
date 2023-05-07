import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/domain/model/Sponsore.dart';
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
          pageName: "",
          pageDescription: "",
          carouselUiModel: CarouselUiModel(
            images: List<String>.empty(),
            currentIndex: 0,
          ),
          projectsSectionTitle: "",
          projects: List<ProjectUiModel>.empty()
      )
  );

  void onInitialized() async {
    try {
      final Future<List<GithubProject>> projects = _githubRepository.getAllProjects();
      final Future<List<Sponsor>> sponsors = _githubRepository.getSponsors();

      state = state.onProjectsUpdated(
          projects: await projects,
          sponsors: await sponsors,
      );
    } on Exception catch (_, e) {
      // TODO Snackbar State的なものを作る
    }
  }

  void onTextAssetSet({
    required String pageName,
    required String pageDescription,
    required String projectsSectionTitle,
  }) {
    state = state.onTextAssetSet(
        pageName: pageName,
        pageDescription: pageDescription,
        projectsSectionTitle: projectsSectionTitle
    );
  }

  void onCarouselPageChanged({required int newIndex}) {
    state = state.onCarouselPageChanged(newIndex: newIndex);
  }
}
