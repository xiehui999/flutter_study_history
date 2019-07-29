import 'package:flustars/flustars.dart';
import 'common.dart';
import 'package:flutter_study_history/models/models.dart';

class SpHelper {
  static void putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);

        break;
      case bool:
        SpUtil.putBool(key, value);

        break;
      case String:
        SpUtil.putString(key, value);

        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        SpUtil.putObject(key, value);
        break;
    }
  }

  static getObject<T>(String key) {
    Map map = SpUtil.getObject(key);
    if (map == null) return null;
    Object obj;
    switch (T) {
      case SplashModel:
        obj = SplashModel.fromJson(map);
        break;
      case LanguageModel:
        obj = SplashModel.fromJson(map);
        break;
      case VersionModel:
        obj = VersionModel.fromJson(map);
        break;
    }
    return obj;
  }

  static String getThemeColor() {
    return SpUtil.getString(Constant.key_theme_color,
        defValue: 'deepPurpleAccent');
  }
}
