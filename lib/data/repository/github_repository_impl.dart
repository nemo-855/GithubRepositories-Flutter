import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/data/api/github_api.dart';
import 'package:github_repositories_flutter/data/api/github_api_impl.dart';
import 'package:github_repositories_flutter/data/api/response/fetch_project_response.dart';
import 'package:github_repositories_flutter/domain/api_error.dart';
import 'package:github_repositories_flutter/domain/model/Sponsore.dart';
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

  @override
  Future<List<Sponsor>> getSponsors() async {
    return List<Sponsor>.filled(
      4,
      const Sponsor(
        name: "HunterHunter",
        imageUrl: "https://img.happyon.jp/d3urerHm/uploads/migration/50016449_series_art__338x600_hunter_x_hunter_37398da5be0e65b71700f49dbdb6d49a.jpg?size=600x338",
      )
    );
  }
}
