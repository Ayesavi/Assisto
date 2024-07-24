// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatPageControllerHash() =>
    r'8712e8ce6372d19a8163c34a4736a2b5e811cc38';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChatPageController
    extends BuildlessAutoDisposeNotifier<ChatPageControllerState> {
  late final int roomId;

  ChatPageControllerState build(
    int roomId,
  );
}

/// See also [ChatPageController].
@ProviderFor(ChatPageController)
const chatPageControllerProvider = ChatPageControllerFamily();

/// See also [ChatPageController].
class ChatPageControllerFamily extends Family<ChatPageControllerState> {
  /// See also [ChatPageController].
  const ChatPageControllerFamily();

  /// See also [ChatPageController].
  ChatPageControllerProvider call(
    int roomId,
  ) {
    return ChatPageControllerProvider(
      roomId,
    );
  }

  @override
  ChatPageControllerProvider getProviderOverride(
    covariant ChatPageControllerProvider provider,
  ) {
    return call(
      provider.roomId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatPageControllerProvider';
}

/// See also [ChatPageController].
class ChatPageControllerProvider extends AutoDisposeNotifierProviderImpl<
    ChatPageController, ChatPageControllerState> {
  /// See also [ChatPageController].
  ChatPageControllerProvider(
    int roomId,
  ) : this._internal(
          () => ChatPageController()..roomId = roomId,
          from: chatPageControllerProvider,
          name: r'chatPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatPageControllerHash,
          dependencies: ChatPageControllerFamily._dependencies,
          allTransitiveDependencies:
              ChatPageControllerFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  ChatPageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final int roomId;

  @override
  ChatPageControllerState runNotifierBuild(
    covariant ChatPageController notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(ChatPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatPageControllerProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ChatPageController,
      ChatPageControllerState> createElement() {
    return _ChatPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatPageControllerProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatPageControllerRef
    on AutoDisposeNotifierProviderRef<ChatPageControllerState> {
  /// The parameter `roomId` of this provider.
  int get roomId;
}

class _ChatPageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ChatPageController,
        ChatPageControllerState> with ChatPageControllerRef {
  _ChatPageControllerProviderElement(super.provider);

  @override
  int get roomId => (origin as ChatPageControllerProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
