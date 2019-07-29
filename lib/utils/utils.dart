import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/common.dart';
import 'package:flutter_study_history/res/index.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }
}
