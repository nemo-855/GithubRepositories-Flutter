import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repositories_flutter/data/api/response/owner_response.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';

part 'fetch_project_response.freezed.dart';
part 'fetch_project_response.g.dart';

@freezed
class FetchProjectResponse with _$FetchProjectResponse {
  @JsonSerializable(explicitToJson: true)

  const factory FetchProjectResponse({
    required int id,
    required String name,
    required bool private,
    @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "html_url") required String htmlUrl,
    required OwnerResponse owner,
  }) = _FetchProjectResponse;

  factory FetchProjectResponse.fromJson(Map<String, Object?> json)
    => _$FetchProjectResponseFromJson(json);
}

extension ResponseConverter on FetchProjectResponse {
  GithubProject toGithubProject() {
    return GithubProject(
      id: id,
      name: name,
      isPrivate: private,
      owner: owner.toOwner(),
      htmlUrl: htmlUrl,
      createdAt: DateTime.parse(createdAt),
    );
  }
}
