// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'awardResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AwardResponse _$AwardResponseFromJson(Map<String, dynamic> json) {
  return _AwardResponse.fromJson(json);
}

/// @nodoc
mixin _$AwardResponse {
  List<Award> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AwardResponseCopyWith<AwardResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwardResponseCopyWith<$Res> {
  factory $AwardResponseCopyWith(
          AwardResponse value, $Res Function(AwardResponse) then) =
      _$AwardResponseCopyWithImpl<$Res, AwardResponse>;
  @useResult
  $Res call({List<Award> data});
}

/// @nodoc
class _$AwardResponseCopyWithImpl<$Res, $Val extends AwardResponse>
    implements $AwardResponseCopyWith<$Res> {
  _$AwardResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Award>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AwardResponseImplCopyWith<$Res>
    implements $AwardResponseCopyWith<$Res> {
  factory _$$AwardResponseImplCopyWith(
          _$AwardResponseImpl value, $Res Function(_$AwardResponseImpl) then) =
      __$$AwardResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Award> data});
}

/// @nodoc
class __$$AwardResponseImplCopyWithImpl<$Res>
    extends _$AwardResponseCopyWithImpl<$Res, _$AwardResponseImpl>
    implements _$$AwardResponseImplCopyWith<$Res> {
  __$$AwardResponseImplCopyWithImpl(
      _$AwardResponseImpl _value, $Res Function(_$AwardResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$AwardResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Award>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AwardResponseImpl implements _AwardResponse {
  const _$AwardResponseImpl({required final List<Award> data}) : _data = data;

  factory _$AwardResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwardResponseImplFromJson(json);

  final List<Award> _data;
  @override
  List<Award> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'AwardResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwardResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AwardResponseImplCopyWith<_$AwardResponseImpl> get copyWith =>
      __$$AwardResponseImplCopyWithImpl<_$AwardResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwardResponseImplToJson(
      this,
    );
  }
}

abstract class _AwardResponse implements AwardResponse {
  const factory _AwardResponse({required final List<Award> data}) =
      _$AwardResponseImpl;

  factory _AwardResponse.fromJson(Map<String, dynamic> json) =
      _$AwardResponseImpl.fromJson;

  @override
  List<Award> get data;
  @override
  @JsonKey(ignore: true)
  _$$AwardResponseImplCopyWith<_$AwardResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Award _$AwardFromJson(Map<String, dynamic> json) {
  return _Award.fromJson(json);
}

/// @nodoc
mixin _$Award {
  int? get id => throw _privateConstructorUsedError;
  int? get created_by => throw _privateConstructorUsedError;
  int? get employee_id => throw _privateConstructorUsedError;
  int? get award_category_id => throw _privateConstructorUsedError;
  String? get gift_item => throw _privateConstructorUsedError;
  DateTime? get select_month => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get publication_status => throw _privateConstructorUsedError;
  int? get deletion_status => throw _privateConstructorUsedError;
  dynamic get deleted_at => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AwardCopyWith<Award> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AwardCopyWith<$Res> {
  factory $AwardCopyWith(Award value, $Res Function(Award) then) =
      _$AwardCopyWithImpl<$Res, Award>;
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? employee_id,
      int? award_category_id,
      String? gift_item,
      DateTime? select_month,
      String? description,
      int? publication_status,
      int? deletion_status,
      dynamic deleted_at,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class _$AwardCopyWithImpl<$Res, $Val extends Award>
    implements $AwardCopyWith<$Res> {
  _$AwardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? employee_id = freezed,
    Object? award_category_id = freezed,
    Object? gift_item = freezed,
    Object? select_month = freezed,
    Object? description = freezed,
    Object? publication_status = freezed,
    Object? deletion_status = freezed,
    Object? deleted_at = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as int?,
      employee_id: freezed == employee_id
          ? _value.employee_id
          : employee_id // ignore: cast_nullable_to_non_nullable
              as int?,
      award_category_id: freezed == award_category_id
          ? _value.award_category_id
          : award_category_id // ignore: cast_nullable_to_non_nullable
              as int?,
      gift_item: freezed == gift_item
          ? _value.gift_item
          : gift_item // ignore: cast_nullable_to_non_nullable
              as String?,
      select_month: freezed == select_month
          ? _value.select_month
          : select_month // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      publication_status: freezed == publication_status
          ? _value.publication_status
          : publication_status // ignore: cast_nullable_to_non_nullable
              as int?,
      deletion_status: freezed == deletion_status
          ? _value.deletion_status
          : deletion_status // ignore: cast_nullable_to_non_nullable
              as int?,
      deleted_at: freezed == deleted_at
          ? _value.deleted_at
          : deleted_at // ignore: cast_nullable_to_non_nullable
              as dynamic,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AwardImplCopyWith<$Res> implements $AwardCopyWith<$Res> {
  factory _$$AwardImplCopyWith(
          _$AwardImpl value, $Res Function(_$AwardImpl) then) =
      __$$AwardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? employee_id,
      int? award_category_id,
      String? gift_item,
      DateTime? select_month,
      String? description,
      int? publication_status,
      int? deletion_status,
      dynamic deleted_at,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class __$$AwardImplCopyWithImpl<$Res>
    extends _$AwardCopyWithImpl<$Res, _$AwardImpl>
    implements _$$AwardImplCopyWith<$Res> {
  __$$AwardImplCopyWithImpl(
      _$AwardImpl _value, $Res Function(_$AwardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? employee_id = freezed,
    Object? award_category_id = freezed,
    Object? gift_item = freezed,
    Object? select_month = freezed,
    Object? description = freezed,
    Object? publication_status = freezed,
    Object? deletion_status = freezed,
    Object? deleted_at = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$AwardImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as int?,
      employee_id: freezed == employee_id
          ? _value.employee_id
          : employee_id // ignore: cast_nullable_to_non_nullable
              as int?,
      award_category_id: freezed == award_category_id
          ? _value.award_category_id
          : award_category_id // ignore: cast_nullable_to_non_nullable
              as int?,
      gift_item: freezed == gift_item
          ? _value.gift_item
          : gift_item // ignore: cast_nullable_to_non_nullable
              as String?,
      select_month: freezed == select_month
          ? _value.select_month
          : select_month // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      publication_status: freezed == publication_status
          ? _value.publication_status
          : publication_status // ignore: cast_nullable_to_non_nullable
              as int?,
      deletion_status: freezed == deletion_status
          ? _value.deletion_status
          : deletion_status // ignore: cast_nullable_to_non_nullable
              as int?,
      deleted_at: freezed == deleted_at
          ? _value.deleted_at
          : deleted_at // ignore: cast_nullable_to_non_nullable
              as dynamic,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AwardImpl implements _Award {
  const _$AwardImpl(
      {required this.id,
      required this.created_by,
      required this.employee_id,
      required this.award_category_id,
      required this.gift_item,
      required this.select_month,
      required this.description,
      required this.publication_status,
      required this.deletion_status,
      required this.deleted_at,
      required this.created_at,
      required this.updated_at});

  factory _$AwardImpl.fromJson(Map<String, dynamic> json) =>
      _$$AwardImplFromJson(json);

  @override
  final int? id;
  @override
  final int? created_by;
  @override
  final int? employee_id;
  @override
  final int? award_category_id;
  @override
  final String? gift_item;
  @override
  final DateTime? select_month;
  @override
  final String? description;
  @override
  final int? publication_status;
  @override
  final int? deletion_status;
  @override
  final dynamic deleted_at;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;

  @override
  String toString() {
    return 'Award(id: $id, created_by: $created_by, employee_id: $employee_id, award_category_id: $award_category_id, gift_item: $gift_item, select_month: $select_month, description: $description, publication_status: $publication_status, deletion_status: $deletion_status, deleted_at: $deleted_at, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AwardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.employee_id, employee_id) ||
                other.employee_id == employee_id) &&
            (identical(other.award_category_id, award_category_id) ||
                other.award_category_id == award_category_id) &&
            (identical(other.gift_item, gift_item) ||
                other.gift_item == gift_item) &&
            (identical(other.select_month, select_month) ||
                other.select_month == select_month) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publication_status, publication_status) ||
                other.publication_status == publication_status) &&
            (identical(other.deletion_status, deletion_status) ||
                other.deletion_status == deletion_status) &&
            const DeepCollectionEquality()
                .equals(other.deleted_at, deleted_at) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      created_by,
      employee_id,
      award_category_id,
      gift_item,
      select_month,
      description,
      publication_status,
      deletion_status,
      const DeepCollectionEquality().hash(deleted_at),
      created_at,
      updated_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AwardImplCopyWith<_$AwardImpl> get copyWith =>
      __$$AwardImplCopyWithImpl<_$AwardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AwardImplToJson(
      this,
    );
  }
}

abstract class _Award implements Award {
  const factory _Award(
      {required final int? id,
      required final int? created_by,
      required final int? employee_id,
      required final int? award_category_id,
      required final String? gift_item,
      required final DateTime? select_month,
      required final String? description,
      required final int? publication_status,
      required final int? deletion_status,
      required final dynamic deleted_at,
      required final DateTime? created_at,
      required final DateTime? updated_at}) = _$AwardImpl;

  factory _Award.fromJson(Map<String, dynamic> json) = _$AwardImpl.fromJson;

  @override
  int? get id;
  @override
  int? get created_by;
  @override
  int? get employee_id;
  @override
  int? get award_category_id;
  @override
  String? get gift_item;
  @override
  DateTime? get select_month;
  @override
  String? get description;
  @override
  int? get publication_status;
  @override
  int? get deletion_status;
  @override
  dynamic get deleted_at;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;
  @override
  @JsonKey(ignore: true)
  _$$AwardImplCopyWith<_$AwardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
