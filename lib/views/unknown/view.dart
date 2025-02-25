import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class UnknownView extends GetView<UnknownController> {
  const UnknownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.state.title)),
      body: Container(color: Colors.blue,),
    );
  }
}
