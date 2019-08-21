import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/data/repository/wan_repository.dart';
import 'dart:collection';

class ComListBloc implements BlocBase {
  BehaviorSubject<List<ReposModel>> _comListData =
  BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _comListSink => _comListData.sink;

  Stream<List<ReposModel>> get comListStream => _comListData.stream;

  BehaviorSubject<StatusEvent> _comListEvent = BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get _comListEventSink => _comListEvent.sink;

  Stream<StatusEvent> get comListEventStream =>
      _comListEvent.stream.asBroadcastStream();
  List<ReposModel> comList;
  int _comListPage = 0;
  WanRepository wanRepository = new WanRepository();

  @override
  void dispose() {
    _comListData.close();
    _comListEvent.close();
  }

  @override
  Future getData({String labelId, int cid, int page}) {
    switch (labelId) {
      case Ids.titleReposTree:
        return getRepos(labelId, cid, page);
        break;
    }
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labelId, int cid}) {
    switch (labelId) {
      case Ids.titleReposTree:
        _comListPage = 1;
        break;
    }
    return getData(labelId: labelId, page: _comListPage, cid: cid);
  }

  Future getRepos(String labelId, int cid, int page) {
    ComReq _comReq = new ComReq(cid);
    return wanRepository
        .getProjectList(page: page, data: _comReq.toJson())
        .then((list) {
      if (comList == null) {
        comList = new List();
      }
      if (page == 1) {
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(UnmodifiableListView<ReposModel>(list));
      _comListEventSink.add(new StatusEvent(labelId,
          ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle,
          cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }
}
