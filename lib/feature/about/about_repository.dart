import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/appwrite_client.dart';
import 'package:myportfolio/utils/appwrite_utils.dart';

final aboutRepository = Provider<AboutRepository>((ref) {
  return AboutRepository(
    ref: ref,
    client: ref.read(appwriteClient),
  );
});

class AboutRepository {
  Ref ref;
  Client client;
  AboutRepository({
    required this.ref,
    required this.client,
  });

  Databases get _database => Databases(client);

  Future<String> getAbout() async {
    final response = _database.listDocuments(
      databaseId: AppwriteUtils.databaseId,
      collectionId: '65141974ae4bcfc71441',
    );
    return response.then((value) {
      final documents = value.documents.first.data['intro'] as String;
      return documents;
    }).catchError((error) {
      return error;
    });
  }
}
