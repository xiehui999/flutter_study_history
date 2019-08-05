import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:common_utils/common_utils.dart';
import 'package:base_library/src/common/common.dart';

class Util {
  static String getImagePath(String name, {String format: "png"}) {
    return 'asset/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('$msg')));
  }

  static bool isLogin() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.keyAppToken));
  }
}
