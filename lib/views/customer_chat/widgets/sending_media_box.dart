import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/common.dart';
import 'index.dart';

class CustomerChatViewSendingMediaBox extends StatelessWidget {
  const CustomerChatViewSendingMediaBox({
    super.key,
    required this.mediaType,
    required this.future,
    required this.path,
    required this.alignType,
  });

  final MediaType mediaType;
  final Future<String> future;
  final String path;
  final AlignType alignType;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        // Widget child;
        double opacity = 0.0;

        final loading = CupertinoActivityIndicator();

        if (snapshot.connectionState == ConnectionState.waiting) {
          opacity = 1.0;
          // child = builderMediaFileBox(
          //   mediaType: mediaType,
          //   path: path,
          // );
        }
        // else if (snapshot.hasData) {
        //   opacity = 0.0;
        //   child = mediaType == MediaType.image
        //       ? MyImage(imageUrl: snapshot.data!)
        //       : MyVideoPlayer(videoUrl: snapshot.data!);
        // } else {
        //   opacity = 0.0;
        //   child = builderDataErrorWidget();
        // }
        return Row(children: [
          if (alignType == AlignType.right)
            Opacity(opacity: opacity, child: loading),
          if (alignType == AlignType.right)
            const SizedBox(width: 4),
          Expanded(child: MyCard(
            color: Colors.black,
            borderRadius: getBorderRadius(alignType),
            height: mediaType == MediaType.image ? null : getChatBoxMaxWidth(),
            child: builderMediaFileBox(
              mediaType: mediaType,
              path: path,
            ),
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