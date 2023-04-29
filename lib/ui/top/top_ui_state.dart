import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';

part 'top_ui_state.freezed.dart';

@freezed
class TopUiState with _$TopUiState {
  const factory TopUiState({
    required bool isLoading,
    required List<ProjectUiModel> projects,
  }) = _TopUiState;

  TopUiState onProjectsUpdated(List<GithubProject> projects) {
    return copyWith(
        isLoading: true,
        projects: projects.map((e) => ProjectUiModel(
          projectId: e.id,
          ownerName: e.owner.name,
          ownerImage: e.owner.avatarUrl,
        )).toList()
    );
  }
}

@freezed
class ProjectUiModel with _$ProjectUiModel {
  const factory ProjectUiModel({
    required int projectId,
    required String ownerName,
    required String ownerImage
  }) = _ProjectUiModel;
}
