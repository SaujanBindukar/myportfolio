import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Projects with _$Projects {
  const factory Projects({
    required String projectName,
    required String projectLink,
    required String projectImage,
  }) = _Projects;
  factory Projects.fromJson(Map<String, dynamic> json) =>
      _$ProjectsFromJson(json);
}
