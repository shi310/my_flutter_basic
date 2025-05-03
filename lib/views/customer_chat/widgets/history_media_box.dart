import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/common.dart';
import 'index.dart';

class CustomerChatViewHistoryMediaBox extends StatelessWidget {
  const CustomerChatViewHistoryMediaBox({
    super.key,
    required this.mediaType,
    required this.url,
    required this.alignType,
  });

  final MediaType mediaType;
  final String url;
  final AlignType alignType;

  @override
  Widget build(BuildContext context) {
    final loading = CupertinoActivityIndicator();

    return Row(children: [
      if (alignType == AlignType.right)
        Opacity(opacity: 0, child: loading),
      if (alignType == AlignType.right)
        const SizedBox(width: 4),
      Expanded(child: MyCard(
        color: Colors.black,
        borderRadius: getBorderRadius(alignType),
        height: mediaType == MediaType.image ? null : getChatBoxMaxWidth(),
        child: builderMediaNetworkBox(
          mediaType: mediaType,
          url: url,
        ),
      )),
      if (alignType == AlignType.left)
        const SizedBox(width: 4),
      if (alignType == AlignType.left)
        Opacity(opacity: 0, child: loading),
    ]);
  }
}