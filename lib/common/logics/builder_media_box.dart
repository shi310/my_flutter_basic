import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../common.dart';

Widget builderMediaFileBox({
  // required double maxSize,
  required MediaType mediaType,
  required String path,
}) {
  final file = File(path);
  // final hintText = MyLanguage.fileSizeOut.trArgs(['$maxSize']);

  return mediaType == MediaType.image
    ? Image.file(file, fit: BoxFit.contain)
    : MyVideoPlayer(file: file);
}

Widget builderMediaNetworkBox({
  required MediaType mediaType,
  required String url,
}) {

  return mediaType == MediaType.image
    ? MyImage(imageUrl: url)
    : MyVideoPlayer(videoUrl: url);
}

enum MediaType {
  image,
  video,
}