import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/appwrite_client.dart';
import 'package:myportfolio/feature/projects/entities/project.dart';
import 'package:myportfolio/utils/appwrite_utils.dart';

final projectRepository = Provider<ProjectRepository>((ref) {
  return ProjectRepository(
    ref: ref,
    client: ref.read(appwriteClient),
  );
});

class ProjectRepository {
  Ref ref;
  Client client;
  ProjectRepository({
    required this.ref,
    required this.client,
  });

  Databases get _database => Databases(client);

  Future<List<Projects>> getAllProjects() async {
    final response = _database.listDocuments(
      databaseId: AppwriteUtils.databaseId,
      collectionId: '65170d61d7cb925a6ff7',
    );

    return response.then((value) {
      final data =
          value.documents.map((e) => Projects.fromJson(e.data)).toList();
      return data;
    }).catchError((error) {
      return <Projects>[];
    });
  }
}
