
import 'package:flutter/cupertino.dart';
import '../../../common/common.dart';
import 'index.dart';

class CustomerChatViewHistoryTextBox extends StatelessWidget {
  const CustomerChatViewHistoryTextBox({
    super.key,
    required this.text,
    required this.alignType,
  });

  final String text;
  final AlignType alignType;

  @override
  Widget build(BuildContext context) {
    final loading = CupertinoActivityIndicator();

    return Row(mainAxisAlignment: alignType == AlignType.left ? MainAxisAlignment.start : MainAxisAlignment.end, children: [
      if (alignType == AlignType.right)
        Opacity(opacity: 0, child: loading),
      if (alignType == AlignType.right)
        const SizedBox(width: 4),
      Flexible(child: MyCard(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: alignType == AlignType.left ? MyColors.itemCardBackground : MyColors.primary,
        borderRadius: getBorderRadius(alignType),
        child: Text(text, style: TextStyle(
          color: alignType == AlignType.left ? MyColors.onBackground : MyColors.onPrimary,
          fontSize: 14,
        )),
      )),
      if (alignType == AlignType.left)
        const SizedBox(width: 4),
      if (alignType == AlignType.left)
        Opacity(opacity: 0, child: loading),
    ]);
  }
}