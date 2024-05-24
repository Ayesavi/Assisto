import 'dart:io';

abstract class BaseImageService {
  Future<File?> resize(File file,
      {required int maxWidth, required int maxHeight});
  // max size in mb
  bool validate(File file, {required int maxSize});
}
