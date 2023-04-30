import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';

part 'top_ui_state.freezed.dart';
part 'top_ui_state.g.dart';

@freezed
class TopUiState with _$TopUiState {
  @JsonSerializable(explicitToJson: true)

  const factory TopUiState({
    required bool isLoading,
    required List<ProjectUiModel> projects,
  }) = _TopUiState;

  factory TopUiState.fromJson(Map<String, dynamic> json) => _$TopUiStateFromJson(json);
}

@freezed
class ProjectUiModel with _$ProjectUiModel {
  @JsonSerializable(explicitToJson: true)

  const factory ProjectUiModel({
    required int projectId,
    required String ownerName,
    required String ownerImage
  }) = _ProjectUiModel;

  factory ProjectUiModel.fromJson(Map<String, dynamic> json) => _$ProjectUiModelFromJson(json);
}

extension TopUiEvent on TopUiState {
  TopUiState onProjectsUpdated(List<GithubProject> projects) => copyWith(
      isLoading: false,
      projects: projects
          .map((e) => ProjectUiModel(
                projectId: e.id,
                ownerName: e.owner.name,
                ownerImage: e.owner.avatarUrl,
              ))
          .toList());
}
