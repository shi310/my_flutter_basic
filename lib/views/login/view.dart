import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:my_flutter_basic/common/common.dart';
import 'package:my_flutter_basic/common/logics/set_my_wss.dart';
import 'package:my_flutter_basic/common/models/captcha_model.dart';
import 'package:my_gallery/common/my_picker.dart';
import 'package:my_gallery/my_gallery_method.dart';


import 'controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final wrap = Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 0,
      children: [
        ElevatedButton(onPressed: setThemeLight, child: Text('亮色主题')),
        ElevatedButton(onPressed: setThemeDark, child: Text('暗色主题')),
        ElevatedButton(onPressed: setThemeSystem, child: Text('跟随系统')),
        ElevatedButton(onPressed: setLangZh, child: Text('中文')),
        ElevatedButton(onPressed: setLangEn, child: Text('英文')),
        ElevatedButton(onPressed: setLangSystem, child: Text('系统语言')),

        ElevatedButton(
          onPressed: () async {
            final info = UserController.to.deviceInfo;
            showMyDialog(
              title: info?.appName,
              content: 'APP 版本: ${info?.appVersion}, 其他信息：${info?.brand}, ${info?.id}, ${info?.model}, ${info?.systemVersion}',
              confirmText: '关闭',
            );
          },
          child: Text('本机信息'),
        ),
        ElevatedButton(
          onPressed: () async {
            showMyDialog(
              title: '重新启动',
              content: '是否现在重新启动并更新？',
              confirmText: '确认',
              cancelText: '取消',
              onConfirm: () {
                MyDeviceInfo.restartApp(
                  notificationTitle: '测试用的',
                  notificationBody: '点击这里重新启动APP',
                );
              },
              onCancel: () {
                Get.back();
              },
            );
          },
          child: Text('重启'),
        ),

        ElevatedButton(onPressed: getEnvironment, child: Text('获取配置')),
        ElevatedButton(onPressed: setMyDio, child: Text('配置dio')),

        ElevatedButton(
          onPressed: () async {
            CaptchaModel data = CaptchaModel.empty();
            showMyLoading();
            await data.update();
            hideMyLoading();
            MyLogger.w('${data.toJson()}');
            showMyDialog(
              title: '返回数据',
              content: '${data.toJson()}',
              onConfirm: () {},
              onCancel: () {},
            );
          },
          child: Text('测试接口'),
        ),

        ElevatedButton(
          onPressed: () {
            setMyWss();
            UserController.to.myWss?.connect();
          },
          child: Text('连接wss'),
        ),

        ElevatedButton(
          onPressed: () {
            showMyDialog(
                title: '断开通信',
                content: '是否确认断开与服务器的连接？',
                confirmText: '确认',
                cancelText: '取消',
                onConfirm: () => UserController.to.myWss?.close()
            );
          },
          child: Text('断开wss'),
        ),

        ElevatedButton(
          onPressed: () async {
            Get.to(()=> Scaffold(
              appBar: AppBar(title: Text('扫一扫'), centerTitle: true),
              body: MyGallery.scan(onResult: (result) {
                MyAudio.play(MyAudioPath.scan);
                Get.back();
                showMySnack(child: Text(result ?? '没有扫到任何信息', style: TextStyle(color: Colors.white, fontSize: 13)));
              }),
            ));
          },
          child: Text('扫一扫'),
        ),

        ElevatedButton(
          onPressed: () async {
            final image = await MyPicker.getImage();
            if (image!= null) {
              final result = await MyGallery.decodeQRCode(path: image.path);
              showMySnack(child: Text(result ?? '没有识别到任何信息', style: TextStyle(color: Colors.white, fontSize: 13)));
            }
          },
          child: Text('识别二维码'),
        ),

        ElevatedButton(
          onPressed: () {
            showMySnack(child: Text('顶部弹窗的文案在这里', style: TextStyle(color: Colors.white)));
          },
          child: Text('顶部提示'),
        ),

        ElevatedButton(
          onPressed: () {
            showMyToast(child: Text('中部弹窗的文案在这里', style: TextStyle(color: Colors.white)));
          },
          child: Text('中部提示'),
        ),

        ElevatedButton(
          onPressed: () => Get.toNamed(MyRoutes.tetrisView),
          child: Text('俄罗斯方块'),
        ),

        ElevatedButton(
          onPressed: () {},
          child: Text('path -> +2'),
        ),

      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(Lang.activityClosed.tr)),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: wrap
      ),
    );
  }
}
