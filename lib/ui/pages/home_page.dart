import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

bool isHomeInit = true;

class HomePage extends StatelessWidget {
  final String labelId;

  const HomePage({Key key, this.labelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _controller.sendBack(false, event.status);
      }
    });
    if (isHomeInit) {
      isHomeInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh(labelId: labelId);
      });
    }
    return new StreamBuilder(
        stream: bloc.bannerStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<BannerModel>> snapshot) {
          return new Refresh
        });
  }
}
