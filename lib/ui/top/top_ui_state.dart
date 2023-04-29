import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_ui_state.freezed.dart';

@freezed
class TopUiState with _$TopUiState {
  const factory TopUiState({
    required List<ProjectUiModel> projects,
  }) = _TopUiState;
}

@freezed
class ProjectUiModel with _$ProjectUiModel {
  const factory ProjectUiModel({
    required int projectId,
    required String ownerName,
    required String ownerImage
  }) = _ProjectUiModel;
}
