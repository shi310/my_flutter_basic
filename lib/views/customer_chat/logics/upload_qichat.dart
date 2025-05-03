import 'dart:io';

import 'package:get/get.dart';

import '../../../common/common.dart';

Future<void> uploadQichat({
  required String filePath,
  required MyHttpClient myHttpClient,
  Future<dynamic> Function(int, String, Object?)? onSuccess,
  Future<dynamic> Function(Response<dynamic>?)? onError,
  dynamic Function(double)? uploadProgress,
}) async {
  final fileType = filePath.split('.').last.toLowerCase();
  String fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileType';

  // 构建 MultipartFile 对象
  final multipartFile = MultipartFile(File(filePath),
    filename: fileName,
  );

  // 上传文件
  await myHttpClient.upload(ApiPath.qichat.upload,
    data: {
      'myFile': multipartFile,
      'type': '4',
    },
    onSuccess: onSuccess,
    onError: onError,
    uploadProgress: uploadProgress,
  );
}