// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_address_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectAddressPageControllerHash() =>
    r'13d82284736129c102adcbe20fd4cf59121b8eb5';

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

abstract class _$SelectAddressPageController
    extends BuildlessAutoDisposeNotifier<SelectAddressPageControllerState> {
  late final BuildContext context;
  late final AddressModel? editAddressModel;

  SelectAddressPageControllerState build(
    BuildContext context, {
    AddressModel? editAddressModel,
  });
}

/// See also [SelectAddressPageController].
@ProviderFor(SelectAddressPageController)
const selectAddressPageControllerProvider = SelectAddressPageControllerFamily();

/// See also [SelectAddressPageController].
class SelectAddressPageControllerFamily
    extends Family<SelectAddressPageControllerState> {
  /// See also [SelectAddressPageController].
  const SelectAddressPageControllerFamily();

  /// See also [SelectAddressPageController].
  SelectAddressPageControllerProvider call(
    BuildContext context, {
    AddressModel? editAddressModel,
  }) {
    return SelectAddressPageControllerProvider(
      context,
      editAddressModel: editAddressModel,
    );
  }

  @override
  SelectAddressPageControllerProvider getProviderOverride(
    covariant SelectAddressPageControllerProvider provider,
  ) {
    return call(
      provider.context,
      editAddressModel: provider.editAddressModel,
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
  String? get name => r'selectAddressPageControllerProvider';
}

/// See also [SelectAddressPageController].
class SelectAddressPageControllerProvider
    extends AutoDisposeNotifierProviderImpl<SelectAddressPageController,
        SelectAddressPageControllerState> {
  /// See also [SelectAddressPageController].
  SelectAddressPageControllerProvider(
    BuildContext context, {
    AddressModel? editAddressModel,
  }) : this._internal(
          () => SelectAddressPageController()
            ..context = context
            ..editAddressModel = editAddressModel,
          from: selectAddressPageControllerProvider,
          name: r'selectAddressPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectAddressPageControllerHash,
          dependencies: SelectAddressPageControllerFamily._dependencies,
          allTransitiveDependencies:
              SelectAddressPageControllerFamily._allTransitiveDependencies,
          context: context,
          editAddressModel: editAddressModel,
        );

  SelectAddressPageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.editAddressModel,
  }) : super.internal();

  final BuildContext context;
  final AddressModel? editAddressModel;

  @override
  SelectAddressPageControllerState runNotifierBuild(
    covariant SelectAddressPageController notifier,
  ) {
    return notifier.build(
      context,
      editAddressModel: editAddressModel,
    );
  }

  @override
  Override overrideWith(SelectAddressPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectAddressPageControllerProvider._internal(
        () => create()
          ..context = context
          ..editAddressModel = editAddressModel,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        editAddressModel: editAddressModel,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectAddressPageController,
      SelectAddressPageControllerState> createElement() {
    return _SelectAddressPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectAddressPageControllerProvider &&
        other.context == context &&
        other.editAddressModel == editAddressModel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, editAddressModel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectAddressPageControllerRef
    on AutoDisposeNotifierProviderRef<SelectAddressPageControllerState> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `editAddressModel` of this provider.
  AddressModel? get editAddressModel;
}

class _SelectAddressPageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<SelectAddressPageController,
        SelectAddressPageControllerState> with SelectAddressPageControllerRef {
  _SelectAddressPageControllerProviderElement(super.provider);

  @override
  BuildContext get context =>
      (origin as SelectAddressPageControllerProvider).context;
  @override
  AddressModel? get editAddressModel =>
      (origin as SelectAddressPageControllerProvider).editAddressModel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
