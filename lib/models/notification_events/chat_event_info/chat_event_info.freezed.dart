// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_event_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatEventInfo _$ChatEventInfoFromJson(Map<String, dynamic> json) {
  return _ChatEventInfo.fromJson(json);
}

/// @nodoc
mixin _$ChatEventInfo {
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_id')
  String get messageId => throw _privateConstructorUsedError;

  /// Serializes this ChatEventInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatEventInfoCopyWith<ChatEventInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventInfoCopyWith<$Res> {
  factory $ChatEventInfoCopyWith(
          ChatEventInfo value, $Res Function(ChatEventInfo) then) =
      _$ChatEventInfoCopyWithImpl<$Res, ChatEventInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'room_id') String roomId,
      @JsonKey(name: 'message_id') String messageId});
}

/// @nodoc
class _$ChatEventInfoCopyWithImpl<$Res, $Val extends ChatEventInfo>
    implements $ChatEventInfoCopyWith<$Res> {
  _$ChatEventInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? messageId = null,
  }) {
    return _then(_value.copyWith(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatEventInfoImplCopyWith<$Res>
    implements $ChatEventInfoCopyWith<$Res> {
  factory _$$ChatEventInfoImplCopyWith(
          _$ChatEventInfoImpl value, $Res Function(_$ChatEventInfoImpl) then) =
      __$$ChatEventInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'room_id') String roomId,
      @JsonKey(name: 'message_id') String messageId});
}

/// @nodoc
class __$$ChatEventInfoImplCopyWithImpl<$Res>
    extends _$ChatEventInfoCopyWithImpl<$Res, _$ChatEventInfoImpl>
    implements _$$ChatEventInfoImplCopyWith<$Res> {
  __$$ChatEventInfoImplCopyWithImpl(
      _$ChatEventInfoImpl _value, $Res Function(_$ChatEventInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? messageId = null,
  }) {
    return _then(_$ChatEventInfoImpl(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatEventInfoImpl implements _ChatEventInfo {
  const _$ChatEventInfoImpl(
      {@JsonKey(name: 'room_id') required this.roomId,
      @JsonKey(name: 'message_id') required this.messageId});

  factory _$ChatEventInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatEventInfoImplFromJson(json);

  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  @JsonKey(name: 'message_id')
  final String messageId;

  @override
  String toString() {
    return 'ChatEventInfo(roomId: $roomId, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatEventInfoImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, roomId, messageId);

  /// Create a copy of ChatEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatEventInfoImplCopyWith<_$ChatEventInfoImpl> get copyWith =>
      __$$ChatEventInfoImplCopyWithImpl<_$ChatEventInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatEventInfoImplToJson(
      this,
    );
  }
}

abstract class _ChatEventInfo implements ChatEventInfo {
  const factory _ChatEventInfo(
          {@JsonKey(name: 'room_id') required final String roomId,
          @JsonKey(name: 'message_id') required final String messageId}) =
      _$ChatEventInfoImpl;

  factory _ChatEventInfo.fromJson(Map<String, dynamic> json) =
      _$ChatEventInfoImpl.fromJson;

  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  @JsonKey(name: 'message_id')
  String get messageId;

  /// Create a copy of ChatEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatEventInfoImplCopyWith<_$ChatEventInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
