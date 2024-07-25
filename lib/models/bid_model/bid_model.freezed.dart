// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BidModel _$BidModelFromJson(Map<String, dynamic> json) {
  return _BidModel.fromJson(json);
}

/// @nodoc
mixin _$BidModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: UserModel.fromSupbase)
  UserModel get bidder => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  /// Serializes this BidModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BidModelCopyWith<BidModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidModelCopyWith<$Res> {
  factory $BidModelCopyWith(BidModel value, $Res Function(BidModel) then) =
      _$BidModelCopyWithImpl<$Res, BidModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(fromJson: UserModel.fromSupbase) UserModel bidder,
      int amount});

  $UserModelCopyWith<$Res> get bidder;
}

/// @nodoc
class _$BidModelCopyWithImpl<$Res, $Val extends BidModel>
    implements $BidModelCopyWith<$Res> {
  _$BidModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? bidder = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bidder: null == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as UserModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get bidder {
    return $UserModelCopyWith<$Res>(_value.bidder, (value) {
      return _then(_value.copyWith(bidder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BidModelImplCopyWith<$Res>
    implements $BidModelCopyWith<$Res> {
  factory _$$BidModelImplCopyWith(
          _$BidModelImpl value, $Res Function(_$BidModelImpl) then) =
      __$$BidModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(fromJson: UserModel.fromSupbase) UserModel bidder,
      int amount});

  @override
  $UserModelCopyWith<$Res> get bidder;
}

/// @nodoc
class __$$BidModelImplCopyWithImpl<$Res>
    extends _$BidModelCopyWithImpl<$Res, _$BidModelImpl>
    implements _$$BidModelImplCopyWith<$Res> {
  __$$BidModelImplCopyWithImpl(
      _$BidModelImpl _value, $Res Function(_$BidModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? bidder = null,
    Object? amount = null,
  }) {
    return _then(_$BidModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bidder: null == bidder
          ? _value.bidder
          : bidder // ignore: cast_nullable_to_non_nullable
              as UserModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BidModelImpl implements _BidModel {
  const _$BidModelImpl(
      {required this.id,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(fromJson: UserModel.fromSupbase) required this.bidder,
      required this.amount});

  factory _$BidModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(fromJson: UserModel.fromSupbase)
  final UserModel bidder;
  @override
  final int amount;

  @override
  String toString() {
    return 'BidModel(id: $id, createdAt: $createdAt, bidder: $bidder, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bidder, bidder) || other.bidder == bidder) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, bidder, amount);

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BidModelImplCopyWith<_$BidModelImpl> get copyWith =>
      __$$BidModelImplCopyWithImpl<_$BidModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BidModelImplToJson(
      this,
    );
  }
}

abstract class _BidModel implements BidModel {
  const factory _BidModel(
      {required final int id,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(fromJson: UserModel.fromSupbase) required final UserModel bidder,
      required final int amount}) = _$BidModelImpl;

  factory _BidModel.fromJson(Map<String, dynamic> json) =
      _$BidModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(fromJson: UserModel.fromSupbase)
  UserModel get bidder;
  @override
  int get amount;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BidModelImplCopyWith<_$BidModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
