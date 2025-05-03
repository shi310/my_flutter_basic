
import 'package:flutter/cupertino.dart';
import '../../../common/common.dart';
import 'index.dart';

class CustomerChatViewSendingTextBox extends StatelessWidget {
  const CustomerChatViewSendingTextBox({
    super.key,
    required this.text,
    required this.alignType,
    required this.future,
  });

  final String text;
  final AlignType alignType;
  final Future<String?> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        double opacity = 0.0;

        final loading = CupertinoActivityIndicator();

        if (snapshot.connectionState == ConnectionState.waiting) {
          opacity = 1.0;
        } else {
          opacity = 0.0;
        }

        return Row(mainAxisAlignment: alignType == AlignType.left ? MainAxisAlignment.start : MainAxisAlignment.end, children: [
          if (alignType == AlignType.right)
            Opacity(opacity: opacity, child: loading),
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
            Opacity(opacity: opacity, child: loading),
        ]);
      },
    );
  }
}