import 'dart:convert';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

Future<String> imageToBase64(File imageFile) async {
  print("imageFile");
  print(imageFile.path);
  // Compress the image to reduce size
  File compressedFile =
      await FlutterNativeImage.compressImage(imageFile.path, quality: 50);
  final bytes = await imageFile.readAsBytesSync();
  return base64Encode(bytes);
}
