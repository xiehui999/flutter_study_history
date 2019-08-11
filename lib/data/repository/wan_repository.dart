import 'package:flutter_study_history/data/protocol/models.dart';
import 'package:base_library/base_library.dart';
import 'package:flutter_study_history/common/common.dart';
import '../api/apis.dart';

class WanRepository {
  Future<List<BannerModel>> getBanner() async {
    BaseResp<List> baseResp =
        await DioUtil().request<List>(Method.get, WanAndroidApi.BANNER);
    List<BannerModel> bannerList;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((value) {
        return BannerModel.fromJson(value);
      }).toList();
    }
    return bannerList;
  }
}
