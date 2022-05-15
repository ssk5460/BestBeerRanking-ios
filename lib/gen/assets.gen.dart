/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/back.svg
  SvgGenImage get back => const SvgGenImage('assets/svgs/back.svg');

  /// File path: assets/svgs/check.svg
  SvgGenImage get check => const SvgGenImage('assets/svgs/check.svg');

  /// File path: assets/svgs/close.svg
  SvgGenImage get close => const SvgGenImage('assets/svgs/close.svg');

  /// File path: assets/svgs/complete.svg
  SvgGenImage get complete => const SvgGenImage('assets/svgs/complete.svg');

  /// File path: assets/svgs/crown.svg
  SvgGenImage get crown => const SvgGenImage('assets/svgs/crown.svg');

  /// File path: assets/svgs/crown_dot.svg
  SvgGenImage get crownDot => const SvgGenImage('assets/svgs/crown_dot.svg');

  /// File path: assets/svgs/log.svg
  SvgGenImage get log => const SvgGenImage('assets/svgs/log.svg');

  /// File path: assets/svgs/menu.svg
  SvgGenImage get menu => const SvgGenImage('assets/svgs/menu.svg');

  /// File path: assets/svgs/setting.svg
  SvgGenImage get setting => const SvgGenImage('assets/svgs/setting.svg');

  /// File path: assets/svgs/star.svg
  SvgGenImage get star => const SvgGenImage('assets/svgs/star.svg');
}

class Assets {
  Assets._();

  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
