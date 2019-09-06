import 'dart:collection';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/data/repository/wan_repository.dart';
import 'package:azlistview/azlistview.dart';

class MainBloc implements BlocBase {
  //首页banner相关
  BehaviorSubject<List<BannerModel>> _banner =
      BehaviorSubject<List<BannerModel>>();

  Sink<List<BannerModel>> get _bannerSink => _banner.sink;

  Stream<List<BannerModel>> get bannerStream => _banner.stream;

  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get homeEventSink => _homeEvent.sink;

  Stream<StatusEvent> get homeEventStream =>
      _homeEvent.stream.asBroadcastStream();

  ComModel hotRecModel;
  BehaviorSubject<ComModel> _recItem = BehaviorSubject<ComModel>();

  Sink<ComModel> get _recItemSink => _recItem.sink;

  Stream<ComModel> get recItemStream => _recItem.stream.asBroadcastStream();
  BehaviorSubject<List<ComModel>> _recList = BehaviorSubject<List<ComModel>>();

  Sink<List<ComModel>> get _recListSink => _recList.sink;

  //首页文章列表相关
  BehaviorSubject<List<ReposModel>> _recRepos =
      BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _recReposSink => _recRepos.sink;

  Stream<List<ReposModel>> get recReposStream => _recRepos.stream;

  BehaviorSubject<List<ReposModel>> _recWxArticle =
      BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _recWxArticleSink => _recWxArticle.sink;

  Stream<List<ReposModel>> get recWxArticleStream => _recWxArticle.stream;

  Stream<List<ComModel>> get recListStream =>
      _recList.stream.asBroadcastStream();

  ///**项目页面相关开始**/

  BehaviorSubject<List<ReposModel>> _repos =
      BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _reposSink => _repos.sink;

  Stream<List<ReposModel>> get reposStream => _repos.stream;
  List<ReposModel> _reposList;
  int _reposPage = 0;

  ///**项目页面相关结束**/

  ///***动态页面开始***/
  BehaviorSubject<List<ReposModel>> _events =
      BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _eventSink => _events.sink;

  Stream<List<ReposModel>> get eventsStream => _events.stream;
  int _eventsPage = 0;
  List<ReposModel> _eventsList;

  ///动态页面结束*///

  ///****体系开始****/

  BehaviorSubject<List<TreeModel>> _tree = BehaviorSubject<List<TreeModel>>();

  Sink<List<TreeModel>> get _treeSink => _tree.sink;

  Stream<List<TreeModel>> get treeStream => _tree.stream;
  List<TreeModel> _treeList;

  ///****体系结束****///

  BehaviorSubject<VersionModel> _version = BehaviorSubject<VersionModel>();

  Sink<VersionModel> get _versionSink => _version.sink;

  Stream<VersionModel> get versionStream => _version.stream.asBroadcastStream();
  VersionModel _versionModel;
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
        break;
      case Ids.titleRepos:
        return getArticleListProject(labelId, page);
        break;
      case Ids.titleEvents:
        return getArticleList(labelId, page);
        break;
      case Ids.titleSystem:
        return getTree(labelId);
        break;
    }
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    switch (labelId) {
      case Ids.titleRepos:
        _page = ++_reposPage;
        break;
      case Ids.titleEvents:
        _page = ++_eventsPage;
        break;
    }
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({String labelId, bool isReload}) {
    print('onRefresh');
    print(labelId);
    switch (labelId) {
      case Ids.titleHome:
        getHotRecItem();
        break;
      case Ids.recRepos:
        _reposPage = 0;
        break;
      case Ids.titleEvents:
        _eventsPage = 0;
        break;
      case Ids.titleSystem:
        break;
    }
    return getData(labelId: labelId, page: 0);
  }

  void getHotRecItem() {
    return null;
  }

  Future getHomeData(String labelId) {
    getRecRepos(labelId);
    getRecWxArticle(labelId);
    return getBanner(labelId);
  }

  Future getRecWxArticle(String labelId) async {
    int _id = 408;
    wanRepository.getWxArticleList(id: _id).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recWxArticleSink.add(UnmodifiableListView<ReposModel>(list));
    });
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

  Future getArticleListProject(String labelId, int page) {
    return wanRepository.getArticleListProject(page).then((list) {
      if (_reposList == null) {
        _reposList = new List();
      }
      if (page == 0) {
        _reposList.clear();
      }
      _reposList.addAll(list);
      _reposSink.add(UnmodifiableListView<ReposModel>(_reposList));
      homeEventSink.add(new StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((err) {
      if (ObjectUtil.isEmpty(_reposList)) {
        _repos.sink.addError("error");
      }
      _reposPage--;
      homeEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getArticleList(String labelId, int page) {
    return wanRepository.getArticleList(page: page).then((list) {
      if (_eventsList == null) {
        _eventsList = new List();
      }
      if (page == 0) {
        _eventsList.clear();
      }
      _eventsList.addAll(list);
      _eventSink.add(UnmodifiableListView<ReposModel>(_eventsList));
      homeEventSink.add(new StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((onError) {
      if (ObjectUtil.isEmpty(_eventsList)) {
        _events.sink.addError("error");
      }
      _eventsPage--;
      homeEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getTree(String labelId) {
    return wanRepository.getTree().then((list) {
      if (_treeList == null) {
        _treeList = new List();
      }
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = Utils.getPinyin(list[i].name);
        if (RegExp("[A-Z]").hasMatch(tag)) {
          list[i].tagIndex = tag;
        } else {
          list[i].tagIndex = "#";
        }
      }
      SuspensionUtil.sortListBySuspensionTag(list);
      _treeList.clear();
      _treeList.addAll(list);
      _treeSink.add(UnmodifiableListView<TreeModel>(_treeList));
      homeEventSink.add(new StatusEvent(
          labelId,
          ObjectUtil.isEmpty(list)
              ? RefreshStatus.noMore
              : RefreshStatus.idle));
    }).catchError((_) {
      if (ObjectUtil.isEmpty(_treeList)) {
        _tree.sink.addError("error");
        homeEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
      }
    });
  }

  Future getVersion() async {
    return httpUtils.getVersion().then((model) {
      _versionModel = model;
      _versionSink.add(_versionModel);
    });
  }
}
