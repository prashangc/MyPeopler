// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payrollResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollResponse _$PayrollResponseFromJson(Map<String, dynamic> json) {
  return _PayrollResponse.fromJson(json);
}

/// @nodoc
mixin _$PayrollResponse {
  PayrollData? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollResponseCopyWith<PayrollResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollResponseCopyWith<$Res> {
  factory $PayrollResponseCopyWith(
          PayrollResponse value, $Res Function(PayrollResponse) then) =
      _$PayrollResponseCopyWithImpl<$Res, PayrollResponse>;
  @useResult
  $Res call({PayrollData? data});

  $PayrollDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$PayrollResponseCopyWithImpl<$Res, $Val extends PayrollResponse>
    implements $PayrollResponseCopyWith<$Res> {
  _$PayrollResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PayrollData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PayrollDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $PayrollDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PayrollResponseImplCopyWith<$Res>
    implements $PayrollResponseCopyWith<$Res> {
  factory _$$PayrollResponseImplCopyWith(_$PayrollResponseImpl value,
          $Res Function(_$PayrollResponseImpl) then) =
      __$$PayrollResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PayrollData? data});

  @override
  $PayrollDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$PayrollResponseImplCopyWithImpl<$Res>
    extends _$PayrollResponseCopyWithImpl<$Res, _$PayrollResponseImpl>
    implements _$$PayrollResponseImplCopyWith<$Res> {
  __$$PayrollResponseImplCopyWithImpl(
      _$PayrollResponseImpl _value, $Res Function(_$PayrollResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$PayrollResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PayrollData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollResponseImpl implements _PayrollResponse {
  const _$PayrollResponseImpl({required this.data});

  factory _$PayrollResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollResponseImplFromJson(json);

  @override
  final PayrollData? data;

  @override
  String toString() {
    return 'PayrollResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollResponseImplCopyWith<_$PayrollResponseImpl> get copyWith =>
      __$$PayrollResponseImplCopyWithImpl<_$PayrollResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollResponseImplToJson(
      this,
    );
  }
}

abstract class _PayrollResponse implements PayrollResponse {
  const factory _PayrollResponse({required final PayrollData? data}) =
      _$PayrollResponseImpl;

  factory _PayrollResponse.fromJson(Map<String, dynamic> json) =
      _$PayrollResponseImpl.fromJson;

  @override
  PayrollData? get data;
  @override
  @JsonKey(ignore: true)
  _$$PayrollResponseImplCopyWith<_$PayrollResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayrollData _$PayrollDataFromJson(Map<String, dynamic> json) {
  return _PayrollData.fromJson(json);
}

/// @nodoc
mixin _$PayrollData {
  Payroll? get payroll => throw _privateConstructorUsedError;
  Bonus? get bonus => throw _privateConstructorUsedError;
  Grade? get grade => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollDataCopyWith<PayrollData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollDataCopyWith<$Res> {
  factory $PayrollDataCopyWith(
          PayrollData value, $Res Function(PayrollData) then) =
      _$PayrollDataCopyWithImpl<$Res, PayrollData>;
  @useResult
  $Res call({Payroll? payroll, Bonus? bonus, Grade? grade});

  $PayrollCopyWith<$Res>? get payroll;
  $BonusCopyWith<$Res>? get bonus;
  $GradeCopyWith<$Res>? get grade;
}

/// @nodoc
class _$PayrollDataCopyWithImpl<$Res, $Val extends PayrollData>
    implements $PayrollDataCopyWith<$Res> {
  _$PayrollDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payroll = freezed,
    Object? bonus = freezed,
    Object? grade = freezed,
  }) {
    return _then(_value.copyWith(
      payroll: freezed == payroll
          ? _value.payroll
          : payroll // ignore: cast_nullable_to_non_nullable
              as Payroll?,
      bonus: freezed == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as Bonus?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as Grade?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PayrollCopyWith<$Res>? get payroll {
    if (_value.payroll == null) {
      return null;
    }

    return $PayrollCopyWith<$Res>(_value.payroll!, (value) {
      return _then(_value.copyWith(payroll: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BonusCopyWith<$Res>? get bonus {
    if (_value.bonus == null) {
      return null;
    }

    return $BonusCopyWith<$Res>(_value.bonus!, (value) {
      return _then(_value.copyWith(bonus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GradeCopyWith<$Res>? get grade {
    if (_value.grade == null) {
      return null;
    }

    return $GradeCopyWith<$Res>(_value.grade!, (value) {
      return _then(_value.copyWith(grade: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PayrollDataImplCopyWith<$Res>
    implements $PayrollDataCopyWith<$Res> {
  factory _$$PayrollDataImplCopyWith(
          _$PayrollDataImpl value, $Res Function(_$PayrollDataImpl) then) =
      __$$PayrollDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Payroll? payroll, Bonus? bonus, Grade? grade});

  @override
  $PayrollCopyWith<$Res>? get payroll;
  @override
  $BonusCopyWith<$Res>? get bonus;
  @override
  $GradeCopyWith<$Res>? get grade;
}

/// @nodoc
class __$$PayrollDataImplCopyWithImpl<$Res>
    extends _$PayrollDataCopyWithImpl<$Res, _$PayrollDataImpl>
    implements _$$PayrollDataImplCopyWith<$Res> {
  __$$PayrollDataImplCopyWithImpl(
      _$PayrollDataImpl _value, $Res Function(_$PayrollDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payroll = freezed,
    Object? bonus = freezed,
    Object? grade = freezed,
  }) {
    return _then(_$PayrollDataImpl(
      payroll: freezed == payroll
          ? _value.payroll
          : payroll // ignore: cast_nullable_to_non_nullable
              as Payroll?,
      bonus: freezed == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as Bonus?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as Grade?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollDataImpl implements _PayrollData {
  const _$PayrollDataImpl(
      {required this.payroll, required this.bonus, required this.grade});

  factory _$PayrollDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollDataImplFromJson(json);

  @override
  final Payroll? payroll;
  @override
  final Bonus? bonus;
  @override
  final Grade? grade;

  @override
  String toString() {
    return 'PayrollData(payroll: $payroll, bonus: $bonus, grade: $grade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollDataImpl &&
            (identical(other.payroll, payroll) || other.payroll == payroll) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.grade, grade) || other.grade == grade));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, payroll, bonus, grade);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollDataImplCopyWith<_$PayrollDataImpl> get copyWith =>
      __$$PayrollDataImplCopyWithImpl<_$PayrollDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollDataImplToJson(
      this,
    );
  }
}

abstract class _PayrollData implements PayrollData {
  const factory _PayrollData(
      {required final Payroll? payroll,
      required final Bonus? bonus,
      required final Grade? grade}) = _$PayrollDataImpl;

  factory _PayrollData.fromJson(Map<String, dynamic> json) =
      _$PayrollDataImpl.fromJson;

  @override
  Payroll? get payroll;
  @override
  Bonus? get bonus;
  @override
  Grade? get grade;
  @override
  @JsonKey(ignore: true)
  _$$PayrollDataImplCopyWith<_$PayrollDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bonus _$BonusFromJson(Map<String, dynamic> json) {
  return _Bonus.fromJson(json);
}

/// @nodoc
mixin _$Bonus {
  int? get id => throw _privateConstructorUsedError;
  int? get created_by => throw _privateConstructorUsedError;
  int? get user_id => throw _privateConstructorUsedError;
  String? get bonus_name => throw _privateConstructorUsedError;
  DateTime? get bonus_month => throw _privateConstructorUsedError;
  String? get bonus_amount => throw _privateConstructorUsedError;
  String? get bonus_description => throw _privateConstructorUsedError;
  int? get deletion_status => throw _privateConstructorUsedError;
  dynamic get deleted_at => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BonusCopyWith<Bonus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonusCopyWith<$Res> {
  factory $BonusCopyWith(Bonus value, $Res Function(Bonus) then) =
      _$BonusCopyWithImpl<$Res, Bonus>;
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? user_id,
      String? bonus_name,
      DateTime? bonus_month,
      String? bonus_amount,
      String? bonus_description,
      int? deletion_status,
      dynamic deleted_at,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class _$BonusCopyWithImpl<$Res, $Val extends Bonus>
    implements $BonusCopyWith<$Res> {
  _$BonusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? user_id = freezed,
    Object? bonus_name = freezed,
    Object? bonus_month = freezed,
    Object? bonus_amount = freezed,
    Object? bonus_description = freezed,
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
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int?,
      bonus_name: freezed == bonus_name
          ? _value.bonus_name
          : bonus_name // ignore: cast_nullable_to_non_nullable
              as String?,
      bonus_month: freezed == bonus_month
          ? _value.bonus_month
          : bonus_month // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bonus_amount: freezed == bonus_amount
          ? _value.bonus_amount
          : bonus_amount // ignore: cast_nullable_to_non_nullable
              as String?,
      bonus_description: freezed == bonus_description
          ? _value.bonus_description
          : bonus_description // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$BonusImplCopyWith<$Res> implements $BonusCopyWith<$Res> {
  factory _$$BonusImplCopyWith(
          _$BonusImpl value, $Res Function(_$BonusImpl) then) =
      __$$BonusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? user_id,
      String? bonus_name,
      DateTime? bonus_month,
      String? bonus_amount,
      String? bonus_description,
      int? deletion_status,
      dynamic deleted_at,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class __$$BonusImplCopyWithImpl<$Res>
    extends _$BonusCopyWithImpl<$Res, _$BonusImpl>
    implements _$$BonusImplCopyWith<$Res> {
  __$$BonusImplCopyWithImpl(
      _$BonusImpl _value, $Res Function(_$BonusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? user_id = freezed,
    Object? bonus_name = freezed,
    Object? bonus_month = freezed,
    Object? bonus_amount = freezed,
    Object? bonus_description = freezed,
    Object? deletion_status = freezed,
    Object? deleted_at = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$BonusImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int?,
      bonus_name: freezed == bonus_name
          ? _value.bonus_name
          : bonus_name // ignore: cast_nullable_to_non_nullable
              as String?,
      bonus_month: freezed == bonus_month
          ? _value.bonus_month
          : bonus_month // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bonus_amount: freezed == bonus_amount
          ? _value.bonus_amount
          : bonus_amount // ignore: cast_nullable_to_non_nullable
              as String?,
      bonus_description: freezed == bonus_description
          ? _value.bonus_description
          : bonus_description // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$BonusImpl implements _Bonus {
  const _$BonusImpl(
      {required this.id,
      required this.created_by,
      required this.user_id,
      required this.bonus_name,
      required this.bonus_month,
      required this.bonus_amount,
      required this.bonus_description,
      required this.deletion_status,
      required this.deleted_at,
      required this.created_at,
      required this.updated_at});

  factory _$BonusImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonusImplFromJson(json);

  @override
  final int? id;
  @override
  final int? created_by;
  @override
  final int? user_id;
  @override
  final String? bonus_name;
  @override
  final DateTime? bonus_month;
  @override
  final String? bonus_amount;
  @override
  final String? bonus_description;
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
    return 'Bonus(id: $id, created_by: $created_by, user_id: $user_id, bonus_name: $bonus_name, bonus_month: $bonus_month, bonus_amount: $bonus_amount, bonus_description: $bonus_description, deletion_status: $deletion_status, deleted_at: $deleted_at, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.bonus_name, bonus_name) ||
                other.bonus_name == bonus_name) &&
            (identical(other.bonus_month, bonus_month) ||
                other.bonus_month == bonus_month) &&
            (identical(other.bonus_amount, bonus_amount) ||
                other.bonus_amount == bonus_amount) &&
            (identical(other.bonus_description, bonus_description) ||
                other.bonus_description == bonus_description) &&
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
      user_id,
      bonus_name,
      bonus_month,
      bonus_amount,
      bonus_description,
      deletion_status,
      const DeepCollectionEquality().hash(deleted_at),
      created_at,
      updated_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BonusImplCopyWith<_$BonusImpl> get copyWith =>
      __$$BonusImplCopyWithImpl<_$BonusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BonusImplToJson(
      this,
    );
  }
}

abstract class _Bonus implements Bonus {
  const factory _Bonus(
      {required final int? id,
      required final int? created_by,
      required final int? user_id,
      required final String? bonus_name,
      required final DateTime? bonus_month,
      required final String? bonus_amount,
      required final String? bonus_description,
      required final int? deletion_status,
      required final dynamic deleted_at,
      required final DateTime? created_at,
      required final DateTime? updated_at}) = _$BonusImpl;

  factory _Bonus.fromJson(Map<String, dynamic> json) = _$BonusImpl.fromJson;

  @override
  int? get id;
  @override
  int? get created_by;
  @override
  int? get user_id;
  @override
  String? get bonus_name;
  @override
  DateTime? get bonus_month;
  @override
  String? get bonus_amount;
  @override
  String? get bonus_description;
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
  _$$BonusImplCopyWith<_$BonusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Grade _$GradeFromJson(Map<String, dynamic> json) {
  return _Grade.fromJson(json);
}

/// @nodoc
mixin _$Grade {
  int? get id => throw _privateConstructorUsedError;
  int? get user_id => throw _privateConstructorUsedError;
  int? get grade_id => throw _privateConstructorUsedError;
  String? get grade => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GradeCopyWith<Grade> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradeCopyWith<$Res> {
  factory $GradeCopyWith(Grade value, $Res Function(Grade) then) =
      _$GradeCopyWithImpl<$Res, Grade>;
  @useResult
  $Res call(
      {int? id,
      int? user_id,
      int? grade_id,
      String? grade,
      DateTime? date,
      DateTime? created_at,
      DateTime? updated_at,
      int? amount});
}

/// @nodoc
class _$GradeCopyWithImpl<$Res, $Val extends Grade>
    implements $GradeCopyWith<$Res> {
  _$GradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? grade_id = freezed,
    Object? grade = freezed,
    Object? date = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int?,
      grade_id: freezed == grade_id
          ? _value.grade_id
          : grade_id // ignore: cast_nullable_to_non_nullable
              as int?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GradeImplCopyWith<$Res> implements $GradeCopyWith<$Res> {
  factory _$$GradeImplCopyWith(
          _$GradeImpl value, $Res Function(_$GradeImpl) then) =
      __$$GradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? user_id,
      int? grade_id,
      String? grade,
      DateTime? date,
      DateTime? created_at,
      DateTime? updated_at,
      int? amount});
}

/// @nodoc
class __$$GradeImplCopyWithImpl<$Res>
    extends _$GradeCopyWithImpl<$Res, _$GradeImpl>
    implements _$$GradeImplCopyWith<$Res> {
  __$$GradeImplCopyWithImpl(
      _$GradeImpl _value, $Res Function(_$GradeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? grade_id = freezed,
    Object? grade = freezed,
    Object? date = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$GradeImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int?,
      grade_id: freezed == grade_id
          ? _value.grade_id
          : grade_id // ignore: cast_nullable_to_non_nullable
              as int?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GradeImpl implements _Grade {
  const _$GradeImpl(
      {required this.id,
      required this.user_id,
      required this.grade_id,
      required this.grade,
      required this.date,
      required this.created_at,
      required this.updated_at,
      required this.amount});

  factory _$GradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradeImplFromJson(json);

  @override
  final int? id;
  @override
  final int? user_id;
  @override
  final int? grade_id;
  @override
  final String? grade;
  @override
  final DateTime? date;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;
  @override
  final int? amount;

  @override
  String toString() {
    return 'Grade(id: $id, user_id: $user_id, grade_id: $grade_id, grade: $grade, date: $date, created_at: $created_at, updated_at: $updated_at, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.grade_id, grade_id) ||
                other.grade_id == grade_id) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user_id, grade_id, grade,
      date, created_at, updated_at, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GradeImplCopyWith<_$GradeImpl> get copyWith =>
      __$$GradeImplCopyWithImpl<_$GradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradeImplToJson(
      this,
    );
  }
}

abstract class _Grade implements Grade {
  const factory _Grade(
      {required final int? id,
      required final int? user_id,
      required final int? grade_id,
      required final String? grade,
      required final DateTime? date,
      required final DateTime? created_at,
      required final DateTime? updated_at,
      required final int? amount}) = _$GradeImpl;

  factory _Grade.fromJson(Map<String, dynamic> json) = _$GradeImpl.fromJson;

  @override
  int? get id;
  @override
  int? get user_id;
  @override
  int? get grade_id;
  @override
  String? get grade;
  @override
  DateTime? get date;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;
  @override
  int? get amount;
  @override
  @JsonKey(ignore: true)
  _$$GradeImplCopyWith<_$GradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Payroll _$PayrollFromJson(Map<String, dynamic> json) {
  return _Payroll.fromJson(json);
}

/// @nodoc
mixin _$Payroll {
  int? get id => throw _privateConstructorUsedError;
  int? get created_by => throw _privateConstructorUsedError;
  int? get user_id => throw _privateConstructorUsedError;
  int? get employee_type => throw _privateConstructorUsedError;
  String? get basic_salary => throw _privateConstructorUsedError;
  String? get house_rent_allowance => throw _privateConstructorUsedError;
  String? get medical_allowance => throw _privateConstructorUsedError;
  dynamic get special_allowance => throw _privateConstructorUsedError;
  dynamic get provident_fund_contribution => throw _privateConstructorUsedError;
  dynamic get other_allowance => throw _privateConstructorUsedError;
  dynamic get tax_deduction => throw _privateConstructorUsedError;
  dynamic get provident_fund_deduction => throw _privateConstructorUsedError;
  dynamic get other_deduction => throw _privateConstructorUsedError;
  int? get activation_status => throw _privateConstructorUsedError;
  dynamic get date => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollCopyWith<Payroll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollCopyWith<$Res> {
  factory $PayrollCopyWith(Payroll value, $Res Function(Payroll) then) =
      _$PayrollCopyWithImpl<$Res, Payroll>;
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? user_id,
      int? employee_type,
      String? basic_salary,
      String? house_rent_allowance,
      String? medical_allowance,
      dynamic special_allowance,
      dynamic provident_fund_contribution,
      dynamic other_allowance,
      dynamic tax_deduction,
      dynamic provident_fund_deduction,
      dynamic other_deduction,
      int? activation_status,
      dynamic date,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class _$PayrollCopyWithImpl<$Res, $Val extends Payroll>
    implements $PayrollCopyWith<$Res> {
  _$PayrollCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? user_id = freezed,
    Object? employee_type = freezed,
    Object? basic_salary = freezed,
    Object? house_rent_allowance = freezed,
    Object? medical_allowance = freezed,
    Object? special_allowance = freezed,
    Object? provident_fund_contribution = freezed,
    Object? other_allowance = freezed,
    Object? tax_deduction = freezed,
    Object? provident_fund_deduction = freezed,
    Object? other_deduction = freezed,
    Object? activation_status = freezed,
    Object? date = freezed,
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
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int?,
      employee_type: freezed == employee_type
          ? _value.employee_type
          : employee_type // ignore: cast_nullable_to_non_nullable
              as int?,
      basic_salary: freezed == basic_salary
          ? _value.basic_salary
          : basic_salary // ignore: cast_nullable_to_non_nullable
              as String?,
      house_rent_allowance: freezed == house_rent_allowance
          ? _value.house_rent_allowance
          : house_rent_allowance // ignore: cast_nullable_to_non_nullable
              as String?,
      medical_allowance: freezed == medical_allowance
          ? _value.medical_allowance
          : medical_allowance // ignore: cast_nullable_to_non_nullable
              as String?,
      special_allowance: freezed == special_allowance
          ? _value.special_allowance
          : special_allowance // ignore: cast_nullable_to_non_nullable
              as dynamic,
      provident_fund_contribution: freezed == provident_fund_contribution
          ? _value.provident_fund_contribution
          : provident_fund_contribution // ignore: cast_nullable_to_non_nullable
              as dynamic,
      other_allowance: freezed == other_allowance
          ? _value.other_allowance
          : other_allowance // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tax_deduction: freezed == tax_deduction
          ? _value.tax_deduction
          : tax_deduction // ignore: cast_nullable_to_non_nullable
              as dynamic,
      provident_fund_deduction: freezed == provident_fund_deduction
          ? _value.provident_fund_deduction
          : provident_fund_deduction // ignore: cast_nullable_to_non_nullable
              as dynamic,
      other_deduction: freezed == other_deduction
          ? _value.other_deduction
          : other_deduction // ignore: cast_nullable_to_non_nullable
              as dynamic,
      activation_status: freezed == activation_status
          ? _value.activation_status
          : activation_status // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
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
abstract class _$$PayrollImplCopyWith<$Res> implements $PayrollCopyWith<$Res> {
  factory _$$PayrollImplCopyWith(
          _$PayrollImpl value, $Res Function(_$PayrollImpl) then) =
      __$$PayrollImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? created_by,
      int? user_id,
      int? employee_type,
      String? basic_salary,
      String? house_rent_allowance,
      String? medical_allowance,
      dynamic special_allowance,
      dynamic provident_fund_contribution,
      dynamic other_allowance,
      dynamic tax_deduction,
      dynamic provident_fund_deduction,
      dynamic other_deduction,
      int? activation_status,
      dynamic date,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class __$$PayrollImplCopyWithImpl<$Res>
    extends _$PayrollCopyWithImpl<$Res, _$PayrollImpl>
    implements _$$PayrollImplCopyWith<$Res> {
  __$$PayrollImplCopyWithImpl(
      _$PayrollImpl _value, $Res Function(_$PayrollImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? created_by = freezed,
    Object? user_id = freezed,
    Object? employee_type = freezed,
    Object? basic_salary = freezed,
    Object? house_rent_allowance = freezed,
    Object? medical_allowance = freezed,
    Object? special_allowance = freezed,
    Object? provident_fund_contribution = freezed,
    Object? other_allowance = freezed,
    Object? tax_deduction = freezed,
    Object? provident_fund_deduction = freezed,
    Object? other_deduction = freezed,
    Object? activation_status = freezed,
    Object? date = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$PayrollImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_by: freezed == created_by
          ? _value.created_by
          : created_by // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as int?,
      employee_type: freezed == employee_type
          ? _value.employee_type
          : employee_type // ignore: cast_nullable_to_non_nullable
              as int?,
      basic_salary: freezed == basic_salary
          ? _value.basic_salary
          : basic_salary // ignore: cast_nullable_to_non_nullable
              as String?,
      house_rent_allowance: freezed == house_rent_allowance
          ? _value.house_rent_allowance
          : house_rent_allowance // ignore: cast_nullable_to_non_nullable
              as String?,
      medical_allowance: freezed == medical_allowance
          ? _value.medical_allowance
          : medical_allowance // ignore: cast_nullable_to_non_nullable
              as String?,
      special_allowance: freezed == special_allowance
          ? _value.special_allowance
          : special_allowance // ignore: cast_nullable_to_non_nullable
              as dynamic,
      provident_fund_contribution: freezed == provident_fund_contribution
          ? _value.provident_fund_contribution
          : provident_fund_contribution // ignore: cast_nullable_to_non_nullable
              as dynamic,
      other_allowance: freezed == other_allowance
          ? _value.other_allowance
          : other_allowance // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tax_deduction: freezed == tax_deduction
          ? _value.tax_deduction
          : tax_deduction // ignore: cast_nullable_to_non_nullable
              as dynamic,
      provident_fund_deduction: freezed == provident_fund_deduction
          ? _value.provident_fund_deduction
          : provident_fund_deduction // ignore: cast_nullable_to_non_nullable
              as dynamic,
      other_deduction: freezed == other_deduction
          ? _value.other_deduction
          : other_deduction // ignore: cast_nullable_to_non_nullable
              as dynamic,
      activation_status: freezed == activation_status
          ? _value.activation_status
          : activation_status // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
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
class _$PayrollImpl implements _Payroll {
  const _$PayrollImpl(
      {required this.id,
      required this.created_by,
      required this.user_id,
      required this.employee_type,
      required this.basic_salary,
      required this.house_rent_allowance,
      required this.medical_allowance,
      required this.special_allowance,
      required this.provident_fund_contribution,
      required this.other_allowance,
      required this.tax_deduction,
      required this.provident_fund_deduction,
      required this.other_deduction,
      required this.activation_status,
      required this.date,
      required this.created_at,
      required this.updated_at});

  factory _$PayrollImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollImplFromJson(json);

  @override
  final int? id;
  @override
  final int? created_by;
  @override
  final int? user_id;
  @override
  final int? employee_type;
  @override
  final String? basic_salary;
  @override
  final String? house_rent_allowance;
  @override
  final String? medical_allowance;
  @override
  final dynamic special_allowance;
  @override
  final dynamic provident_fund_contribution;
  @override
  final dynamic other_allowance;
  @override
  final dynamic tax_deduction;
  @override
  final dynamic provident_fund_deduction;
  @override
  final dynamic other_deduction;
  @override
  final int? activation_status;
  @override
  final dynamic date;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;

  @override
  String toString() {
    return 'Payroll(id: $id, created_by: $created_by, user_id: $user_id, employee_type: $employee_type, basic_salary: $basic_salary, house_rent_allowance: $house_rent_allowance, medical_allowance: $medical_allowance, special_allowance: $special_allowance, provident_fund_contribution: $provident_fund_contribution, other_allowance: $other_allowance, tax_deduction: $tax_deduction, provident_fund_deduction: $provident_fund_deduction, other_deduction: $other_deduction, activation_status: $activation_status, date: $date, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.created_by, created_by) ||
                other.created_by == created_by) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.employee_type, employee_type) ||
                other.employee_type == employee_type) &&
            (identical(other.basic_salary, basic_salary) ||
                other.basic_salary == basic_salary) &&
            (identical(other.house_rent_allowance, house_rent_allowance) ||
                other.house_rent_allowance == house_rent_allowance) &&
            (identical(other.medical_allowance, medical_allowance) ||
                other.medical_allowance == medical_allowance) &&
            const DeepCollectionEquality()
                .equals(other.special_allowance, special_allowance) &&
            const DeepCollectionEquality().equals(
                other.provident_fund_contribution,
                provident_fund_contribution) &&
            const DeepCollectionEquality()
                .equals(other.other_allowance, other_allowance) &&
            const DeepCollectionEquality()
                .equals(other.tax_deduction, tax_deduction) &&
            const DeepCollectionEquality().equals(
                other.provident_fund_deduction, provident_fund_deduction) &&
            const DeepCollectionEquality()
                .equals(other.other_deduction, other_deduction) &&
            (identical(other.activation_status, activation_status) ||
                other.activation_status == activation_status) &&
            const DeepCollectionEquality().equals(other.date, date) &&
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
      user_id,
      employee_type,
      basic_salary,
      house_rent_allowance,
      medical_allowance,
      const DeepCollectionEquality().hash(special_allowance),
      const DeepCollectionEquality().hash(provident_fund_contribution),
      const DeepCollectionEquality().hash(other_allowance),
      const DeepCollectionEquality().hash(tax_deduction),
      const DeepCollectionEquality().hash(provident_fund_deduction),
      const DeepCollectionEquality().hash(other_deduction),
      activation_status,
      const DeepCollectionEquality().hash(date),
      created_at,
      updated_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollImplCopyWith<_$PayrollImpl> get copyWith =>
      __$$PayrollImplCopyWithImpl<_$PayrollImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollImplToJson(
      this,
    );
  }
}

abstract class _Payroll implements Payroll {
  const factory _Payroll(
      {required final int? id,
      required final int? created_by,
      required final int? user_id,
      required final int? employee_type,
      required final String? basic_salary,
      required final String? house_rent_allowance,
      required final String? medical_allowance,
      required final dynamic special_allowance,
      required final dynamic provident_fund_contribution,
      required final dynamic other_allowance,
      required final dynamic tax_deduction,
      required final dynamic provident_fund_deduction,
      required final dynamic other_deduction,
      required final int? activation_status,
      required final dynamic date,
      required final DateTime? created_at,
      required final DateTime? updated_at}) = _$PayrollImpl;

  factory _Payroll.fromJson(Map<String, dynamic> json) = _$PayrollImpl.fromJson;

  @override
  int? get id;
  @override
  int? get created_by;
  @override
  int? get user_id;
  @override
  int? get employee_type;
  @override
  String? get basic_salary;
  @override
  String? get house_rent_allowance;
  @override
  String? get medical_allowance;
  @override
  dynamic get special_allowance;
  @override
  dynamic get provident_fund_contribution;
  @override
  dynamic get other_allowance;
  @override
  dynamic get tax_deduction;
  @override
  dynamic get provident_fund_deduction;
  @override
  dynamic get other_deduction;
  @override
  int? get activation_status;
  @override
  dynamic get date;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;
  @override
  @JsonKey(ignore: true)
  _$$PayrollImplCopyWith<_$PayrollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
