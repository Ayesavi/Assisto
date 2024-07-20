// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatRoomModel _$ChatRoomModelFromJson(Map<String, dynamic> json) {
  return _ChatRoomModel.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomModel {
  ChatRoomMessage get message => throw _privateConstructorUsedError;
  ChatRoomAuthorModel get author => throw _privateConstructorUsedError;
  ChatRoomTaskModel get task => throw _privateConstructorUsedError;
  @JsonKey(name: "chat_id")
  int get chatId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomModelCopyWith<ChatRoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomModelCopyWith<$Res> {
  factory $ChatRoomModelCopyWith(
          ChatRoomModel value, $Res Function(ChatRoomModel) then) =
      _$ChatRoomModelCopyWithImpl<$Res, ChatRoomModel>;
  @useResult
  $Res call(
      {ChatRoomMessage message,
      ChatRoomAuthorModel author,
      ChatRoomTaskModel task,
      @JsonKey(name: "chat_id") int chatId});

  $ChatRoomMessageCopyWith<$Res> get message;
  $ChatRoomAuthorModelCopyWith<$Res> get author;
  $ChatRoomTaskModelCopyWith<$Res> get task;
}

/// @nodoc
class _$ChatRoomModelCopyWithImpl<$Res, $Val extends ChatRoomModel>
    implements $ChatRoomModelCopyWith<$Res> {
  _$ChatRoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? author = null,
    Object? task = null,
    Object? chatId = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessage,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ChatRoomAuthorModel,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as ChatRoomTaskModel,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatRoomMessageCopyWith<$Res> get message {
    return $ChatRoomMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatRoomAuthorModelCopyWith<$Res> get author {
    return $ChatRoomAuthorModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatRoomTaskModelCopyWith<$Res> get task {
    return $ChatRoomTaskModelCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatRoomModelImplCopyWith<$Res>
    implements $ChatRoomModelCopyWith<$Res> {
  factory _$$ChatRoomModelImplCopyWith(
          _$ChatRoomModelImpl value, $Res Function(_$ChatRoomModelImpl) then) =
      __$$ChatRoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ChatRoomMessage message,
      ChatRoomAuthorModel author,
      ChatRoomTaskModel task,
      @JsonKey(name: "chat_id") int chatId});

  @override
  $ChatRoomMessageCopyWith<$Res> get message;
  @override
  $ChatRoomAuthorModelCopyWith<$Res> get author;
  @override
  $ChatRoomTaskModelCopyWith<$Res> get task;
}

/// @nodoc
class __$$ChatRoomModelImplCopyWithImpl<$Res>
    extends _$ChatRoomModelCopyWithImpl<$Res, _$ChatRoomModelImpl>
    implements _$$ChatRoomModelImplCopyWith<$Res> {
  __$$ChatRoomModelImplCopyWithImpl(
      _$ChatRoomModelImpl _value, $Res Function(_$ChatRoomModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? author = null,
    Object? task = null,
    Object? chatId = null,
  }) {
    return _then(_$ChatRoomModelImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatRoomMessage,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ChatRoomAuthorModel,
      task: null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as ChatRoomTaskModel,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomModelImpl implements _ChatRoomModel {
  const _$ChatRoomModelImpl(
      {required this.message,
      required this.author,
      required this.task,
      @JsonKey(name: "chat_id") required this.chatId});

  factory _$ChatRoomModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomModelImplFromJson(json);

  @override
  final ChatRoomMessage message;
  @override
  final ChatRoomAuthorModel author;
  @override
  final ChatRoomTaskModel task;
  @override
  @JsonKey(name: "chat_id")
  final int chatId;

  @override
  String toString() {
    return 'ChatRoomModel(message: $message, author: $author, task: $task, chatId: $chatId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.chatId, chatId) || other.chatId == chatId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, author, task, chatId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomModelImplCopyWith<_$ChatRoomModelImpl> get copyWith =>
      __$$ChatRoomModelImplCopyWithImpl<_$ChatRoomModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomModelImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomModel implements ChatRoomModel {
  const factory _ChatRoomModel(
          {required final ChatRoomMessage message,
          required final ChatRoomAuthorModel author,
          required final ChatRoomTaskModel task,
          @JsonKey(name: "chat_id") required final int chatId}) =
      _$ChatRoomModelImpl;

  factory _ChatRoomModel.fromJson(Map<String, dynamic> json) =
      _$ChatRoomModelImpl.fromJson;

  @override
  ChatRoomMessage get message;
  @override
  ChatRoomAuthorModel get author;
  @override
  ChatRoomTaskModel get task;
  @override
  @JsonKey(name: "chat_id")
  int get chatId;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomModelImplCopyWith<_$ChatRoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoomMessage _$ChatRoomMessageFromJson(Map<String, dynamic> json) {
  return _ChatRoomMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomMessage {
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomMessageCopyWith<ChatRoomMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomMessageCopyWith<$Res> {
  factory $ChatRoomMessageCopyWith(
          ChatRoomMessage value, $Res Function(ChatRoomMessage) then) =
      _$ChatRoomMessageCopyWithImpl<$Res, ChatRoomMessage>;
  @useResult
  $Res call({String text, @JsonKey(name: "created_at") DateTime createdAt});
}

/// @nodoc
class _$ChatRoomMessageCopyWithImpl<$Res, $Val extends ChatRoomMessage>
    implements $ChatRoomMessageCopyWith<$Res> {
  _$ChatRoomMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomMessageImplCopyWith<$Res>
    implements $ChatRoomMessageCopyWith<$Res> {
  factory _$$ChatRoomMessageImplCopyWith(_$ChatRoomMessageImpl value,
          $Res Function(_$ChatRoomMessageImpl) then) =
      __$$ChatRoomMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, @JsonKey(name: "created_at") DateTime createdAt});
}

/// @nodoc
class __$$ChatRoomMessageImplCopyWithImpl<$Res>
    extends _$ChatRoomMessageCopyWithImpl<$Res, _$ChatRoomMessageImpl>
    implements _$$ChatRoomMessageImplCopyWith<$Res> {
  __$$ChatRoomMessageImplCopyWithImpl(
      _$ChatRoomMessageImpl _value, $Res Function(_$ChatRoomMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? createdAt = null,
  }) {
    return _then(_$ChatRoomMessageImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomMessageImpl implements _ChatRoomMessage {
  const _$ChatRoomMessageImpl(
      {required this.text,
      @JsonKey(name: "created_at") required this.createdAt});

  factory _$ChatRoomMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomMessageImplFromJson(json);

  @override
  final String text;
  @override
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChatRoomMessage(text: $text, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomMessageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomMessageImplCopyWith<_$ChatRoomMessageImpl> get copyWith =>
      __$$ChatRoomMessageImplCopyWithImpl<_$ChatRoomMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomMessage implements ChatRoomMessage {
  const factory _ChatRoomMessage(
          {required final String text,
          @JsonKey(name: "created_at") required final DateTime createdAt}) =
      _$ChatRoomMessageImpl;

  factory _ChatRoomMessage.fromJson(Map<String, dynamic> json) =
      _$ChatRoomMessageImpl.fromJson;

  @override
  String get text;
  @override
  @JsonKey(name: "created_at")
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomMessageImplCopyWith<_$ChatRoomMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoomAuthorModel _$ChatRoomAuthorModelFromJson(Map<String, dynamic> json) {
  return _ChatRoomAuthorModel.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomAuthorModel {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "avatar_url")
  String get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomAuthorModelCopyWith<ChatRoomAuthorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomAuthorModelCopyWith<$Res> {
  factory $ChatRoomAuthorModelCopyWith(
          ChatRoomAuthorModel value, $Res Function(ChatRoomAuthorModel) then) =
      _$ChatRoomAuthorModelCopyWithImpl<$Res, ChatRoomAuthorModel>;
  @useResult
  $Res call({String name, @JsonKey(name: "avatar_url") String avatarUrl});
}

/// @nodoc
class _$ChatRoomAuthorModelCopyWithImpl<$Res, $Val extends ChatRoomAuthorModel>
    implements $ChatRoomAuthorModelCopyWith<$Res> {
  _$ChatRoomAuthorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomAuthorModelImplCopyWith<$Res>
    implements $ChatRoomAuthorModelCopyWith<$Res> {
  factory _$$ChatRoomAuthorModelImplCopyWith(_$ChatRoomAuthorModelImpl value,
          $Res Function(_$ChatRoomAuthorModelImpl) then) =
      __$$ChatRoomAuthorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, @JsonKey(name: "avatar_url") String avatarUrl});
}

/// @nodoc
class __$$ChatRoomAuthorModelImplCopyWithImpl<$Res>
    extends _$ChatRoomAuthorModelCopyWithImpl<$Res, _$ChatRoomAuthorModelImpl>
    implements _$$ChatRoomAuthorModelImplCopyWith<$Res> {
  __$$ChatRoomAuthorModelImplCopyWithImpl(_$ChatRoomAuthorModelImpl _value,
      $Res Function(_$ChatRoomAuthorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? avatarUrl = null,
  }) {
    return _then(_$ChatRoomAuthorModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$ChatRoomAuthorModelImpl implements _ChatRoomAuthorModel {
  const _$ChatRoomAuthorModelImpl(
      {required this.name,
      @JsonKey(name: "avatar_url") required this.avatarUrl});

  factory _$ChatRoomAuthorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomAuthorModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey(name: "avatar_url")
  final String avatarUrl;

  @override
  String toString() {
    return 'ChatRoomAuthorModel(name: $name, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomAuthorModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomAuthorModelImplCopyWith<_$ChatRoomAuthorModelImpl> get copyWith =>
      __$$ChatRoomAuthorModelImplCopyWithImpl<_$ChatRoomAuthorModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomAuthorModelImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomAuthorModel implements ChatRoomAuthorModel {
  const factory _ChatRoomAuthorModel(
          {required final String name,
          @JsonKey(name: "avatar_url") required final String avatarUrl}) =
      _$ChatRoomAuthorModelImpl;

  factory _ChatRoomAuthorModel.fromJson(Map<String, dynamic> json) =
      _$ChatRoomAuthorModelImpl.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: "avatar_url")
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomAuthorModelImplCopyWith<_$ChatRoomAuthorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatRoomTaskModel _$ChatRoomTaskModelFromJson(Map<String, dynamic> json) {
  return _ChatRoomTaskModel.fromJson(json);
}

/// @nodoc
mixin _$ChatRoomTaskModel {
  String get name => throw _privateConstructorUsedError;
  TaskStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomTaskModelCopyWith<ChatRoomTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomTaskModelCopyWith<$Res> {
  factory $ChatRoomTaskModelCopyWith(
          ChatRoomTaskModel value, $Res Function(ChatRoomTaskModel) then) =
      _$ChatRoomTaskModelCopyWithImpl<$Res, ChatRoomTaskModel>;
  @useResult
  $Res call({String name, TaskStatus status});
}

/// @nodoc
class _$ChatRoomTaskModelCopyWithImpl<$Res, $Val extends ChatRoomTaskModel>
    implements $ChatRoomTaskModelCopyWith<$Res> {
  _$ChatRoomTaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatRoomTaskModelImplCopyWith<$Res>
    implements $ChatRoomTaskModelCopyWith<$Res> {
  factory _$$ChatRoomTaskModelImplCopyWith(_$ChatRoomTaskModelImpl value,
          $Res Function(_$ChatRoomTaskModelImpl) then) =
      __$$ChatRoomTaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, TaskStatus status});
}

/// @nodoc
class __$$ChatRoomTaskModelImplCopyWithImpl<$Res>
    extends _$ChatRoomTaskModelCopyWithImpl<$Res, _$ChatRoomTaskModelImpl>
    implements _$$ChatRoomTaskModelImplCopyWith<$Res> {
  __$$ChatRoomTaskModelImplCopyWithImpl(_$ChatRoomTaskModelImpl _value,
      $Res Function(_$ChatRoomTaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
  }) {
    return _then(_$ChatRoomTaskModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatRoomTaskModelImpl implements _ChatRoomTaskModel {
  const _$ChatRoomTaskModelImpl({required this.name, required this.status});

  factory _$ChatRoomTaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomTaskModelImplFromJson(json);

  @override
  final String name;
  @override
  final TaskStatus status;

  @override
  String toString() {
    return 'ChatRoomTaskModel(name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomTaskModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomTaskModelImplCopyWith<_$ChatRoomTaskModelImpl> get copyWith =>
      __$$ChatRoomTaskModelImplCopyWithImpl<_$ChatRoomTaskModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomTaskModelImplToJson(
      this,
    );
  }
}

abstract class _ChatRoomTaskModel implements ChatRoomTaskModel {
  const factory _ChatRoomTaskModel(
      {required final String name,
      required final TaskStatus status}) = _$ChatRoomTaskModelImpl;

  factory _ChatRoomTaskModel.fromJson(Map<String, dynamic> json) =
      _$ChatRoomTaskModelImpl.fromJson;

  @override
  String get name;
  @override
  TaskStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$ChatRoomTaskModelImplCopyWith<_$ChatRoomTaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
