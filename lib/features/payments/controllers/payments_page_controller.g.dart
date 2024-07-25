// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentsPageControllerHash() =>
    r'7ed06186e3fcbf6feb7f3f9595cc0d38624e6110';

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

abstract class _$PaymentsPageController
    extends BuildlessAutoDisposeNotifier<PaymentsPageControllerState> {
  late final String? recipientId;

  PaymentsPageControllerState build(
    String? recipientId,
  );
}

/// See also [PaymentsPageController].
@ProviderFor(PaymentsPageController)
const paymentsPageControllerProvider = PaymentsPageControllerFamily();

/// See also [PaymentsPageController].
class PaymentsPageControllerFamily extends Family<PaymentsPageControllerState> {
  /// See also [PaymentsPageController].
  const PaymentsPageControllerFamily();

  /// See also [PaymentsPageController].
  PaymentsPageControllerProvider call(
    String? recipientId,
  ) {
    return PaymentsPageControllerProvider(
      recipientId,
    );
  }

  @override
  PaymentsPageControllerProvider getProviderOverride(
    covariant PaymentsPageControllerProvider provider,
  ) {
    return call(
      provider.recipientId,
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
  String? get name => r'paymentsPageControllerProvider';
}

/// See also [PaymentsPageController].
class PaymentsPageControllerProvider extends AutoDisposeNotifierProviderImpl<
    PaymentsPageController, PaymentsPageControllerState> {
  /// See also [PaymentsPageController].
  PaymentsPageControllerProvider(
    String? recipientId,
  ) : this._internal(
          () => PaymentsPageController()..recipientId = recipientId,
          from: paymentsPageControllerProvider,
          name: r'paymentsPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paymentsPageControllerHash,
          dependencies: PaymentsPageControllerFamily._dependencies,
          allTransitiveDependencies:
              PaymentsPageControllerFamily._allTransitiveDependencies,
          recipientId: recipientId,
        );

  PaymentsPageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.recipientId,
  }) : super.internal();

  final String? recipientId;

  @override
  PaymentsPageControllerState runNotifierBuild(
    covariant PaymentsPageController notifier,
  ) {
    return notifier.build(
      recipientId,
    );
  }

  @override
  Override overrideWith(PaymentsPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PaymentsPageControllerProvider._internal(
        () => create()..recipientId = recipientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        recipientId: recipientId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<PaymentsPageController,
      PaymentsPageControllerState> createElement() {
    return _PaymentsPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentsPageControllerProvider &&
        other.recipientId == recipientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, recipientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PaymentsPageControllerRef
    on AutoDisposeNotifierProviderRef<PaymentsPageControllerState> {
  /// The parameter `recipientId` of this provider.
  String? get recipientId;
}

class _PaymentsPageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<PaymentsPageController,
        PaymentsPageControllerState> with PaymentsPageControllerRef {
  _PaymentsPageControllerProviderElement(super.provider);

  @override
  String? get recipientId =>
      (origin as PaymentsPageControllerProvider).recipientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
