// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Leave _$LeaveFromJson(Map<String, dynamic> json) {
  return _Leave.fromJson(json);
}

/// @nodoc
mixin _$Leave {
  int? get id => throw _privateConstructorUsedError;
  int? get created_by => throw _privateConstructorUsedError;
  int? get leave_category_id => throw _privateConstructorUsedError;
  String? get last_leave_category_id => throw _privateConstructorUsedError;
  String? get last_leave_period => throw _privateConstructorUsedError;
  DateTime? get start_date => throw _privateConstructorUsedError;
  DateTime? get end_date => throw _privateConstructorUsedError;
  String? get leave_address => throw _privateConstructorUsedError;
  DateTime? get last_leave_date => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get during_leave => throw _privateConstructorUsedError;
  int? get publication_status => throw _privateConstructorUsedError;
  int? get deletion_status => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveCopyWith<Leave> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveCopyWith<$Res> {
  factory $LeaveCopyWith(Leave value, $Res Function(Leave) then) =
      _$LeaveCopyWithImpl<$Res, Leave>;
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? leave_category_id,
      String? last_leave_category_id,
      String? last_leave_period,
      DateTime? start_date,
      DateTime? end_date,
      String? leave_address,
      DateTime? last_leave_date,
      String? reason,
      String? during_leave,
      int? publication_status,
      int? deletion_status,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class _$LeaveCopyWithImpl<$Res, $Val extends Leave>
    implements $LeaveCopyWith<$Res> {
  _$LeaveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? leave_category_id = freezed,
    Object? last_leave_category_id = freezed,
    Object? last_leave_period = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? leave_address = freezed,
    Object? last_leave_date = freezed,
    Object? reason = freezed,
    Object? during_leave = freezed,
    Object? publication_status = freezed,
    Object? deletion_status = freezed,
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
      leave_category_id: freezed == leave_category_id
          ? _value.leave_category_id
          : leave_category_id // ignore: cast_nullable_to_non_nullable
              as int?,
      last_leave_category_id: freezed == last_leave_category_id
          ? _value.last_leave_category_id
          : last_leave_category_id // ignore: cast_nullable_to_non_nullable
              as String?,
      last_leave_period: freezed == last_leave_period
          ? _value.last_leave_period
          : last_leave_period // ignore: cast_nullable_to_non_nullable
              as String?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leave_address: freezed == leave_address
          ? _value.leave_address
          : leave_address // ignore: cast_nullable_to_non_nullable
              as String?,
      last_leave_date: freezed == last_leave_date
          ? _value.last_leave_date
          : last_leave_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      during_leave: freezed == during_leave
          ? _value.during_leave
          : during_leave // ignore: cast_nullable_to_non_nullable
              as String?,
      publication_status: freezed == publication_status
          ? _value.publication_status
          : publication_status // ignore: cast_nullable_to_non_nullable
              as int?,
      deletion_status: freezed == deletion_status
          ? _value.deletion_status
          : deletion_status // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$LeaveImplCopyWith<$Res> implements $LeaveCopyWith<$Res> {
  factory _$$LeaveImplCopyWith(
          _$LeaveImpl value, $Res Function(_$LeaveImpl) then) =
      __$$LeaveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? leave_category_id,
      String? last_leave_category_id,
      String? last_leave_period,
      DateTime? start_date,
      DateTime? end_date,
      String? leave_address,
      DateTime? last_leave_date,
      String? reason,
      String? during_leave,
      int? publication_status,
      int? deletion_status,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class __$$LeaveImplCopyWithImpl<$Res>
    extends _$LeaveCopyWithImpl<$Res, _$LeaveImpl>
    implements _$$LeaveImplCopyWith<$Res> {
  __$$LeaveImplCopyWithImpl(
      _$LeaveImpl _value, $Res Function(_$LeaveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? leave_category_id = freezed,
    Object? last_leave_category_id = freezed,
    Object? last_leave_period = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? leave_address = freezed,
    Object? last_leave_date = freezed,
    Object? reason = freezed,
    Object? during_leave = freezed,
    Object? publication_status = freezed,
    Object? deletion_status = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$LeaveImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as int?,
      leave_category_id: freezed == leave_category_id
          ? _value.leave_category_id
          : leave_category_id // ignore: cast_nullable_to_non_nullable
              as int?,
      last_leave_category_id: freezed == last_leave_category_id
          ? _value.last_leave_category_id
          : last_leave_category_id // ignore: cast_nullable_to_non_nullable
              as String?,
      last_leave_period: freezed == last_leave_period
          ? _value.last_leave_period
          : last_leave_period // ignore: cast_nullable_to_non_nullable
              as String?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leave_address: freezed == leave_address
          ? _value.leave_address
          : leave_address // ignore: cast_nullable_to_non_nullable
              as String?,
      last_leave_date: freezed == last_leave_date
          ? _value.last_leave_date
          : last_leave_date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      during_leave: freezed == during_leave
          ? _value.during_leave
          : during_leave // ignore: cast_nullable_to_non_nullable
              as String?,
      publication_status: freezed == publication_status
          ? _value.publication_status
          : publication_status // ignore: cast_nullable_to_non_nullable
              as int?,
      deletion_status: freezed == deletion_status
          ? _value.deletion_status
          : deletion_status // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$LeaveImpl implements _Leave {
  const _$LeaveImpl(
      {required this.id,
      required this.created_by,
      required this.leave_category_id,
      required this.last_leave_category_id,
      required this.last_leave_period,
      required this.start_date,
      required this.end_date,
      required this.leave_address,
      required this.last_leave_date,
      required this.reason,
      required this.during_leave,
      required this.publication_status,
      required this.deletion_status,
      required this.created_at,
      required this.updated_at});

  factory _$LeaveImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveImplFromJson(json);

  @override
  final int? id;
  @override
  final int? created_by;
  @override
  final int? leave_category_id;
  @override
  final String? last_leave_category_id;
  @override
  final String? last_leave_period;
  @override
  final DateTime? start_date;
  @override
  final DateTime? end_date;
  @override
  final String? leave_address;
  @override
  final DateTime? last_leave_date;
  @override
  final String? reason;
  @override
  final String? during_leave;
  @override
  final int? publication_status;
  @override
  final int? deletion_status;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;

  @override
  String toString() {
    return 'Leave(id: $id, created_by: $created_by, leave_category_id: $leave_category_id, last_leave_category_id: $last_leave_category_id, last_leave_period: $last_leave_period, start_date: $start_date, end_date: $end_date, leave_address: $leave_address, last_leave_date: $last_leave_date, reason: $reason, during_leave: $during_leave, publication_status: $publication_status, deletion_status: $deletion_status, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.leave_category_id, leave_category_id) ||
                other.leave_category_id == leave_category_id) &&
            (identical(other.last_leave_category_id, last_leave_category_id) ||
                other.last_leave_category_id == last_leave_category_id) &&
            (identical(other.last_leave_period, last_leave_period) ||
                other.last_leave_period == last_leave_period) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.end_date, end_date) ||
                other.end_date == end_date) &&
            (identical(other.leave_address, leave_address) ||
                other.leave_address == leave_address) &&
            (identical(other.last_leave_date, last_leave_date) ||
                other.last_leave_date == last_leave_date) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.during_leave, during_leave) ||
                other.during_leave == during_leave) &&
            (identical(other.publication_status, publication_status) ||
                other.publication_status == publication_status) &&
            (identical(other.deletion_status, deletion_status) ||
                other.deletion_status == deletion_status) &&
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
      leave_category_id,
      last_leave_category_id,
      last_leave_period,
      start_date,
      end_date,
      leave_address,
      last_leave_date,
      reason,
      during_leave,
      publication_status,
      deletion_status,
      created_at,
      updated_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveImplCopyWith<_$LeaveImpl> get copyWith =>
      __$$LeaveImplCopyWithImpl<_$LeaveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveImplToJson(
      this,
    );
  }
}

abstract class _Leave implements Leave {
  const factory _Leave(
      {required final int? id,
      required final int? created_by,
      required final int? leave_category_id,
      required final String? last_leave_category_id,
      required final String? last_leave_period,
      required final DateTime? start_date,
      required final DateTime? end_date,
      required final String? leave_address,
      required final DateTime? last_leave_date,
      required final String? reason,
      required final String? during_leave,
      required final int? publication_status,
      required final int? deletion_status,
      required final DateTime? created_at,
      required final DateTime? updated_at}) = _$LeaveImpl;

  factory _Leave.fromJson(Map<String, dynamic> json) = _$LeaveImpl.fromJson;

  @override
  int? get id;
  @override
  int? get created_by;
  @override
  int? get leave_category_id;
  @override
  String? get last_leave_category_id;
  @override
  String? get last_leave_period;
  @override
  DateTime? get start_date;
  @override
  DateTime? get end_date;
  @override
  String? get leave_address;
  @override
  DateTime? get last_leave_date;
  @override
  String? get reason;
  @override
  String? get during_leave;
  @override
  int? get publication_status;
  @override
  int? get deletion_status;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;
  @override
  @JsonKey(ignore: true)
  _$$LeaveImplCopyWith<_$LeaveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
