import 'package:github_repositories_flutter/data/api/dio_manager.dart';
import 'package:github_repositories_flutter/data/api/github_api.dart';
import 'package:github_repositories_flutter/data/api/response/fetch_project_response.dart';
import 'package:github_repositories_flutter/data/api/url.dart';
import 'package:github_repositories_flutter/domain/api_error.dart';

class GithubApiImpl implements GithubApi {
  final DioManager _dioManager;
  GithubApiImpl(this._dioManager)

  @override
  Future<List<FetchProjectResponse>> fetchAllProjects(String userName) async {
    final response = await _dioManager.dio.get("$githubApiUrl/users/$userName/repos");

    if (response.statusCode == 200) {
      final dataList = response.data as List<dynamic>;
      final result = dataList.map((e) => FetchProjectResponse.fromJson(e)).toList();
      return result;
    } else {
      throw const ApiError.unknown("");
    }
  }
}