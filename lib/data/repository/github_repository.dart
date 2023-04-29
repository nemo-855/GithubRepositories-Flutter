import '../../domain/model/github_project.dart';

abstract class GithubRepository {
  Future<List<GithubProject>> getAllProjects(String userName);
}
