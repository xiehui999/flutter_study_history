import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

bool isSysyemPage = true;

class SystemPage extends StatelessWidget {
  final String labelId;

  const SystemPage({Key key, this.labelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    if (isSysyemPage) {
      isSysyemPage = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return new StreamBuilder(
        stream: bloc.treeStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
          return RefreshScaffold(
            controller: _controller,
            labelId: labelId,
            loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
            enablePullUp: false,
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId, isReload: isReload);
            },
            itemCount: snapshot.data==null?0:snapshot.data.length,
            itemBuilder: (BuildContext context,int index){
              TreeModel treeModel=snapshot.data[index];
              return new TreeItem(treeModel);
            },
          );
        });
  }
}
