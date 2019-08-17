import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/common.dart';
import 'package:flutter_study_history/res/index.dart';
import 'package:lpinyin/lpinyin.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static int getLoadStatus(bool hasError, List data) {
    if (hasError) return LoadStatus.fail;
    if (data == null) {
      return LoadStatus.loading;
    } else if (data.isNotEmpty) {
      return LoadStatus.empty;
    } else {
      return LoadStatus.success;
    }
  }
  static Color getChipBgColor(String name) {
    String pinyin = PinyinHelper.getFirstWordPinyin(name);
    pinyin = pinyin.substring(0, 1).toUpperCase();
    return nameToColor(pinyin);
  }
  static Color nameToColor(String name) {
    // assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  static String getPinyin(String str) {
    return PinyinHelper.getShortPinyin(str).substring(0, 1).toUpperCase();
  }

  static getCircleBg(String str) {
    String pinyin = getPinyin(str);
    return getCircleAvatarBg(pinyin);
  }

  static getCircleAvatarBg(String pinyin) {
    return circleAvatarMap[pinyin];
  }

  static String getTimeLine(BuildContext context, int timeMills) {
    return TimelineUtil.format(timeMills,
        locale: Localizations.localeOf(context).languageCode,
        dayFormat: DayFormat.Common);
  }
}
