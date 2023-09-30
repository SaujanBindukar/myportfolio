import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/appwrite_client.dart';
import 'package:myportfolio/utils/appwrite_utils.dart';

final skillRepository = Provider<SkillsRepository>((ref) {
  return SkillsRepository(
    ref: ref,
    client: ref.read(appwriteClient),
  );
});

class SkillsRepository {
  Ref ref;
  Client client;
  SkillsRepository({
    required this.ref,
    required this.client,
  });

  Databases get _database => Databases(client);
  Future<List<String>> getSkills() async {
    final response = _database.listDocuments(
      databaseId: AppwriteUtils.databaseId,
      collectionId: '651419a1aa4019ad7dc2',
    );
    return response.then((value) {
      final data =
          value.documents.map((e) => e.data['skill_name'].toString()).toList();
      return data;
    }).onError((error, stackTrace) {
      return [];
    });
  }
}
