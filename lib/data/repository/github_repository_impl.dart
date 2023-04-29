import 'package:github_repositories_flutter/data/api/github_api.dart';
import 'package:github_repositories_flutter/domain/api_error.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';
import 'github_repository.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubApi _githubApi;
  const GithubRepositoryImpl(this._githubApi);

  @override
  Future<List<GithubProject>> getAllProjects(String userName) async {
    try {
      final response = await _githubApi.fetchAllProjects(userName);
      return response.map((e) => e.toGithubProject()).toList();
    } catch(e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
