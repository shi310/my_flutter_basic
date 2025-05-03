
import '../common.dart';

Future<void> checkHealth() async {
  await UserController.to.myHttpClient?.get(ApiPath.auth.health);
}