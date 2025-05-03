import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class CustomerFaqInfoView extends GetView<CustomerFaqInfoController> {
  const CustomerFaqInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderMyAppBarNormal(title: controller.arguments.title),
      body: _buildBody(),
      backgroundColor: MyColors.background,
    );
  }

  Widget _buildBody() {
    return MyCard(
      // margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: MyColors.cardBackground,
      child: SafeArea(
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (controller.arguments.answer.isNotEmpty)
            MyHtml(data: controller.arguments.answer),
          if (controller.arguments.picUrl.isNotEmpty)
            const SizedBox(height: 10),
          if (controller.arguments.picUrl.isNotEmpty)
            MyImage(imageUrl: controller.arguments.picUrl, width: double.infinity),
        ])),
      ),
    );
  }
}
