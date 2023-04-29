import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/data/api/github_api.dart';
import 'package:github_repositories_flutter/data/api/github_api_impl.dart';
import 'package:github_repositories_flutter/domain/api_error.dart';
import 'package:github_repositories_flutter/domain/model/github_project.dart';
import '../../domain/repository/github_repository.dart';

final githubRepositoryProvider = Provider<GithubRepository>((ref) => GithubRepositoryImpl(ref.watch(githubApiProvider)));

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
