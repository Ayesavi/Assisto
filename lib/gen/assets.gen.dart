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

  /// File path: assets/graphics/no_chats.svg
  String get noChats => 'assets/graphics/no_chats.svg';

  /// File path: assets/graphics/no_offers.svg
  String get noOffers => 'assets/graphics/no_offers.svg';

  /// File path: assets/graphics/search.svg
  String get search => 'assets/graphics/search.svg';

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
        noChats,
        noOffers,
        search,
        serverDown,
        successCheckMark
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ai.png
  AssetGenImage get ai => const AssetGenImage('assets/images/ai.png');

  /// File path: assets/images/chat_dark.png
  AssetGenImage get chatDark =>
      const AssetGenImage('assets/images/chat_dark.png');

  /// File path: assets/images/chat_light.png
  AssetGenImage get chatLight =>
      const AssetGenImage('assets/images/chat_light.png');

  /// File path: assets/images/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/images/ic_launcher.png');

  /// List of all assets
  List<AssetGenImage> get values => [ai, chatDark, chatLight, icLauncher];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/app_requires_update.json
  String get appRequiresUpdate => 'assets/lottie/app_requires_update.json';

  /// File path: assets/lottie/app_under_maintainence.json
  String get appUnderMaintainence =>
      'assets/lottie/app_under_maintainence.json';

  /// File path: assets/lottie/error_lottie.json
  String get errorLottie => 'assets/lottie/error_lottie.json';

  /// File path: assets/lottie/searching.json
  String get searching => 'assets/lottie/searching.json';

  /// List of all assets
  List<String> get values =>
      [appRequiresUpdate, appUnderMaintainence, errorLottie, searching];
}

class Assets {
  Assets._();

  static const $AssetsGraphicsGen graphics = $AssetsGraphicsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const String mapStyleDark = 'assets/map_style_dark.json';
  static const String mapStyleLight = 'assets/map_style_light.json';

  /// List of all assets
  static List<String> get values => [mapStyleDark, mapStyleLight];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
