import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home View')),
      body: Container(color: Colors.blue,),
    );
  }
}
