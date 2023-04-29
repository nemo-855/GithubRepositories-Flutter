import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repositories_flutter/data/api/dio_manager.dart';
import 'package:github_repositories_flutter/data/api/github_api.dart';
import 'package:github_repositories_flutter/data/api/response/fetch_project_response.dart';
import 'package:github_repositories_flutter/data/api/url.dart';
import 'package:github_repositories_flutter/domain/api_error.dart';

final githubApiProvider = Provider<GithubApi>((ref) => _GithubApiImpl(ref.watch(dioManagerProvider)));

const _nemoUserName = "nemo-855";

class _GithubApiImpl implements GithubApi {
  final DioManager _dioManager;
  _GithubApiImpl(this._dioManager);

  @override
  Future<List<FetchProjectResponse>> fetchAllProjects() async {
    final response = await _dioManager.dio.get("$githubApiUrl/users/$_nemoUserName/repos");

    if (response.statusCode == 200) {
      final dataList = response.data as List<dynamic>;
      final result = dataList.map((e) => FetchProjectResponse.fromJson(e)).toList();
      return result;
    } else {
      throw const ApiError.unknown("");
    }
  }
}