import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common.dart';

void showResponseError(Response? response) {
  ResponseModel data = ResponseModel.fromJson(json.decode(response?.bodyString ?? '{}'));
  showMySnack(child: Text(data.msg));
}