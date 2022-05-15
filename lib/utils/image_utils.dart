import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageUtils {

  static Future<File?> cropImage(String path) async {
    File? croppedFile = await ImageCropper().cropImage(
        maxHeight: 1000,
        maxWidth: 1000,
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
        ]
            : [
          CropAspectRatioPreset.square
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: '',
        ));
    return croppedFile;
  }

  static Future<ByteData> exportToImage(GlobalKey globalKey) async {
    final boundary =
    globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(
      pixelRatio: 3,
    );
    final byteData = await image.toByteData(
      format: ImageByteFormat.png,
    );
    return byteData!;
  }

}
