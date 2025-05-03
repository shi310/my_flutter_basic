import 'package:app_links/app_links.dart';
import '../common.dart';

Future<void> initDeepLink() async {
  final appLinks = AppLinks();

  appLinks.uriLinkStream.listen((uri) async {
    await commonDeepLink(uri.toString());
  });
}

Future<void> commonDeepLink(String data) async {
  MyLogger.w('DeepLink Success: $data');
}