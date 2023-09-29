import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/utils/appwrite_utils.dart';

final appwriteClient = Provider<Client>((ref) {
  return Client(
    endPoint: AppwriteUtils.endpoint,
    selfSigned: true,
  )
    ..setProject(
      AppwriteUtils.projectId,
    )
    ..setSelfSigned();
});
