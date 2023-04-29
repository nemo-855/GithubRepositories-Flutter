import 'package:github_repositories_flutter/domain/model/owner.dart';

class GithubProject {
  final int id;
  final String name;
  final bool isPrivate;
  final Owner owner;
  final String htmlUrl;
  final DateTime createdAt;

  const GithubProject(
      {required this.id,
      required this.name,
      required this.isPrivate,
      required this.owner,
      required this.htmlUrl,
      required this.createdAt});
}
