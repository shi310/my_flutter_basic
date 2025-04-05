import '../common.dart';

Future<void> getEnvironment() async {
  final environment = await MyEnvironment.initialize();

  switch (environment){
    case Environment.rel:
      await getOptions(urls: MyConfig.urls.relUrls, onSuccess: setMyHttpClient);
      break;
    case Environment.pre:
      await getOptions(urls: MyConfig.urls.preUrls, onSuccess: setMyHttpClient);
      break;
    case Environment.grey:
      await getOptions(urls: MyConfig.urls.greyUrls, onSuccess: setMyHttpClient);
      break;
    default:
      await getOptions(urls: MyConfig.urls.testUrls, onSuccess: setMyHttpClient);
      break;
  }
}