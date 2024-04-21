// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return _AddressModel.fromJson(json);
}

/// @nodoc
mixin _$AddressModel {
  String get address => throw _privateConstructorUsedError;
  String? get landmark => throw _privateConstructorUsedError;
  ({double lat, double lng}) get latlng => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_id', includeToJson: false)
  String? get ownerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
          AddressModel value, $Res Function(AddressModel) then) =
      _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call(
      {String address,
      String? landmark,
      ({double lat, double lng}) latlng,
      @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(includeToJson: false) int id});
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? landmark = freezed,
    Object? latlng = null,
    Object? ownerId = freezed,
    Object? createdAt = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng}),
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressModelImplCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$AddressModelImplCopyWith(
          _$AddressModelImpl value, $Res Function(_$AddressModelImpl) then) =
      __$$AddressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String? landmark,
      ({double lat, double lng}) latlng,
      @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(includeToJson: false) int id});
}

/// @nodoc
class __$$AddressModelImplCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$AddressModelImpl>
    implements _$$AddressModelImplCopyWith<$Res> {
  __$$AddressModelImplCopyWithImpl(
      _$AddressModelImpl _value, $Res Function(_$AddressModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? landmark = freezed,
    Object? latlng = null,
    Object? ownerId = freezed,
    Object? createdAt = null,
    Object? id = null,
  }) {
    return _then(_$AddressModelImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng}),
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressModelImpl implements _AddressModel {
  _$AddressModelImpl(
      {required this.address,
      this.landmark,
      required this.latlng,
      @JsonKey(name: 'owner_id', includeToJson: false) this.ownerId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(includeToJson: false) required this.id});

  factory _$AddressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressModelImplFromJson(json);

  @override
  final String address;
  @override
  final String? landmark;
  @override
  final ({double lat, double lng}) latlng;
  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  final String? ownerId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(includeToJson: false)
  final int id;

  @override
  String toString() {
    return 'AddressModel(address: $address, landmark: $landmark, latlng: $latlng, ownerId: $ownerId, createdAt: $createdAt, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.latlng, latlng) || other.latlng == latlng) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, address, landmark, latlng, ownerId, createdAt, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      __$$AddressModelImplCopyWithImpl<_$AddressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressModelImplToJson(
      this,
    );
  }
}

abstract class _AddressModel implements AddressModel {
  factory _AddressModel(
      {required final String address,
      final String? landmark,
      required final ({double lat, double lng}) latlng,
      @JsonKey(name: 'owner_id', includeToJson: false) final String? ownerId,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(includeToJson: false)
      required final int id}) = _$AddressModelImpl;

  factory _AddressModel.fromJson(Map<String, dynamic> json) =
      _$AddressModelImpl.fromJson;

  @override
  String get address;
  @override
  String? get landmark;
  @override
  ({double lat, double lng}) get latlng;
  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  String? get ownerId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
