import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/feature/projects/entities/project.dart';
import 'package:myportfolio/feature/projects/repository/project_repository.dart';

final projectController = FutureProvider<List<Projects>>((ref) async {
  final data = await ProjectController(ref).getAllProjects();
  return data;
});

class ProjectController extends StateNotifier<Projects?> {
  ProjectController(this.ref) : super(null);

  final Ref ref;

  Future<List<Projects>> getAllProjects() async {
    final response = await ref.read(projectRepository).getAllProjects();
    return response;
  }
}
