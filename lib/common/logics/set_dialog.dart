import 'package:flutter/material.dart';
import '../common.dart';

void showMyLoading() => MyAlert.showLoading();
void hideMyLoading() => MyAlert.hideLoading();
void showMyBlock() => MyAlert.showBlock();
void hideMyBlock() => MyAlert.hideBlock();
void showMySnack({Widget? child}) => MyAlert.showSnack(child: child);
void showMyToast({Widget? child}) => MyAlert.showToast(child: child);
