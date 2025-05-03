
import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/common/common.dart';

class MyPicker {
  static final MyPicker _instance = MyPicker._internal();
  factory MyPicker() => _instance;
  MyPicker._internal();

  static Future<XFile?> getImage({bool isCamera = false}) => _instance._getImage(isCamera: isCamera);
  static Future<XFile?> getVideo({bool isCamera = false, bool isBackCamera = false, Duration maxDuration = const Duration(seconds: 10)}) => _instance._getVideo(isCamera: isCamera, isBackCamera: isBackCamera, maxDuration: maxDuration);
  static Future<XFile?> getMedia({bool isCamera = false}) => _instance._getMedia();
  static Future<double> getFileSize({required XFile file}) => _instance._getFileSize(file: file);
  bool _isPicking = false;

  Future<XFile?> _getImage({bool isCamera = false}) async {
    if (_isPicking) return null;
    _isPicking = true;
    XFile? xFile;
    try {
      isCamera ? await MyPermission.camera() : await MyPermission.photos();
      xFile = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 30,
      );
      log(xFile == null ? '没有获取到图片...' : '图片获取成功: --> (${xFile.path})');
    } catch (e) {
      log('获取图片失败...');
    } finally {
      _isPicking = false;
    }
    return xFile;
  }

  Future<XFile?> _getVideo({bool isCamera = false, bool isBackCamera = false, Duration maxDuration = const Duration(seconds: 10)}) async {
    if (_isPicking) return null;
    _isPicking = true;
    XFile? xFile;
    try {
      isCamera ? await MyPermission.camera() : await MyPermission.photos();

      xFile = await ImagePicker().pickVideo(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        maxDuration: maxDuration,
        preferredCameraDevice: isBackCamera ? CameraDevice.rear : CameraDevice.front,
      );
      log(xFile == null ? '没有获取到图片...' : '图片获取成功: --> (${xFile.path})');
    } catch (e) {
      log('获取图片失败...');
    } finally {
      _isPicking = false;
    }
    return xFile;
  }

  Future<XFile?> _getMedia() async {
    if (_isPicking) return null;
    _isPicking = true;
    XFile? xFile;
    try {
      await MyPermission.photos();

      xFile = await ImagePicker().pickMedia(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 30,
      );

      log(xFile == null ? '没有获取到图片...' : '图片获取成功: --> (${xFile.path})');
    } catch (e) {
      log('获取图片失败...');
    } finally {
      _isPicking = false;
    }
    return xFile;
  }

  Future<double> _getFileSize({required XFile file}) async {
    final sizeB = await file.length();
    final size = sizeB / 1024 / 1024;
    return size;
  }
}