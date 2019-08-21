import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class ComListPage extends StatelessWidget {
  final String labelId;
  final int cid;

  const ComListPage({Key key, this.labelId, this.cid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    bloc.comListEventStream.listen((event) {
      if (cid == event.cid) {
        _controller.sendBack(false, event.status);
      }
    });
    return new StreamBuilder(
        stream: bloc.comListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          int loadStatus =
              Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadStatus == LoadStatus.loading) {
            bloc.onRefresh(labelId: labelId, cid: cid);
          }
          return new RefreshScaffold(
            controller: _controller,
            labelId: cid.toString(),
            loadStatus: loadStatus,
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId, cid: cid);
            },
            onLoadMore: (up) {
              bloc.onLoadMore(labelId: labelId, cid: cid);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              ReposModel model = snapshot.data[index];
              return labelId == Ids.titleReposTree
                  ? ReposItem(model)
                  : new ArticleItem(
                      model: model,
                    );
            },
          );
        });
  }
}
