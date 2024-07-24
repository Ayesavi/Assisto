// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: TransactionUserModel.fromSupabase)
  TransactionUserModel get recipient => throw _privateConstructorUsedError;
  @JsonKey(fromJson: TransactionUserModel.fromSupabase)
  TransactionUserModel get sender => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      TransactionUserModel recipient,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      TransactionUserModel sender,
      int amount,
      @JsonKey(name: 'created_at') DateTime createdAt,
      PaymentStatus paymentStatus});

  $TransactionUserModelCopyWith<$Res> get recipient;
  $TransactionUserModelCopyWith<$Res> get sender;
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipient = null,
    Object? sender = null,
    Object? amount = null,
    Object? createdAt = null,
    Object? paymentStatus = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as TransactionUserModel,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as TransactionUserModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
    ) as $Val);
  }

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionUserModelCopyWith<$Res> get recipient {
    return $TransactionUserModelCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value) as $Val);
    });
  }

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionUserModelCopyWith<$Res> get sender {
    return $TransactionUserModelCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      TransactionUserModel recipient,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      TransactionUserModel sender,
      int amount,
      @JsonKey(name: 'created_at') DateTime createdAt,
      PaymentStatus paymentStatus});

  @override
  $TransactionUserModelCopyWith<$Res> get recipient;
  @override
  $TransactionUserModelCopyWith<$Res> get sender;
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recipient = null,
    Object? sender = null,
    Object? amount = null,
    Object? createdAt = null,
    Object? paymentStatus = null,
  }) {
    return _then(_$TransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as TransactionUserModel,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as TransactionUserModel,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl(
      {required this.id,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      required this.recipient,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      required this.sender,
      required this.amount,
      @JsonKey(name: 'created_at') required this.createdAt,
      required this.paymentStatus});

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(fromJson: TransactionUserModel.fromSupabase)
  final TransactionUserModel recipient;
  @override
  @JsonKey(fromJson: TransactionUserModel.fromSupabase)
  final TransactionUserModel sender;
  @override
  final int amount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final PaymentStatus paymentStatus;

  @override
  String toString() {
    return 'TransactionModel(id: $id, recipient: $recipient, sender: $sender, amount: $amount, createdAt: $createdAt, paymentStatus: $paymentStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, recipient, sender, amount, createdAt, paymentStatus);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {required final String id,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      required final TransactionUserModel recipient,
      @JsonKey(fromJson: TransactionUserModel.fromSupabase)
      required final TransactionUserModel sender,
      required final int amount,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      required final PaymentStatus paymentStatus}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(fromJson: TransactionUserModel.fromSupabase)
  TransactionUserModel get recipient;
  @override
  @JsonKey(fromJson: TransactionUserModel.fromSupabase)
  TransactionUserModel get sender;
  @override
  int get amount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  PaymentStatus get paymentStatus;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionUserModel _$TransactionUserModelFromJson(Map<String, dynamic> json) {
  return _TransactionUserModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionUserModel {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: "avatar_url")
  String get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this TransactionUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionUserModelCopyWith<TransactionUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionUserModelCopyWith<$Res> {
  factory $TransactionUserModelCopyWith(TransactionUserModel value,
          $Res Function(TransactionUserModel) then) =
      _$TransactionUserModelCopyWithImpl<$Res, TransactionUserModel>;
  @useResult
  $Res call(
      {String name, String id, @JsonKey(name: "avatar_url") String avatarUrl});
}

/// @nodoc
class _$TransactionUserModelCopyWithImpl<$Res,
        $Val extends TransactionUserModel>
    implements $TransactionUserModelCopyWith<$Res> {
  _$TransactionUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionUserModelImplCopyWith<$Res>
    implements $TransactionUserModelCopyWith<$Res> {
  factory _$$TransactionUserModelImplCopyWith(_$TransactionUserModelImpl value,
          $Res Function(_$TransactionUserModelImpl) then) =
      __$$TransactionUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String id, @JsonKey(name: "avatar_url") String avatarUrl});
}

/// @nodoc
class __$$TransactionUserModelImplCopyWithImpl<$Res>
    extends _$TransactionUserModelCopyWithImpl<$Res, _$TransactionUserModelImpl>
    implements _$$TransactionUserModelImplCopyWith<$Res> {
  __$$TransactionUserModelImplCopyWithImpl(_$TransactionUserModelImpl _value,
      $Res Function(_$TransactionUserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? avatarUrl = null,
  }) {
    return _then(_$TransactionUserModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionUserModelImpl implements _TransactionUserModel {
  const _$TransactionUserModelImpl(
      {required this.name,
      required this.id,
      @JsonKey(name: "avatar_url") required this.avatarUrl});

  factory _$TransactionUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionUserModelImplFromJson(json);

  @override
  final String name;
  @override
  final String id;
  @override
  @JsonKey(name: "avatar_url")
  final String avatarUrl;

  @override
  String toString() {
    return 'TransactionUserModel(name: $name, id: $id, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionUserModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, avatarUrl);

  /// Create a copy of TransactionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionUserModelImplCopyWith<_$TransactionUserModelImpl>
      get copyWith =>
          __$$TransactionUserModelImplCopyWithImpl<_$TransactionUserModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionUserModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionUserModel implements TransactionUserModel {
  const factory _TransactionUserModel(
          {required final String name,
          required final String id,
          @JsonKey(name: "avatar_url") required final String avatarUrl}) =
      _$TransactionUserModelImpl;

  factory _TransactionUserModel.fromJson(Map<String, dynamic> json) =
      _$TransactionUserModelImpl.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  @JsonKey(name: "avatar_url")
  String get avatarUrl;

  /// Create a copy of TransactionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionUserModelImplCopyWith<_$TransactionUserModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
