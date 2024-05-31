// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatPageControllerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserModel remoteUser, List<Message> messages)
        data,
    required TResult Function(AppException error) error,
    required TResult Function() networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(UserModel remoteUser, List<Message> messages)? data,
    TResult? Function(AppException error)? error,
    TResult? Function()? networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserModel remoteUser, List<Message> messages)? data,
    TResult Function(AppException error)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatPageLoading value) loading,
    required TResult Function(ChatPageData value) data,
    required TResult Function(ChatPageError value) error,
    required TResult Function(ChatPageNetworkError value) networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatPageLoading value)? loading,
    TResult? Function(ChatPageData value)? data,
    TResult? Function(ChatPageError value)? error,
    TResult? Function(ChatPageNetworkError value)? networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatPageLoading value)? loading,
    TResult Function(ChatPageData value)? data,
    TResult Function(ChatPageError value)? error,
    TResult Function(ChatPageNetworkError value)? networkError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatPageControllerStateCopyWith<$Res> {
  factory $ChatPageControllerStateCopyWith(ChatPageControllerState value,
          $Res Function(ChatPageControllerState) then) =
      _$ChatPageControllerStateCopyWithImpl<$Res, ChatPageControllerState>;
}

/// @nodoc
class _$ChatPageControllerStateCopyWithImpl<$Res,
        $Val extends ChatPageControllerState>
    implements $ChatPageControllerStateCopyWith<$Res> {
  _$ChatPageControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatPageLoadingImplCopyWith<$Res> {
  factory _$$ChatPageLoadingImplCopyWith(_$ChatPageLoadingImpl value,
          $Res Function(_$ChatPageLoadingImpl) then) =
      __$$ChatPageLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatPageLoadingImplCopyWithImpl<$Res>
    extends _$ChatPageControllerStateCopyWithImpl<$Res, _$ChatPageLoadingImpl>
    implements _$$ChatPageLoadingImplCopyWith<$Res> {
  __$$ChatPageLoadingImplCopyWithImpl(
      _$ChatPageLoadingImpl _value, $Res Function(_$ChatPageLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatPageLoadingImpl extends ChatPageLoading {
  const _$ChatPageLoadingImpl() : super._();

  @override
  String toString() {
    return 'ChatPageControllerState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatPageLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserModel remoteUser, List<Message> messages)
        data,
    required TResult Function(AppException error) error,
    required TResult Function() networkError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(UserModel remoteUser, List<Message> messages)? data,
    TResult? Function(AppException error)? error,
    TResult? Function()? networkError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserModel remoteUser, List<Message> messages)? data,
    TResult Function(AppException error)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatPageLoading value) loading,
    required TResult Function(ChatPageData value) data,
    required TResult Function(ChatPageError value) error,
    required TResult Function(ChatPageNetworkError value) networkError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatPageLoading value)? loading,
    TResult? Function(ChatPageData value)? data,
    TResult? Function(ChatPageError value)? error,
    TResult? Function(ChatPageNetworkError value)? networkError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatPageLoading value)? loading,
    TResult Function(ChatPageData value)? data,
    TResult Function(ChatPageError value)? error,
    TResult Function(ChatPageNetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatPageLoading extends ChatPageControllerState {
  const factory ChatPageLoading() = _$ChatPageLoadingImpl;
  const ChatPageLoading._() : super._();
}

/// @nodoc
abstract class _$$ChatPageDataImplCopyWith<$Res> {
  factory _$$ChatPageDataImplCopyWith(
          _$ChatPageDataImpl value, $Res Function(_$ChatPageDataImpl) then) =
      __$$ChatPageDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel remoteUser, List<Message> messages});

  $UserModelCopyWith<$Res> get remoteUser;
}

/// @nodoc
class __$$ChatPageDataImplCopyWithImpl<$Res>
    extends _$ChatPageControllerStateCopyWithImpl<$Res, _$ChatPageDataImpl>
    implements _$$ChatPageDataImplCopyWith<$Res> {
  __$$ChatPageDataImplCopyWithImpl(
      _$ChatPageDataImpl _value, $Res Function(_$ChatPageDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remoteUser = null,
    Object? messages = null,
  }) {
    return _then(_$ChatPageDataImpl(
      remoteUser: null == remoteUser
          ? _value.remoteUser
          : remoteUser // ignore: cast_nullable_to_non_nullable
              as UserModel,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get remoteUser {
    return $UserModelCopyWith<$Res>(_value.remoteUser, (value) {
      return _then(_value.copyWith(remoteUser: value));
    });
  }
}

/// @nodoc

class _$ChatPageDataImpl extends ChatPageData {
  const _$ChatPageDataImpl(
      {required this.remoteUser, required final List<Message> messages})
      : _messages = messages,
        super._();

  @override
  final UserModel remoteUser;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'ChatPageControllerState.data(remoteUser: $remoteUser, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatPageDataImpl &&
            (identical(other.remoteUser, remoteUser) ||
                other.remoteUser == remoteUser) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, remoteUser, const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatPageDataImplCopyWith<_$ChatPageDataImpl> get copyWith =>
      __$$ChatPageDataImplCopyWithImpl<_$ChatPageDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserModel remoteUser, List<Message> messages)
        data,
    required TResult Function(AppException error) error,
    required TResult Function() networkError,
  }) {
    return data(remoteUser, messages);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(UserModel remoteUser, List<Message> messages)? data,
    TResult? Function(AppException error)? error,
    TResult? Function()? networkError,
  }) {
    return data?.call(remoteUser, messages);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserModel remoteUser, List<Message> messages)? data,
    TResult Function(AppException error)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(remoteUser, messages);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatPageLoading value) loading,
    required TResult Function(ChatPageData value) data,
    required TResult Function(ChatPageError value) error,
    required TResult Function(ChatPageNetworkError value) networkError,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatPageLoading value)? loading,
    TResult? Function(ChatPageData value)? data,
    TResult? Function(ChatPageError value)? error,
    TResult? Function(ChatPageNetworkError value)? networkError,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatPageLoading value)? loading,
    TResult Function(ChatPageData value)? data,
    TResult Function(ChatPageError value)? error,
    TResult Function(ChatPageNetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class ChatPageData extends ChatPageControllerState {
  const factory ChatPageData(
      {required final UserModel remoteUser,
      required final List<Message> messages}) = _$ChatPageDataImpl;
  const ChatPageData._() : super._();

  UserModel get remoteUser;
  List<Message> get messages;
  @JsonKey(ignore: true)
  _$$ChatPageDataImplCopyWith<_$ChatPageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatPageErrorImplCopyWith<$Res> {
  factory _$$ChatPageErrorImplCopyWith(
          _$ChatPageErrorImpl value, $Res Function(_$ChatPageErrorImpl) then) =
      __$$ChatPageErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException error});
}

/// @nodoc
class __$$ChatPageErrorImplCopyWithImpl<$Res>
    extends _$ChatPageControllerStateCopyWithImpl<$Res, _$ChatPageErrorImpl>
    implements _$$ChatPageErrorImplCopyWith<$Res> {
  __$$ChatPageErrorImplCopyWithImpl(
      _$ChatPageErrorImpl _value, $Res Function(_$ChatPageErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ChatPageErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$ChatPageErrorImpl extends ChatPageError {
  const _$ChatPageErrorImpl(this.error) : super._();

  @override
  final AppException error;

  @override
  String toString() {
    return 'ChatPageControllerState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatPageErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatPageErrorImplCopyWith<_$ChatPageErrorImpl> get copyWith =>
      __$$ChatPageErrorImplCopyWithImpl<_$ChatPageErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserModel remoteUser, List<Message> messages)
        data,
    required TResult Function(AppException error) error,
    required TResult Function() networkError,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(UserModel remoteUser, List<Message> messages)? data,
    TResult? Function(AppException error)? error,
    TResult? Function()? networkError,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserModel remoteUser, List<Message> messages)? data,
    TResult Function(AppException error)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatPageLoading value) loading,
    required TResult Function(ChatPageData value) data,
    required TResult Function(ChatPageError value) error,
    required TResult Function(ChatPageNetworkError value) networkError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatPageLoading value)? loading,
    TResult? Function(ChatPageData value)? data,
    TResult? Function(ChatPageError value)? error,
    TResult? Function(ChatPageNetworkError value)? networkError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatPageLoading value)? loading,
    TResult Function(ChatPageData value)? data,
    TResult Function(ChatPageError value)? error,
    TResult Function(ChatPageNetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatPageError extends ChatPageControllerState {
  const factory ChatPageError(final AppException error) = _$ChatPageErrorImpl;
  const ChatPageError._() : super._();

  AppException get error;
  @JsonKey(ignore: true)
  _$$ChatPageErrorImplCopyWith<_$ChatPageErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatPageNetworkErrorImplCopyWith<$Res> {
  factory _$$ChatPageNetworkErrorImplCopyWith(_$ChatPageNetworkErrorImpl value,
          $Res Function(_$ChatPageNetworkErrorImpl) then) =
      __$$ChatPageNetworkErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatPageNetworkErrorImplCopyWithImpl<$Res>
    extends _$ChatPageControllerStateCopyWithImpl<$Res,
        _$ChatPageNetworkErrorImpl>
    implements _$$ChatPageNetworkErrorImplCopyWith<$Res> {
  __$$ChatPageNetworkErrorImplCopyWithImpl(_$ChatPageNetworkErrorImpl _value,
      $Res Function(_$ChatPageNetworkErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatPageNetworkErrorImpl extends ChatPageNetworkError {
  const _$ChatPageNetworkErrorImpl() : super._();

  @override
  String toString() {
    return 'ChatPageControllerState.networkError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatPageNetworkErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserModel remoteUser, List<Message> messages)
        data,
    required TResult Function(AppException error) error,
    required TResult Function() networkError,
  }) {
    return networkError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(UserModel remoteUser, List<Message> messages)? data,
    TResult? Function(AppException error)? error,
    TResult? Function()? networkError,
  }) {
    return networkError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserModel remoteUser, List<Message> messages)? data,
    TResult Function(AppException error)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatPageLoading value) loading,
    required TResult Function(ChatPageData value) data,
    required TResult Function(ChatPageError value) error,
    required TResult Function(ChatPageNetworkError value) networkError,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatPageLoading value)? loading,
    TResult? Function(ChatPageData value)? data,
    TResult? Function(ChatPageError value)? error,
    TResult? Function(ChatPageNetworkError value)? networkError,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatPageLoading value)? loading,
    TResult Function(ChatPageData value)? data,
    TResult Function(ChatPageError value)? error,
    TResult Function(ChatPageNetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class ChatPageNetworkError extends ChatPageControllerState {
  const factory ChatPageNetworkError() = _$ChatPageNetworkErrorImpl;
  const ChatPageNetworkError._() : super._();
}
