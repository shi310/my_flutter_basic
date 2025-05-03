import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class CustomerFaqListView extends GetView<CustomerFaqListController> {
  const CustomerFaqListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderMyAppBarNormal(title: controller.arguments.categoryName),
      body: GetBuilder<CustomerFaqListController>(
        id: controller.getBuilderBody,
        builder: (controller) {
          return FutureBuilder(
            future: controller.getPageData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoading();
              }
              return _buildBody();
            },
          );
        },
      ),
      backgroundColor: MyColors.background,
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(padding: EdgeInsets.fromLTRB(16, 0, 16, 16), child: MyCard(
      borderRadius: BorderRadius.circular(10),
      color: MyColors.white,
      padding: EdgeInsets.all(16),
      child: Column(children: List.generate(10, (index) => MyCard(
        borderRadius: BorderRadius.circular(10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: index == 9 ? null : const EdgeInsets.only(bottom: 8),
        color: MyColors.primary.withValues(alpha: 0.05),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          builderLoading(
            width: 18,
            height: 18,
            radius: 18,
          ),
          const SizedBox(width: 10),
          Expanded(child: builderLoading(
            width: double.infinity,
            height: 16,
            radius: 4,
          )),
        ]),
      ))),
    ));
  }

  Widget _buildBody() {
    if (controller.customerFaqList.list.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: builderDataEmptyWidget(),
        ),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: _buildCustomerFaq(),
    );
  }
  
  Widget _buildCustomerFaq() {
    final hot = Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(MyIcons.helpHot, height: 16, width: 50, fit: BoxFit.fill),
        SizedBox(
          width: 50,
          height: 16,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: FittedBox(child: Text(MyLanguage.faqHot.tr, style: TextStyle(
                color: MyColors.white,
                fontSize: MyFontSize.body.value,
              ))),
            ),
          ),
        ),
      ],
    );

    final body = Column(children: controller.customerFaqList.list.asMap().entries.map((element) {
      final card = MyCard(
        color: MyColors.primary.withValues(alpha: 0.05),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(child: Row(children: [
            MyCard(
              width: 18,
              height: 18,
              borderRadius: BorderRadius.circular(18),
              color: MyColors.primary,
              child: Center(child: FittedBox(child: Text(element.value.sort.toString(), style: TextStyle(
                color: MyColors.white,
              )))),
            ),
            const SizedBox(width: 10),
            Flexible(child: Text(element.value.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: MyColors.primary,
              ),
            )),
            const SizedBox(width: 10),
            if (element.value.symbol == 1) hot,
            const SizedBox(width: 10),
          ])),
          SvgPicture.asset(MyIcons.right, colorFilter: ColorFilter.mode(MyColors.iconGrey, BlendMode.srcIn)),
        ]),
      );

      return Padding(padding: EdgeInsets.only(bottom: element.key == controller.customerFaqList.list.length - 1 ? 0 : 8) , child: MyButton(
        onPressed: () => controller.onClickFaqItemClick(element.value),
        borderRadius: BorderRadius.circular(8),
        child: card,
      ));
    }).toList());

    return MyCard(
      color: MyColors.white,
      borderRadius: BorderRadius.circular(10),
      padding: EdgeInsets.all(16),
      child: body,
    );
  }
}
