/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/checkmark.json
  String get checkmark => 'assets/animations/checkmark.json';

  /// File path: assets/animations/checkmark_icon.riv
  String get checkmarkIcon => 'assets/animations/checkmark_icon.riv';

  /// List of all assets
  List<String> get values => [checkmark, checkmarkIcon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/png
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();

  /// Directory path: assets/images/svg
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/Saly-1.png
  AssetGenImage get saly1 =>
      const AssetGenImage('assets/images/png/Saly-1.png');

  /// File path: assets/images/png/Saly-2.png
  AssetGenImage get saly2 =>
      const AssetGenImage('assets/images/png/Saly-2.png');

  /// File path: assets/images/png/character_meditating.png
  AssetGenImage get characterMeditating =>
      const AssetGenImage('assets/images/png/character_meditating.png');

  /// File path: assets/images/png/character_question_mark.png
  AssetGenImage get characterQuestionMark =>
      const AssetGenImage('assets/images/png/character_question_mark.png');

  /// File path: assets/images/png/character_thinking.png
  AssetGenImage get characterThinking =>
      const AssetGenImage('assets/images/png/character_thinking.png');

  /// File path: assets/images/png/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/png/logo.png');

  /// File path: assets/images/png/online_shopping.png
  AssetGenImage get onlineShopping =>
      const AssetGenImage('assets/images/png/online_shopping.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        saly1,
        saly2,
        characterMeditating,
        characterQuestionMark,
        characterThinking,
        logo,
        onlineShopping
      ];
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/google.svg
  String get google => 'assets/images/svg/google.svg';

  /// File path: assets/images/svg/profile_circle.svg
  String get profileCircle => 'assets/images/svg/profile_circle.svg';

  /// File path: assets/images/svg/success.svg
  String get success => 'assets/images/svg/success.svg';

  /// List of all assets
  List<String> get values => [google, profileCircle, success];
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
