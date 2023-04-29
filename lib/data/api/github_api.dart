import 'package:github_repositories_flutter/data/api/response/fetch_project_response.dart';

abstract class GithubApi {
  Future<List<FetchProjectResponse>> fetchAllProjects(String userName);
}