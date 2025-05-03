import 'package:flutter/cupertino.dart';

import 'index.dart';

BorderRadiusGeometry getBorderRadius(AlignType alignType) {
  return BorderRadius.only(
    topLeft: alignType == AlignType.left ? Radius.zero : Radius.circular(10),
    topRight: alignType == AlignType.left ? Radius.circular(10) : Radius.zero,
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  );
}