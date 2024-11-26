// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaveCategoryResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaveCategoryResponse _$LeaveCategoryResponseFromJson(
    Map<String, dynamic> json) {
  return _LeaveCategoryResponse.fromJson(json);
}

/// @nodoc
mixin _$LeaveCategoryResponse {
  List<LeaveCategory>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveCategoryResponseCopyWith<LeaveCategoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveCategoryResponseCopyWith<$Res> {
  factory $LeaveCategoryResponseCopyWith(LeaveCategoryResponse value,
          $Res Function(LeaveCategoryResponse) then) =
      _$LeaveCategoryResponseCopyWithImpl<$Res, LeaveCategoryResponse>;
  @useResult
  $Res call({List<LeaveCategory>? data});
}

/// @nodoc
class _$LeaveCategoryResponseCopyWithImpl<$Res,
        $Val extends LeaveCategoryResponse>
    implements $LeaveCategoryResponseCopyWith<$Res> {
  _$LeaveCategoryResponseCopyWithImpl(this._value, this._then);

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
              as List<LeaveCategory>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveCategoryResponseImplCopyWith<$Res>
    implements $LeaveCategoryResponseCopyWith<$Res> {
  factory _$$LeaveCategoryResponseImplCopyWith(
          _$LeaveCategoryResponseImpl value,
          $Res Function(_$LeaveCategoryResponseImpl) then) =
      __$$LeaveCategoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LeaveCategory>? data});
}

/// @nodoc
class __$$LeaveCategoryResponseImplCopyWithImpl<$Res>
    extends _$LeaveCategoryResponseCopyWithImpl<$Res,
        _$LeaveCategoryResponseImpl>
    implements _$$LeaveCategoryResponseImplCopyWith<$Res> {
  __$$LeaveCategoryResponseImplCopyWithImpl(_$LeaveCategoryResponseImpl _value,
      $Res Function(_$LeaveCategoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$LeaveCategoryResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LeaveCategory>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveCategoryResponseImpl implements _LeaveCategoryResponse {
  const _$LeaveCategoryResponseImpl({required final List<LeaveCategory>? data})
      : _data = data;

  factory _$LeaveCategoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveCategoryResponseImplFromJson(json);

  final List<LeaveCategory>? _data;
  @override
  List<LeaveCategory>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LeaveCategoryResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveCategoryResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveCategoryResponseImplCopyWith<_$LeaveCategoryResponseImpl>
      get copyWith => __$$LeaveCategoryResponseImplCopyWithImpl<
          _$LeaveCategoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveCategoryResponseImplToJson(
      this,
    );
  }
}

abstract class _LeaveCategoryResponse implements LeaveCategoryResponse {
  const factory _LeaveCategoryResponse(
      {required final List<LeaveCategory>? data}) = _$LeaveCategoryResponseImpl;

  factory _LeaveCategoryResponse.fromJson(Map<String, dynamic> json) =
      _$LeaveCategoryResponseImpl.fromJson;

  @override
  List<LeaveCategory>? get data;
  @override
  @JsonKey(ignore: true)
  _$$LeaveCategoryResponseImplCopyWith<_$LeaveCategoryResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LeaveCategory _$LeaveCategoryFromJson(Map<String, dynamic> json) {
  return _LeaveCategory.fromJson(json);
}

/// @nodoc
mixin _$LeaveCategory {
  int? get id => throw _privateConstructorUsedError;
  String? get leave_category => throw _privateConstructorUsedError;
  String? get leave_category_description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveCategoryCopyWith<LeaveCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveCategoryCopyWith<$Res> {
  factory $LeaveCategoryCopyWith(
          LeaveCategory value, $Res Function(LeaveCategory) then) =
      _$LeaveCategoryCopyWithImpl<$Res, LeaveCategory>;
  @useResult
  $Res call(
      {int? id, String? leave_category, String? leave_category_description});
}

/// @nodoc
class _$LeaveCategoryCopyWithImpl<$Res, $Val extends LeaveCategory>
    implements $LeaveCategoryCopyWith<$Res> {
  _$LeaveCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? leave_category = freezed,
    Object? leave_category_description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      leave_category: freezed == leave_category
          ? _value.leave_category
          : leave_category // ignore: cast_nullable_to_non_nullable
              as String?,
      leave_category_description: freezed == leave_category_description
          ? _value.leave_category_description
          : leave_category_description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveCategoryImplCopyWith<$Res>
    implements $LeaveCategoryCopyWith<$Res> {
  factory _$$LeaveCategoryImplCopyWith(
          _$LeaveCategoryImpl value, $Res Function(_$LeaveCategoryImpl) then) =
      __$$LeaveCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? leave_category, String? leave_category_description});
}

/// @nodoc
class __$$LeaveCategoryImplCopyWithImpl<$Res>
    extends _$LeaveCategoryCopyWithImpl<$Res, _$LeaveCategoryImpl>
    implements _$$LeaveCategoryImplCopyWith<$Res> {
  __$$LeaveCategoryImplCopyWithImpl(
      _$LeaveCategoryImpl _value, $Res Function(_$LeaveCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? leave_category = freezed,
    Object? leave_category_description = freezed,
  }) {
    return _then(_$LeaveCategoryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      leave_category: freezed == leave_category
          ? _value.leave_category
          : leave_category // ignore: cast_nullable_to_non_nullable
              as String?,
      leave_category_description: freezed == leave_category_description
          ? _value.leave_category_description
          : leave_category_description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveCategoryImpl implements _LeaveCategory {
  const _$LeaveCategoryImpl(
      {required this.id,
      required this.leave_category,
      required this.leave_category_description});

  factory _$LeaveCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveCategoryImplFromJson(json);

  @override
  final int? id;
  @override
  final String? leave_category;
  @override
  final String? leave_category_description;

  @override
  String toString() {
    return 'LeaveCategory(id: $id, leave_category: $leave_category, leave_category_description: $leave_category_description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.leave_category, leave_category) ||
                other.leave_category == leave_category) &&
            (identical(other.leave_category_description,
                    leave_category_description) ||
                other.leave_category_description ==
                    leave_category_description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, leave_category, leave_category_description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveCategoryImplCopyWith<_$LeaveCategoryImpl> get copyWith =>
      __$$LeaveCategoryImplCopyWithImpl<_$LeaveCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveCategoryImplToJson(
      this,
    );
  }
}

abstract class _LeaveCategory implements LeaveCategory {
  const factory _LeaveCategory(
      {required final int? id,
      required final String? leave_category,
      required final String? leave_category_description}) = _$LeaveCategoryImpl;

  factory _LeaveCategory.fromJson(Map<String, dynamic> json) =
      _$LeaveCategoryImpl.fromJson;

  @override
  int? get id;
  @override
  String? get leave_category;
  @override
  String? get leave_category_description;
  @override
  @JsonKey(ignore: true)
  _$$LeaveCategoryImplCopyWith<_$LeaveCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
