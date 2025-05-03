import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';
import 'index.dart';

class CustomerChatViewMessageBox extends StatelessWidget {
  const CustomerChatViewMessageBox({
    super.key,
    required this.alignType,
    required this.child,
    required this.avatar,
    // required this.timeBox,
  });

  final AlignType alignType;
  final Widget child;
  final Widget avatar;
  // final Widget timeBox;

  @override
  Widget build(BuildContext context) {
    final avatarBox = MyCard(
      width: 40,
      height: 40,
      borderRadius: BorderRadius.circular(36),
      child: avatar,
    );
    return Align(
      alignment: alignType == AlignType.left ? Alignment.centerLeft : Alignment.centerRight,
      child: MyCard(
        constraints: BoxConstraints(maxWidth: getChatBoxMaxWidth()),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (alignType == AlignType.left)
            avatarBox,
          if (alignType == AlignType.left)
            const SizedBox(width: 8),
          Flexible(child: Column(crossAxisAlignment: alignType == AlignType.left ? CrossAxisAlignment.start : CrossAxisAlignment.end, children: [
            Text('${DateTime.now()}'.split('.').first),
            const SizedBox(height: 4),
            child,
          ])),
          if (alignType == AlignType.right)
            const SizedBox(width: 8),
          if (alignType == AlignType.right)
            avatarBox,
        ]),
      ),
    );
  }
}

enum AlignType {
  left,
  right,
}