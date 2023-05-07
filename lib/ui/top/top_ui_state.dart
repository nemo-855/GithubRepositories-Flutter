import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repositories_flutter/domain/model/Sponsore.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';

part 'top_ui_state.freezed.dart';
part 'top_ui_state.g.dart';

@freezed
class TopUiState with _$TopUiState {
  @JsonSerializable(explicitToJson: true)

  const factory TopUiState({
    required bool isLoading,
    required CarouselUiModel carouselUiModel,
    required String pageName,
    required String pageDescription,
    required String projectsSectionTitle,
    required List<ProjectUiModel> projects,
  }) = _TopUiState;

  factory TopUiState.fromJson(Map<String, dynamic> json) => _$TopUiStateFromJson(json);
}

@freezed
class CarouselUiModel with _$CarouselUiModel {
  @JsonSerializable(explicitToJson: true)

  const factory CarouselUiModel({
    required List<String> images,
    required int currentIndex,
  }) = _CarouselUiModel;

  factory CarouselUiModel.fromJson(Map<String, dynamic> json) => _$CarouselUiModelFromJson(json);
}

@freezed
class ProjectUiModel with _$ProjectUiModel {
  @JsonSerializable(explicitToJson: true)

  const factory ProjectUiModel({
    required int id,
    required String name,
    required String ownerName,
    required String ownerImage
  }) = _ProjectUiModel;

  factory ProjectUiModel.fromJson(Map<String, dynamic> json) => _$ProjectUiModelFromJson(json);
}

extension TopUiEvent on TopUiState {
  TopUiState onProjectsUpdated({
    required List<GithubProject> projects,
    required List<Sponsor> sponsors,
  }) => copyWith(
      isLoading: false,
      carouselUiModel: CarouselUiModel(
        images: sponsors.map((e) => e.imageUrl).toList(),
        currentIndex: 0,
      ),
      projects: projects
          .map((e) => ProjectUiModel(
        id: e.id,
        name: e.name,
        ownerName: e.owner.name,
        ownerImage: e.owner.avatarUrl,
      ))
          .toList());

  TopUiState onTextAssetSet({
    required String pageName,
    required String pageDescription,
    required String projectsSectionTitle,
  }) => copyWith(
      pageName: pageName,
      pageDescription: pageDescription,
      projectsSectionTitle: projectsSectionTitle,
  );

  TopUiState onCarouselPageChanged({
    required int newIndex
  }) => copyWith(
    carouselUiModel: carouselUiModel.copyWith(
      currentIndex: newIndex
    )
  );
}