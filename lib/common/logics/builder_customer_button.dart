import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../common.dart';

Widget builderCustomerButton({
  required CustomerListViewArguments arguments,
}) => IconButton(
  onPressed: () {
    Get.toNamed(MyRoutes.customerListView, arguments: arguments);
  },
  icon: SvgPicture.asset(MyIcons.customer,
    colorFilter: ColorFilter.mode(MyColors.iconDefault, BlendMode.srcIn),
  ),
);
