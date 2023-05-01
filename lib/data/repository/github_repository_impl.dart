import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/data/api/github_api.dart';
import 'package:github_repositories_flutter/data/api/github_api_impl.dart';
import 'package:github_repositories_flutter/data/api/response/fetch_project_response.dart';
import 'package:github_repositories_flutter/domain/api_error.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';
import '../../domain/repository/github_repository.dart';

final githubRepositoryProvider = Provider<GithubRepository>((ref) => _GithubRepositoryImpl(ref.watch(githubApiProvider)));

class _GithubRepositoryImpl implements GithubRepository {
  final GithubApi _githubApi;
  const _GithubRepositoryImpl(this._githubApi);

  @override
  Future<List<GithubProject>> getAllProjects() async {
    try {
      final response = await _githubApi.fetchAllProjects();
      return response.map((e) => e.toGithubProject()).toList();
    } catch(e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
