import '../common.dart';

Future<void> getEnvironment({
  Future<void> Function()? onNext,
}) async {
  final environment = await MyEnvironment.initialize();

  switch (environment){
    case Environment.rel:
      await getOptions(urls: MyConfig.urls.relUrls, onSuccess: () async {
        await setMyHttpClient();
        await onNext?.call();
      });
      break;
    case Environment.pre:
      await getOptions(urls: MyConfig.urls.preUrls, onSuccess: () async {
        await setMyHttpClient();
        await onNext?.call();
      });
      break;
    case Environment.grey:
      await getOptions(urls: MyConfig.urls.greyUrls, onSuccess: () async {
        await setMyHttpClient();
        await onNext?.call();
      });
      break;
    default:
      await getOptions(urls: MyConfig.urls.testUrls, onSuccess: () async {
        await setMyHttpClient();
        await onNext?.call();
      });
      break;
  }
}