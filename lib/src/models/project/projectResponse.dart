
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'projectResponse.freezed.dart';
part 'projectResponse.g.dart';

ProjectResponse projectResponseFromJson(String str) => ProjectResponse.fromJson(json.decode(str));

String projectResponseToJson(ProjectResponse data) => json.encode(data.toJson());

@freezed
abstract class ProjectResponse with _$ProjectResponse {
    const factory ProjectResponse({
        required List<Project>? data,
    }) = _ProjectResponse;

    factory ProjectResponse.fromJson(Map<String, dynamic> json) => _$ProjectResponseFromJson(json);
}

@freezed
abstract class Project with _$Project {
    const factory Project({
        required int? id,
        required String? name,
        required dynamic description,
        required String? status,
        required DateTime? created_at,
        required DateTime? updated_at,
        required List<TaskGroup>? task_groups,
    }) = _Project;

    factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}

@freezed
abstract class TaskGroup with _$TaskGroup {
    const factory TaskGroup({
        required int? id,
        required int? project_id,
        required String? name,
        required dynamic description,
        required List<Task>? tasks,
    }) = _TaskGroup;

    factory TaskGroup.fromJson(Map<String, dynamic> json) => _$TaskGroupFromJson(json);
}

@freezed
abstract class Task with _$Task {
    const factory Task({
        required int? id,
        required int? task_group_id,
        required String? name,
        required dynamic description,
        required dynamic attachments,
        required DateTime? created_at,
    }) = _Task;

    factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
