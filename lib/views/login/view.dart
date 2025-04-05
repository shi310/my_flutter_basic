import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../common/common.dart';
import 'controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login View')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          ElevatedButton(onPressed: getEnvironment, child: FittedBox(child: Text('获取配置'))),
          ElevatedButton(onPressed: setMyHttpClient, child: FittedBox(child: Text('配置dio'))),

          ElevatedButton(
            onPressed: () async {
              CaptchaModel data = CaptchaModel.empty();
              showMyLoading();
              await data.update();
              hideMyLoading();
            },
            child: FittedBox(child: Text('测试接口')),
          ),

          ElevatedButton(
            onPressed: () {
              setMySocket();
              UserController.to.mySocket?.reset();
            },
            child: FittedBox(child: Text('连接wss')),
          ),

          ElevatedButton(
            onPressed: () {
              UserController.to.mySocket?.close();
            },
            child: FittedBox(child: Text('断开wss')),
          ),

        ]),
      ),
    );
  }
}
