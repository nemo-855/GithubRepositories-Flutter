import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repositories_flutter/data/api/response/owner_response.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';

part 'fetch_project_response.freezed.dart';
part 'fetch_project_response.g.dart';

@freezed
class FetchProjectResponse with _$FetchProjectResponse {
  const factory FetchProjectResponse({
    required int id,
    required String name,
    required bool private,
    required String created_at,
    required String html_url,
    required OwnerResponse owner,
  }) = _FetchProjectResponse;

  factory FetchProjectResponse.fromJson(Map<String, Object?> json)
    => _$FetchProjectResponse(json);

  GithubProject toGithubProject() {
    return GithubProject(
        id: id,
        name: name,
        isPrivate: private,
        owner: owner.toOwner(),
        htmlUrl: html_url,
        createdAt: DateTime.parse(created_at),
    );
  }
}
