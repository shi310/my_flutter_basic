import 'package:get/get.dart';

void closeDialog() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) {
    Get.back();
    closeDialog();
  }
}