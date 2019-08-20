import 'dart:collection';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/data/repository/wan_repository.dart';

class TabBloc implements BlocBase {
  BehaviorSubject<List<TreeModel>> _tabTree =
      BehaviorSubject<List<TreeModel>>();

  Sink<List<TreeModel>> get _tabTreeSink => _tabTree.sink;

  Stream<List<TreeModel>> get tabTreeStream => _tabTree.stream;
  List<TreeModel> treeList;
  WanRepository wanRepository = new WanRepository();

  @override
  void dispose() {
    _tabTree.close();
  }

  @override
  Future getData({String labelId, int page}) {
    switch (labelId) {
      case Ids.titleReposTree:
        return getProjectTree(labelId);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(labelId: labelId);
  }

  void bindSystemData(TreeModel model) {
    if (model == null) return;
    treeList = model.children;
  }

  Future getProjectTree(String labelId) {
    return wanRepository.getProjectTree().then((list) {
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(list));
    });
  }
}
