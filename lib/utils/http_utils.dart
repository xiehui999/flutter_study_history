import 'package:flutter_study_history/common/common.dart';
import 'package:flutter_study_history/models/models.dart';

//模拟网络请求
class HttpUtils {
  Future<SplashModel> getSplash() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new SplashModel(
          title: "Flutter 常用工具类",
          content: 'Flutter 常用工具类库',
          url: 'https://www.jianshu.com/p/425a7ff9d66e',
          imgUrl:
              'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png');
    });
  }

  Future<VersionModel> getVersion() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new VersionModel(
        title: '有新版本v0.1.2，去更新吧！',
        content: '',
        url:
            'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppStore/flutter_wanandroid_new.apk',
        version: AppConfig.remoteVersion,
      );
    });
  }

  Future<ComModel> getRecItem() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return null;
    });
  }

  Future<List<ComModel>> getRecList() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return new List();
    });
  }
}
