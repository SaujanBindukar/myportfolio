import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/feature/skills/repository/skills_repository.dart';

final skillController = FutureProvider<List<String>>((ref) async {
  final data = await SkillController(ref).getSkills();
  return data;
});

class SkillController extends StateNotifier<List<String>> {
  SkillController(this.ref) : super([]);

  final Ref ref;

  Future<List<String>> getSkills() async {
    final response = await ref.read(skillRepository).getSkills();
    return response;
  }
}
