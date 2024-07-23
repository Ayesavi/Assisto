// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_req_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentReqModel _$PaymentReqModelFromJson(Map<String, dynamic> json) {
  return _PaymentReqModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentReqModel {
  @JsonKey(name: "payment_session_id")
  String get sessionId => throw _privateConstructorUsedError;
  @JsonKey(name: "cf_order_id")
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: "order_amount")
  double get amount => throw _privateConstructorUsedError;

  /// Serializes this PaymentReqModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentReqModelCopyWith<PaymentReqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentReqModelCopyWith<$Res> {
  factory $PaymentReqModelCopyWith(
          PaymentReqModel value, $Res Function(PaymentReqModel) then) =
      _$PaymentReqModelCopyWithImpl<$Res, PaymentReqModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "payment_session_id") String sessionId,
      @JsonKey(name: "cf_order_id") String orderId,
      @JsonKey(name: "order_amount") double amount});
}

/// @nodoc
class _$PaymentReqModelCopyWithImpl<$Res, $Val extends PaymentReqModel>
    implements $PaymentReqModelCopyWith<$Res> {
  _$PaymentReqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? orderId = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentReqModelImplCopyWith<$Res>
    implements $PaymentReqModelCopyWith<$Res> {
  factory _$$PaymentReqModelImplCopyWith(_$PaymentReqModelImpl value,
          $Res Function(_$PaymentReqModelImpl) then) =
      __$$PaymentReqModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "payment_session_id") String sessionId,
      @JsonKey(name: "cf_order_id") String orderId,
      @JsonKey(name: "order_amount") double amount});
}

/// @nodoc
class __$$PaymentReqModelImplCopyWithImpl<$Res>
    extends _$PaymentReqModelCopyWithImpl<$Res, _$PaymentReqModelImpl>
    implements _$$PaymentReqModelImplCopyWith<$Res> {
  __$$PaymentReqModelImplCopyWithImpl(
      _$PaymentReqModelImpl _value, $Res Function(_$PaymentReqModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentReqModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? orderId = null,
    Object? amount = null,
  }) {
    return _then(_$PaymentReqModelImpl(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentReqModelImpl implements _PaymentReqModel {
  _$PaymentReqModelImpl(
      {@JsonKey(name: "payment_session_id") required this.sessionId,
      @JsonKey(name: "cf_order_id") required this.orderId,
      @JsonKey(name: "order_amount") required this.amount});

  factory _$PaymentReqModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentReqModelImplFromJson(json);

  @override
  @JsonKey(name: "payment_session_id")
  final String sessionId;
  @override
  @JsonKey(name: "cf_order_id")
  final String orderId;
  @override
  @JsonKey(name: "order_amount")
  final double amount;

  @override
  String toString() {
    return 'PaymentReqModel(sessionId: $sessionId, orderId: $orderId, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentReqModelImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sessionId, orderId, amount);

  /// Create a copy of PaymentReqModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentReqModelImplCopyWith<_$PaymentReqModelImpl> get copyWith =>
      __$$PaymentReqModelImplCopyWithImpl<_$PaymentReqModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentReqModelImplToJson(
      this,
    );
  }
}

abstract class _PaymentReqModel implements PaymentReqModel {
  factory _PaymentReqModel(
          {@JsonKey(name: "payment_session_id") required final String sessionId,
          @JsonKey(name: "cf_order_id") required final String orderId,
          @JsonKey(name: "order_amount") required final double amount}) =
      _$PaymentReqModelImpl;

  factory _PaymentReqModel.fromJson(Map<String, dynamic> json) =
      _$PaymentReqModelImpl.fromJson;

  @override
  @JsonKey(name: "payment_session_id")
  String get sessionId;
  @override
  @JsonKey(name: "cf_order_id")
  String get orderId;
  @override
  @JsonKey(name: "order_amount")
  double get amount;

  /// Create a copy of PaymentReqModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentReqModelImplCopyWith<_$PaymentReqModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
