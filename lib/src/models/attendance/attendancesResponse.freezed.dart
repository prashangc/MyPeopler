// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendancesResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendancesResponse _$AttendancesResponseFromJson(Map<String, dynamic> json) {
  return _AttendancesResponse.fromJson(json);
}

/// @nodoc
mixin _$AttendancesResponse {
  List<Attendance> get attendances => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendancesResponseCopyWith<AttendancesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendancesResponseCopyWith<$Res> {
  factory $AttendancesResponseCopyWith(
          AttendancesResponse value, $Res Function(AttendancesResponse) then) =
      _$AttendancesResponseCopyWithImpl<$Res, AttendancesResponse>;
  @useResult
  $Res call({List<Attendance> attendances});
}

/// @nodoc
class _$AttendancesResponseCopyWithImpl<$Res, $Val extends AttendancesResponse>
    implements $AttendancesResponseCopyWith<$Res> {
  _$AttendancesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendances = null,
  }) {
    return _then(_value.copyWith(
      attendances: null == attendances
          ? _value.attendances
          : attendances // ignore: cast_nullable_to_non_nullable
              as List<Attendance>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendancesResponseImplCopyWith<$Res>
    implements $AttendancesResponseCopyWith<$Res> {
  factory _$$AttendancesResponseImplCopyWith(_$AttendancesResponseImpl value,
          $Res Function(_$AttendancesResponseImpl) then) =
      __$$AttendancesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Attendance> attendances});
}

/// @nodoc
class __$$AttendancesResponseImplCopyWithImpl<$Res>
    extends _$AttendancesResponseCopyWithImpl<$Res, _$AttendancesResponseImpl>
    implements _$$AttendancesResponseImplCopyWith<$Res> {
  __$$AttendancesResponseImplCopyWithImpl(_$AttendancesResponseImpl _value,
      $Res Function(_$AttendancesResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendances = null,
  }) {
    return _then(_$AttendancesResponseImpl(
      attendances: null == attendances
          ? _value._attendances
          : attendances // ignore: cast_nullable_to_non_nullable
              as List<Attendance>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendancesResponseImpl implements _AttendancesResponse {
  const _$AttendancesResponseImpl({required final List<Attendance> attendances})
      : _attendances = attendances;

  factory _$AttendancesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendancesResponseImplFromJson(json);

  final List<Attendance> _attendances;
  @override
  List<Attendance> get attendances {
    if (_attendances is EqualUnmodifiableListView) return _attendances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attendances);
  }

  @override
  String toString() {
    return 'AttendancesResponse(attendances: $attendances)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancesResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._attendances, _attendances));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attendances));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendancesResponseImplCopyWith<_$AttendancesResponseImpl> get copyWith =>
      __$$AttendancesResponseImplCopyWithImpl<_$AttendancesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendancesResponseImplToJson(
      this,
    );
  }
}

abstract class _AttendancesResponse implements AttendancesResponse {
  const factory _AttendancesResponse(
          {required final List<Attendance> attendances}) =
      _$AttendancesResponseImpl;

  factory _AttendancesResponse.fromJson(Map<String, dynamic> json) =
      _$AttendancesResponseImpl.fromJson;

  @override
  List<Attendance> get attendances;
  @override
  @JsonKey(ignore: true)
  _$$AttendancesResponseImplCopyWith<_$AttendancesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Attendance _$AttendanceFromJson(Map<String, dynamic> json) {
  return _Attendance.fromJson(json);
}

/// @nodoc
mixin _$Attendance {
  int? get id =>
      throw _privateConstructorUsedError; // required dynamic created_by,
// required int? user_id,
  NepaliDateTime? get attendance_date =>
      throw _privateConstructorUsedError; // required int? attendance_status,
// required int? employee_shift_id,
// required DateTime? created_at,
// required DateTime? updated_at,
  String? get shift_name => throw _privateConstructorUsedError;
  List<AttendanceDetail> get details => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceCopyWith<Attendance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceCopyWith<$Res> {
  factory $AttendanceCopyWith(
          Attendance value, $Res Function(Attendance) then) =
      _$AttendanceCopyWithImpl<$Res, Attendance>;
  @useResult
  $Res call(
      {int? id,
      NepaliDateTime? attendance_date,
      String? shift_name,
      List<AttendanceDetail> details});
}

/// @nodoc
class _$AttendanceCopyWithImpl<$Res, $Val extends Attendance>
    implements $AttendanceCopyWith<$Res> {
  _$AttendanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attendance_date = freezed,
    Object? shift_name = freezed,
    Object? details = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      attendance_date: freezed == attendance_date
          ? _value.attendance_date
          : attendance_date // ignore: cast_nullable_to_non_nullable
              as NepaliDateTime?,
      shift_name: freezed == shift_name
          ? _value.shift_name
          : shift_name // ignore: cast_nullable_to_non_nullable
              as String?,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<AttendanceDetail>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceImplCopyWith<$Res>
    implements $AttendanceCopyWith<$Res> {
  factory _$$AttendanceImplCopyWith(
          _$AttendanceImpl value, $Res Function(_$AttendanceImpl) then) =
      __$$AttendanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      NepaliDateTime? attendance_date,
      String? shift_name,
      List<AttendanceDetail> details});
}

/// @nodoc
class __$$AttendanceImplCopyWithImpl<$Res>
    extends _$AttendanceCopyWithImpl<$Res, _$AttendanceImpl>
    implements _$$AttendanceImplCopyWith<$Res> {
  __$$AttendanceImplCopyWithImpl(
      _$AttendanceImpl _value, $Res Function(_$AttendanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attendance_date = freezed,
    Object? shift_name = freezed,
    Object? details = null,
  }) {
    return _then(_$AttendanceImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      attendance_date: freezed == attendance_date
          ? _value.attendance_date
          : attendance_date // ignore: cast_nullable_to_non_nullable
              as NepaliDateTime?,
      shift_name: freezed == shift_name
          ? _value.shift_name
          : shift_name // ignore: cast_nullable_to_non_nullable
              as String?,
      details: null == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<AttendanceDetail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceImpl implements _Attendance {
  const _$AttendanceImpl(
      {required this.id,
      required this.attendance_date,
      required this.shift_name,
      required final List<AttendanceDetail> details})
      : _details = details;

  factory _$AttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceImplFromJson(json);

  @override
  final int? id;
// required dynamic created_by,
// required int? user_id,
  @override
  final NepaliDateTime? attendance_date;
// required int? attendance_status,
// required int? employee_shift_id,
// required DateTime? created_at,
// required DateTime? updated_at,
  @override
  final String? shift_name;
  final List<AttendanceDetail> _details;
  @override
  List<AttendanceDetail> get details {
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_details);
  }

  @override
  String toString() {
    return 'Attendance(id: $id, attendance_date: $attendance_date, shift_name: $shift_name, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attendance_date, attendance_date) ||
                other.attendance_date == attendance_date) &&
            (identical(other.shift_name, shift_name) ||
                other.shift_name == shift_name) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, attendance_date, shift_name,
      const DeepCollectionEquality().hash(_details));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceImplCopyWith<_$AttendanceImpl> get copyWith =>
      __$$AttendanceImplCopyWithImpl<_$AttendanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceImplToJson(
      this,
    );
  }
}

abstract class _Attendance implements Attendance {
  const factory _Attendance(
      {required final int? id,
      required final NepaliDateTime? attendance_date,
      required final String? shift_name,
      required final List<AttendanceDetail> details}) = _$AttendanceImpl;

  factory _Attendance.fromJson(Map<String, dynamic> json) =
      _$AttendanceImpl.fromJson;

  @override
  int? get id;
  @override // required dynamic created_by,
// required int? user_id,
  NepaliDateTime? get attendance_date;
  @override // required int? attendance_status,
// required int? employee_shift_id,
// required DateTime? created_at,
// required DateTime? updated_at,
  String? get shift_name;
  @override
  List<AttendanceDetail> get details;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceImplCopyWith<_$AttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttendanceDetail _$AttendanceDetailFromJson(Map<String, dynamic> json) {
  return _AttendanceDetail.fromJson(json);
}

/// @nodoc
mixin _$AttendanceDetail {
  int? get id => throw _privateConstructorUsedError;
  int? get attendance_id => throw _privateConstructorUsedError;
  NepaliDateTime? get attendance_date =>
      throw _privateConstructorUsedError; // required dynamic device_id,
  int? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttendanceDetailCopyWith<AttendanceDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceDetailCopyWith<$Res> {
  factory $AttendanceDetailCopyWith(
          AttendanceDetail value, $Res Function(AttendanceDetail) then) =
      _$AttendanceDetailCopyWithImpl<$Res, AttendanceDetail>;
  @useResult
  $Res call(
      {int? id, int? attendance_id, NepaliDateTime? attendance_date, int? state});
}

/// @nodoc
class _$AttendanceDetailCopyWithImpl<$Res, $Val extends AttendanceDetail>
    implements $AttendanceDetailCopyWith<$Res> {
  _$AttendanceDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attendance_id = freezed,
    Object? attendance_date = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      attendance_id: freezed == attendance_id
          ? _value.attendance_id
          : attendance_id // ignore: cast_nullable_to_non_nullable
              as int?,
      attendance_date: freezed == attendance_date
          ? _value.attendance_date
          : attendance_date // ignore: cast_nullable_to_non_nullable
              as NepaliDateTime?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceDetailImplCopyWith<$Res>
    implements $AttendanceDetailCopyWith<$Res> {
  factory _$$AttendanceDetailImplCopyWith(_$AttendanceDetailImpl value,
          $Res Function(_$AttendanceDetailImpl) then) =
      __$$AttendanceDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, int? attendance_id, DateTime? attendance_date, int? state});
}

/// @nodoc
class __$$AttendanceDetailImplCopyWithImpl<$Res>
    extends _$AttendanceDetailCopyWithImpl<$Res, _$AttendanceDetailImpl>
    implements _$$AttendanceDetailImplCopyWith<$Res> {
  __$$AttendanceDetailImplCopyWithImpl(_$AttendanceDetailImpl _value,
      $Res Function(_$AttendanceDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? attendance_id = freezed,
    Object? attendance_date = freezed,
    Object? state = freezed,
  }) {
    return _then(_$AttendanceDetailImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      attendance_id: freezed == attendance_id
          ? _value.attendance_id
          : attendance_id // ignore: cast_nullable_to_non_nullable
              as int?,
      attendance_date: freezed == attendance_date
          ? _value.attendance_date
          : attendance_date // ignore: cast_nullable_to_non_nullable
              as NepaliDateTime?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceDetailImpl implements _AttendanceDetail {
  const _$AttendanceDetailImpl(
      {required this.id,
      required this.attendance_id,
      required this.attendance_date,
      required this.state});

  factory _$AttendanceDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceDetailImplFromJson(json);

  @override
  final int? id;
  @override
  final int? attendance_id;
  @override
  final NepaliDateTime? attendance_date;
// required dynamic device_id,
  @override
  final int? state;

  @override
  String toString() {
    return 'AttendanceDetail(id: $id, attendance_id: $attendance_id, attendance_date: $attendance_date, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attendance_id, attendance_id) ||
                other.attendance_id == attendance_id) &&
            (identical(other.attendance_date, attendance_date) ||
                other.attendance_date == attendance_date) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, attendance_id, attendance_date, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceDetailImplCopyWith<_$AttendanceDetailImpl> get copyWith =>
      __$$AttendanceDetailImplCopyWithImpl<_$AttendanceDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceDetailImplToJson(
      this,
    );
  }
}

abstract class _AttendanceDetail implements AttendanceDetail {
  const factory _AttendanceDetail(
      {required final int? id,
      required final int? attendance_id,
      required final NepaliDateTime? attendance_date,
      required final int? state}) = _$AttendanceDetailImpl;

  factory _AttendanceDetail.fromJson(Map<String, dynamic> json) =
      _$AttendanceDetailImpl.fromJson;

  @override
  int? get id;
  @override
  int? get attendance_id;
  @override
  NepaliDateTime? get attendance_date;
  @override // required dynamic device_id,
  int? get state;
  @override
  @JsonKey(ignore: true)
  _$$AttendanceDetailImplCopyWith<_$AttendanceDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
