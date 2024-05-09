// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_address_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectAddressPageControllerHash() =>
    r'25b0d21912149dd57ae9d33da336590d4baf52a0';

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
  late final AddressModel? editAddressModel;

  SelectAddressPageControllerState build({
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
  SelectAddressPageControllerProvider call({
    AddressModel? editAddressModel,
  }) {
    return SelectAddressPageControllerProvider(
      editAddressModel: editAddressModel,
    );
  }

  @override
  SelectAddressPageControllerProvider getProviderOverride(
    covariant SelectAddressPageControllerProvider provider,
  ) {
    return call(
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
  SelectAddressPageControllerProvider({
    AddressModel? editAddressModel,
  }) : this._internal(
          () => SelectAddressPageController()
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
          editAddressModel: editAddressModel,
        );

  SelectAddressPageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.editAddressModel,
  }) : super.internal();

  final AddressModel? editAddressModel;

  @override
  SelectAddressPageControllerState runNotifierBuild(
    covariant SelectAddressPageController notifier,
  ) {
    return notifier.build(
      editAddressModel: editAddressModel,
    );
  }

  @override
  Override overrideWith(SelectAddressPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectAddressPageControllerProvider._internal(
        () => create()..editAddressModel = editAddressModel,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
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
        other.editAddressModel == editAddressModel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, editAddressModel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectAddressPageControllerRef
    on AutoDisposeNotifierProviderRef<SelectAddressPageControllerState> {
  /// The parameter `editAddressModel` of this provider.
  AddressModel? get editAddressModel;
}

class _SelectAddressPageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<SelectAddressPageController,
        SelectAddressPageControllerState> with SelectAddressPageControllerRef {
  _SelectAddressPageControllerProviderElement(super.provider);

  @override
  AddressModel? get editAddressModel =>
      (origin as SelectAddressPageControllerProvider).editAddressModel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
