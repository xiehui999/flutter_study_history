import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

bool isReposInit = true;

class ReposPage extends StatelessWidget {
  final String labelId;

  const ReposPage({Key key, this.labelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('aaaaaaaaa');
    print(labelId);
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _controller.sendBack(false, event.status);
      }
    });

    if (isReposInit) {
      isReposInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return new StreamBuilder(
        stream: bloc.reposStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          return new RefreshScaffold(
            controller: _controller,
            labelId: labelId,
            loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId);
            },
            onLoadMore: (up) {
              bloc.onLoadMore(labelId: labelId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              ReposModel model = snapshot.data[index];
              return new ReposItem(model);
            },
          );
        });
  }
}
