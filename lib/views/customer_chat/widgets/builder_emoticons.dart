import 'package:flutter/cupertino.dart';

import '../../../common/common.dart';

Widget builderEmoticons({
  required List<String> emoticons, // List<String>
  required int itemCount,
  required void Function(String) onPressed
}) {
  return RepaintBoundary(
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final e = emoticons[index];
        return MyButton(
          debounceDuration: Duration.zero,
          borderRadius: BorderRadius.circular(8),
          onPressed: () => onPressed.call(emoticons[index]),
          child: FittedBox(child: Text(e)),
        );
      },
    ),
  );
}