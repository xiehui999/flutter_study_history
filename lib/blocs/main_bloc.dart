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

  BehaviorSubject<List<ReposModel>> _recRepos =
      BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _recReposSink => _recRepos.sink;

  Stream<List<ReposModel>> get recReposStream => _recRepos.stream;

  Stream<List<ComModel>> get recListStream =>
      _recList.stream.asBroadcastStream();
  WanRepository wanRepository = new WanRepository();

  HttpUtils httpUtils = new HttpUtils();

  @override
  void dispose() {
    _banner.close();
    _recRepos.close();
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
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
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
    getRecRepos(labelId);
    return getBanner(labelId);
  }

  Future getRecRepos(String labelId) {
    ComReq _comReq = new ComReq(402);
    wanRepository.getProjectList(data: _comReq.toJson()).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recReposSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  Future getBanner(String labelId) {
    return wanRepository.getBanner().then((list) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(list));
    });
  }
}
