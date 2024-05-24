import 'dart:io';
import 'dart:typed_data';

import 'package:assisto/core/services/image_service/base_image_service.dart';
import 'package:image/image.dart' as img;

class ImageServiceImpl implements BaseImageService {
  @override
  Future<File?> resize(File file,
      {required int maxWidth, required int maxHeight}) async {
    final img.Image? resizedImage =
        await _resizeImage(file, maxWidth, maxHeight);
    if (resizedImage == null) {
      return null;
    }

    // Encode resized image to bytes
    final Uint8List resizedBytes = _encodeImage(resizedImage);

    // Create temporary file and write resized image bytes
    final String fileType = file.path.split('.').last.toLowerCase();
    final tempDir = Directory.systemTemp;
    final tempFile =
        await File('${tempDir.path}/resized_image.$fileType').create();
    await tempFile.writeAsBytes(resizedBytes);

    return tempFile;
  }

  @override
  bool validate(File file,
      {required int maxSize, int maxWidth = 0, int maxHeight = 0}) {
    // Convert maximum size from MB to bytes
    int maxSizeBytes = maxSize * 1024 * 1024; // 1 MB = 1024 * 1024 bytes

    // Check if file size exceeds max size
    if (file.lengthSync() > maxSizeBytes) {
      return false; // Size validation failed
    }

    // Read image dimensions
    img.Image? image = img.decodeImage(file.readAsBytesSync());
    if (image == null) {
      return false; // Unable to decode image
    }

    // Check if image dimensions exceed max width and max height
    if ((maxWidth > 0 && image.width > maxWidth) ||
        (maxHeight > 0 && image.height > maxHeight)) {
      return false; // Dimension validation failed
    }

    // Validation successful
    return true;
  }

  Future<img.Image?> _resizeImage(
      File file, int maxWidth, int maxHeight) async {
    // Read bytes and decode image
    final Uint8List bytes = await file.readAsBytes();
    final img.Image? image = img.decodeImage(bytes);
    if (image == null) {
      return null;
    }

    // Resize image if necessary
    return image.width > maxWidth || image.height > maxHeight
        ? img.copyResize(image, width: maxWidth, height: maxHeight)
        : image;
  }

  Uint8List _encodeImage(img.Image image) {
    return image.hasAlpha
        ? img.encodePng(image)
        : img.encodeJpg(image, quality: 85);
  }
}
