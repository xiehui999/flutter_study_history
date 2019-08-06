import 'package:flutter/material.dart';
import 'index.dart';

class TextStyles {
  static TextStyle listContent =
      TextStyle(fontSize: Dimens.font_sp14, color: AppColors.text_normal);
  static TextStyle listContent2 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.text_gray,
  );
}

class Gaps {
  static Widget hGap5 = new SizedBox(
    width: Dimens.gap_dp5,
  );
  static Widget hGap10 = new SizedBox(
    width: Dimens.gap_dp10,
  );
  static Widget hGap15 = new SizedBox(
    width: Dimens.gap_dp15,
  );
  static Widget hGap30 = new SizedBox(
    width: Dimens.gap_dp30,
  );

  //垂直间隔
  static Widget vGap5 = new SizedBox(
    height: Dimens.gap_dp5,
  );
  static Widget vGap10 = new SizedBox(
    height: Dimens.gap_dp10,
  );
  static Widget vGap15 = new SizedBox(
    height: Dimens.gap_dp15,
  );

  static Widget getHGap(double w) {
    return new SizedBox(
      width: w,
    );
  }

  static Widget getVGap(double h) {
    return new SizedBox(
      height: h,
    );
  }
}
