/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsGraphicsGen {
  const $AssetsGraphicsGen();

  /// File path: assets/graphics/empty_addresses.svg
  String get emptyAddresses => 'assets/graphics/empty_addresses.svg';

  /// File path: assets/graphics/empty_list.svg
  String get emptyList => 'assets/graphics/empty_list.svg';

  /// File path: assets/graphics/error.svg
  String get error => 'assets/graphics/error.svg';

  /// File path: assets/graphics/login_welcome.svg
  String get loginWelcome => 'assets/graphics/login_welcome.svg';

  /// File path: assets/graphics/magic_ai.png
  AssetGenImage get magicAi =>
      const AssetGenImage('assets/graphics/magic_ai.png');

  /// File path: assets/graphics/no_offers.svg
  String get noOffers => 'assets/graphics/no_offers.svg';

  /// File path: assets/graphics/server_down.svg
  String get serverDown => 'assets/graphics/server_down.svg';

  /// File path: assets/graphics/success_check_mark.svg
  String get successCheckMark => 'assets/graphics/success_check_mark.svg';

  /// List of all assets
  List<dynamic> get values => [
        emptyAddresses,
        emptyList,
        error,
        loginWelcome,
        magicAi,
        noOffers,
        serverDown,
        successCheckMark
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  /// List of all assets
  List<AssetGenImage> get values => [icLauncher];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/app_under_maintainence.json
  String get appUnderMaintainence =>
      'assets/lottie/app_under_maintainence.json';

  /// List of all assets
  List<String> get values => [appUnderMaintainence];
}

class Assets {
  Assets._();

  static const String aEnv = '.env.dev';
  static const String prod = '.env.prod';
  static const $AssetsGraphicsGen graphics = $AssetsGraphicsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const String mapStyle = 'assets/map_style.json';

  /// List of all assets
  static List<String> get values => [aEnv, prod, mapStyle];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
