import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

bool isEventsInit = true;

class EventsPage extends StatelessWidget {
  final String labelId;

  const EventsPage({Key key, this.labelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((event) {
      if (event.labelId == labelId) {
        _controller.sendBack(false, event.status);
      }
    });
    if (isEventsInit) {
      isEventsInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return new StreamBuilder(
        stream: bloc.eventsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          return new RefreshScaffold(
            controller: _controller,
            labelId: labelId,
            loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId, isReload: isReload);
            },
            onLoadMore: (up) {
              bloc.onLoadMore(labelId: labelId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, index) {
              return new ArticleItem(
                model: snapshot.data[index],
              );
            },
          );
        });
  }
}
