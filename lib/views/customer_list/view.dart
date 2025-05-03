import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class CustomerListView extends GetView<CustomerListController> {
  const CustomerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderMyAppBarNormal(title: controller.arguments.customerType == CustomerType.guest
        ? MyLanguage.customerViewTitleGuest.tr
        : MyLanguage.customerViewTitleUser.tr,
      ),
      body: FutureBuilder(
        future: controller.getPageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }
          return _buildBody();
        },
      ),
      backgroundColor: MyColors.background,
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(padding: EdgeInsets.fromLTRB(16, 10, 16, 16), child: Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyCard(
          width: 50,
          height: 50,
          color: MyColors.white,
          borderRadius: BorderRadius.circular(50),
          padding: EdgeInsets.all(6),
          child: builderLoading(
            width: 40,
            height: 40,
            radius: 20,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(child: MyCard(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.white,
          padding: EdgeInsets.all(16),
          child: Column(children: List.generate(10, (index) => MyCard(
            margin: index == 9 ? null : const EdgeInsets.only(bottom: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              builderLoading(
                width: 32,
                height: 32,
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
        )),
      ]),
    ]));
  }

  Widget _buildBody() {
    if (controller.customerData.customer.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: builderDataEmptyWidget(),
        ),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: Column(children: [
        _buildCustomerList(),
        const SizedBox(height: 10),
        _buildCustomerFaq(),
      ]),
    );
  }
  
  Widget _buildCustomerList() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MyCard(
        width: 50,
        height: 50,
        color: MyColors.white,
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(MyIcons.customerAvatar),
      ),

      const SizedBox(width: 10),

      Expanded(
        child: MyCard(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          padding: EdgeInsets.all(16),
          child: Column(children: controller.customerData.customer.asMap().entries.map((element) {
            final card = Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              MyCard(
                width: 32,
                height: 32,
                borderRadius: BorderRadius.circular(18),
                child: MyImage(imageUrl: element.value.customerServiceAvatar, width: 32, height: 32),
              ),
              const SizedBox(width: 10),
              Text(element.value.remark),
            ]);

            return Padding(padding: EdgeInsets.only(bottom: element.key == 0 ? 0 : 8) , child: MyButton(
              borderRadius: BorderRadius.circular(30),
              onPressed: () => controller.onClickCustomerItem(element.value),
              child: card,
            ));
          }).toList()),
        ),
      ),
    ]);
  }
  
  Widget _buildCustomerFaq() {
    return Row(children: [
      const SizedBox(width: 50 + 10),
      Expanded(child: Column(children: [
        MyCard(
          width: double.infinity,
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          padding: EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(MyLanguage.customerViewTitleFaq.tr, style: TextStyle(
              fontSize: MyFontSize.bodyLarge.value,
              color: MyColors.primary,
              fontWeight: FontWeight.w600
            )),

            Column(children: controller.customerFaqTypeList.list.asMap().entries.map((element) {
              final card = MyCard(
                color: MyColors.primary.withValues(alpha: 0.05),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                  Expanded(child: Align(alignment: Alignment.centerLeft, child: FittedBox(child: Text(element.value.categoryName, style: TextStyle(
                    color: MyColors.primary
                  ))))),
                  const SizedBox(width: 10),
                  SvgPicture.asset(MyIcons.right, colorFilter: ColorFilter.mode(MyColors.iconGrey, BlendMode.srcIn)),
                ]),
              );

              return Padding(padding: EdgeInsets.only(top: element.key == controller.customerFaqTypeList.list.length - 1 ? 16 : 8) , child: MyButton(
                onPressed: () => controller.onClickFaqItem(element.value),
                borderRadius: BorderRadius.circular(8),
                child: card,
              ));
            }).toList())
          ]),
        ),
      ])),
    ]);
  }
}
