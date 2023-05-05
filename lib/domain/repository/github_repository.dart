import '../model/Sponsore.dart';
import '../model/github_project.dart';

abstract class GithubRepository {
  Future<List<GithubProject>> getAllProjects();
  Future<List<Sponsor>> getSponsors();
}
