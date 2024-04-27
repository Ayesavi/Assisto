// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceCategoryModel _$ServiceCategoryModelFromJson(Map<String, dynamic> json) {
  return _ServiceCategoryModel.fromJson(json);
}

/// @nodoc
mixin _$ServiceCategoryModel {
  String get description => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceCategoryModelCopyWith<ServiceCategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceCategoryModelCopyWith<$Res> {
  factory $ServiceCategoryModelCopyWith(ServiceCategoryModel value,
          $Res Function(ServiceCategoryModel) then) =
      _$ServiceCategoryModelCopyWithImpl<$Res, ServiceCategoryModel>;
  @useResult
  $Res call({String description, String label});
}

/// @nodoc
class _$ServiceCategoryModelCopyWithImpl<$Res,
        $Val extends ServiceCategoryModel>
    implements $ServiceCategoryModelCopyWith<$Res> {
  _$ServiceCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceCategoryModelImplCopyWith<$Res>
    implements $ServiceCategoryModelCopyWith<$Res> {
  factory _$$ServiceCategoryModelImplCopyWith(_$ServiceCategoryModelImpl value,
          $Res Function(_$ServiceCategoryModelImpl) then) =
      __$$ServiceCategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String label});
}

/// @nodoc
class __$$ServiceCategoryModelImplCopyWithImpl<$Res>
    extends _$ServiceCategoryModelCopyWithImpl<$Res, _$ServiceCategoryModelImpl>
    implements _$$ServiceCategoryModelImplCopyWith<$Res> {
  __$$ServiceCategoryModelImplCopyWithImpl(_$ServiceCategoryModelImpl _value,
      $Res Function(_$ServiceCategoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? label = null,
  }) {
    return _then(_$ServiceCategoryModelImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceCategoryModelImpl implements _ServiceCategoryModel {
  _$ServiceCategoryModelImpl({required this.description, required this.label});

  factory _$ServiceCategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceCategoryModelImplFromJson(json);

  @override
  final String description;
  @override
  final String label;

  @override
  String toString() {
    return 'ServiceCategoryModel(description: $description, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceCategoryModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceCategoryModelImplCopyWith<_$ServiceCategoryModelImpl>
      get copyWith =>
          __$$ServiceCategoryModelImplCopyWithImpl<_$ServiceCategoryModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceCategoryModelImplToJson(
      this,
    );
  }
}

abstract class _ServiceCategoryModel implements ServiceCategoryModel {
  factory _ServiceCategoryModel(
      {required final String description,
      required final String label}) = _$ServiceCategoryModelImpl;

  factory _ServiceCategoryModel.fromJson(Map<String, dynamic> json) =
      _$ServiceCategoryModelImpl.fromJson;

  @override
  String get description;
  @override
  String get label;
  @override
  @JsonKey(ignore: true)
  _$$ServiceCategoryModelImplCopyWith<_$ServiceCategoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
