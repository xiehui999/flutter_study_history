import 'dart:collection';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/data/repository/wan_repository.dart';

class MainBloc implements BlocBase {
  BehaviorSubject<List<BannerModel>> _banner =
      BehaviorSubject<List<BannerModel>>();

  Sink<List<BannerModel>> get _bannerSink => _banner.sink;

  Stream<List<BannerModel>> get bannerStream => _banner.stream;

  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get homeEvebtSink => _homeEvent.sink;

  Stream<StatusEvent> get homeEventStream =>
      _homeEvent.stream.asBroadcastStream();

  ComModel hotRecModel;
  BehaviorSubject<ComModel> _recItem = BehaviorSubject<ComModel>();

  Sink<ComModel> get _recItemSink => _recItem.sink;

  Stream<ComModel> get recItemStream => _recItem.stream.asBroadcastStream();
  BehaviorSubject<List<ComModel>> _recList = BehaviorSubject<List<ComModel>>();

  Sink<List<ComModel>> get _recListSink => _recList.sink;

  Stream<List<ComModel>> get recListStream =>
      _recList.stream.asBroadcastStream();
  WanRepository wanRepository = new WanRepository();

  HttpUtils httpUtils = new HttpUtils();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future getData({String labelId, int page}) {
    LogUtil.e("getData......" + labelId + page.toString());
    switch (labelId) {
      case Ids.titleHome:
        return getHomeData(labelId);
    }
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    // TODO: implement onRefresh
    switch (labelId) {
      case Ids.titleHome:
        getHotRecItem();
        break;
    }
    return getData(labelId: labelId, page: 0);
  }

  void getHotRecItem() {
    return null;
  }

  Future getHomeData(String labelId) {
    return getBanner(labelId);
  }

  Future getBanner(String labelId) {
    return wanRepository.getBanner().then((list) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(list));
    });
  }
}
