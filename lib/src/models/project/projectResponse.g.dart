// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projectResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectResponseImpl _$$ProjectResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectResponseImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProjectResponseImplToJson(
        _$ProjectResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'],
      status: json['status'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      task_groups: (json['task_groups'] as List<dynamic>?)
          ?.map((e) => TaskGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'task_groups': instance.task_groups,
    };

_$TaskGroupImpl _$$TaskGroupImplFromJson(Map<String, dynamic> json) =>
    _$TaskGroupImpl(
      id: (json['id'] as num?)?.toInt(),
      project_id: (json['project_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'],
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TaskGroupImplToJson(_$TaskGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.project_id,
      'name': instance.name,
      'description': instance.description,
      'tasks': instance.tasks,
    };

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: (json['id'] as num?)?.toInt(),
      task_group_id: (json['task_group_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'],
      attachments: json['attachments'],
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_group_id': instance.task_group_id,
      'name': instance.name,
      'description': instance.description,
      'attachments': instance.attachments,
      'created_at': instance.created_at?.toIso8601String(),
    };
