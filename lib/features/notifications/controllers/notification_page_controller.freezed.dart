// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotificationPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<NotificationModel> models) data,
    required TResult Function(AppException error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<NotificationModel> models)? data,
    TResult? Function(AppException error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<NotificationModel> models)? data,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationPageLoadingState value) loading,
    required TResult Function(NotificationPageDataState value) data,
    required TResult Function(NotificationPageErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationPageLoadingState value)? loading,
    TResult? Function(NotificationPageDataState value)? data,
    TResult? Function(NotificationPageErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationPageLoadingState value)? loading,
    TResult Function(NotificationPageDataState value)? data,
    TResult Function(NotificationPageErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPageStateCopyWith<$Res> {
  factory $NotificationPageStateCopyWith(NotificationPageState value,
          $Res Function(NotificationPageState) then) =
      _$NotificationPageStateCopyWithImpl<$Res, NotificationPageState>;
}

/// @nodoc
class _$NotificationPageStateCopyWithImpl<$Res,
        $Val extends NotificationPageState>
    implements $NotificationPageStateCopyWith<$Res> {
  _$NotificationPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotificationPageLoadingStateImplCopyWith<$Res> {
  factory _$$NotificationPageLoadingStateImplCopyWith(
          _$NotificationPageLoadingStateImpl value,
          $Res Function(_$NotificationPageLoadingStateImpl) then) =
      __$$NotificationPageLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationPageLoadingStateImplCopyWithImpl<$Res>
    extends _$NotificationPageStateCopyWithImpl<$Res,
        _$NotificationPageLoadingStateImpl>
    implements _$$NotificationPageLoadingStateImplCopyWith<$Res> {
  __$$NotificationPageLoadingStateImplCopyWithImpl(
      _$NotificationPageLoadingStateImpl _value,
      $Res Function(_$NotificationPageLoadingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationPageLoadingStateImpl extends NotificationPageLoadingState {
  const _$NotificationPageLoadingStateImpl() : super._();

  @override
  String toString() {
    return 'NotificationPageState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPageLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<NotificationModel> models) data,
    required TResult Function(AppException error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<NotificationModel> models)? data,
    TResult? Function(AppException error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<NotificationModel> models)? data,
    TResult Function(AppException error)? error,
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
    required TResult Function(NotificationPageLoadingState value) loading,
    required TResult Function(NotificationPageDataState value) data,
    required TResult Function(NotificationPageErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationPageLoadingState value)? loading,
    TResult? Function(NotificationPageDataState value)? data,
    TResult? Function(NotificationPageErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationPageLoadingState value)? loading,
    TResult Function(NotificationPageDataState value)? data,
    TResult Function(NotificationPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NotificationPageLoadingState extends NotificationPageState {
  const factory NotificationPageLoadingState() =
      _$NotificationPageLoadingStateImpl;
  const NotificationPageLoadingState._() : super._();
}

/// @nodoc
abstract class _$$NotificationPageDataStateImplCopyWith<$Res> {
  factory _$$NotificationPageDataStateImplCopyWith(
          _$NotificationPageDataStateImpl value,
          $Res Function(_$NotificationPageDataStateImpl) then) =
      __$$NotificationPageDataStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<NotificationModel> models});
}

/// @nodoc
class __$$NotificationPageDataStateImplCopyWithImpl<$Res>
    extends _$NotificationPageStateCopyWithImpl<$Res,
        _$NotificationPageDataStateImpl>
    implements _$$NotificationPageDataStateImplCopyWith<$Res> {
  __$$NotificationPageDataStateImplCopyWithImpl(
      _$NotificationPageDataStateImpl _value,
      $Res Function(_$NotificationPageDataStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = null,
  }) {
    return _then(_$NotificationPageDataStateImpl(
      null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
    ));
  }
}

/// @nodoc

class _$NotificationPageDataStateImpl extends NotificationPageDataState {
  const _$NotificationPageDataStateImpl(final List<NotificationModel> models)
      : _models = models,
        super._();

  final List<NotificationModel> _models;
  @override
  List<NotificationModel> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  @override
  String toString() {
    return 'NotificationPageState.data(models: $models)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPageDataStateImpl &&
            const DeepCollectionEquality().equals(other._models, _models));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_models));

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPageDataStateImplCopyWith<_$NotificationPageDataStateImpl>
      get copyWith => __$$NotificationPageDataStateImplCopyWithImpl<
          _$NotificationPageDataStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<NotificationModel> models) data,
    required TResult Function(AppException error) error,
  }) {
    return data(models);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<NotificationModel> models)? data,
    TResult? Function(AppException error)? error,
  }) {
    return data?.call(models);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<NotificationModel> models)? data,
    TResult Function(AppException error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(models);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationPageLoadingState value) loading,
    required TResult Function(NotificationPageDataState value) data,
    required TResult Function(NotificationPageErrorState value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationPageLoadingState value)? loading,
    TResult? Function(NotificationPageDataState value)? data,
    TResult? Function(NotificationPageErrorState value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationPageLoadingState value)? loading,
    TResult Function(NotificationPageDataState value)? data,
    TResult Function(NotificationPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class NotificationPageDataState extends NotificationPageState {
  const factory NotificationPageDataState(
      final List<NotificationModel> models) = _$NotificationPageDataStateImpl;
  const NotificationPageDataState._() : super._();

  List<NotificationModel> get models;

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPageDataStateImplCopyWith<_$NotificationPageDataStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotificationPageErrorStateImplCopyWith<$Res> {
  factory _$$NotificationPageErrorStateImplCopyWith(
          _$NotificationPageErrorStateImpl value,
          $Res Function(_$NotificationPageErrorStateImpl) then) =
      __$$NotificationPageErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppException error});
}

/// @nodoc
class __$$NotificationPageErrorStateImplCopyWithImpl<$Res>
    extends _$NotificationPageStateCopyWithImpl<$Res,
        _$NotificationPageErrorStateImpl>
    implements _$$NotificationPageErrorStateImplCopyWith<$Res> {
  __$$NotificationPageErrorStateImplCopyWithImpl(
      _$NotificationPageErrorStateImpl _value,
      $Res Function(_$NotificationPageErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$NotificationPageErrorStateImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AppException,
    ));
  }
}

/// @nodoc

class _$NotificationPageErrorStateImpl extends NotificationPageErrorState {
  const _$NotificationPageErrorStateImpl(this.error) : super._();

  @override
  final AppException error;

  @override
  String toString() {
    return 'NotificationPageState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPageErrorStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPageErrorStateImplCopyWith<_$NotificationPageErrorStateImpl>
      get copyWith => __$$NotificationPageErrorStateImplCopyWithImpl<
          _$NotificationPageErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<NotificationModel> models) data,
    required TResult Function(AppException error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<NotificationModel> models)? data,
    TResult? Function(AppException error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<NotificationModel> models)? data,
    TResult Function(AppException error)? error,
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
    required TResult Function(NotificationPageLoadingState value) loading,
    required TResult Function(NotificationPageDataState value) data,
    required TResult Function(NotificationPageErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationPageLoadingState value)? loading,
    TResult? Function(NotificationPageDataState value)? data,
    TResult? Function(NotificationPageErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationPageLoadingState value)? loading,
    TResult Function(NotificationPageDataState value)? data,
    TResult Function(NotificationPageErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NotificationPageErrorState extends NotificationPageState {
  const factory NotificationPageErrorState(final AppException error) =
      _$NotificationPageErrorStateImpl;
  const NotificationPageErrorState._() : super._();

  AppException get error;

  /// Create a copy of NotificationPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPageErrorStateImplCopyWith<_$NotificationPageErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
