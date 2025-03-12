import 'package:my_flutter_basic/common/common.dart';

Future<void> getEnvironment() async {
  final environment = await MyEnvironment.initialize();

  switch (environment){
    case Environment.rel:
      await getOptions(urls: MyConfig.urls.relUrls, onSuccess: setMyDio);
      break;
    case Environment.pre:
      await getOptions(urls: MyConfig.urls.preUrls, onSuccess: setMyDio);
      break;
    case Environment.grey:
      await getOptions(urls: MyConfig.urls.greyUrls, onSuccess: setMyDio);
      break;
    default:
      await getOptions(urls: MyConfig.urls.testUrls, onSuccess: setMyDio);
      break;
  }
}