import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderMyAppBarTransparent(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.background,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final page = PageView(
      onPageChanged: controller.onPageChanged,
      children: [
        Image.asset(MyIcons.welcome1, fit: BoxFit.cover),
        Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(MyIcons.welcome2, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 32,
            child: SafeArea(
              child: SizedBox(
                width: Get.width * 0.5,
                child: FilledButton(
                  onPressed: controller.onClickGoLoginView,
                  child: Text(MyLanguage.tryItNow.tr),
                ),
              ),
            ),
          ),
        ]),
      ],
    );

    return Stack(alignment: Alignment.center, children: [
      page,
      Positioned(
        bottom: 10,
        child: SafeArea(
          child: GetBuilder<IndexController>(
            id: controller.getBuilderTabs,
            builder: (controller) {
              return Row(children: [
                MyCard(
                  width: 6,
                  height: 6,
                  borderRadius: BorderRadius.circular(3),
                  color: controller.pageIndex == 0 ? MyColors.primary : MyColors.buttonDisable,
                ),
                const SizedBox(width: 6),
                MyCard(
                  width: 6,
                  height: 6,
                  borderRadius: BorderRadius.circular(3),
                  color: controller.pageIndex == 1 ? MyColors.primary : MyColors.buttonDisable,
                ),
              ]);
            },
          ),
        ),
      ),
    ]);
  }
}
