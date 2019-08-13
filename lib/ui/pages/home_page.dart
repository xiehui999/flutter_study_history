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
        builder:
            (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot) {
          return new RefreshScaffold(
            controller: _controller,
            labelId: labelId,
            loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
            enablePullUp: false,
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId);
            },
            child: new ListView(
              children: <Widget>[
                new StreamBuilder(
                    stream: bloc.recItemStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<ComModel> snapshot) {
                      ComModel model = bloc.hotRecModel;
                      if (model == null) {
                        return Container(
                          height: 0.0,
                        );
                      }
                      return Container(
                        height: 0.0,
                      );
                    }),
                buildBanner(context, snapshot.data),
                new StreamBuilder(
                    stream: bloc.recReposStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ReposModel>> snapshot) {
                      return buildRepos(context, snapshot.data);
                    })
              ],
            ),
          );
        });
  }

  /**
   * AspectRatio
   */
  Widget buildBanner(BuildContext context, List<BannerModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return Container(height: 0);
    }
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
          indicatorAlignment: AlignmentDirectional.topEnd,
          circular: true,
          interval: new Duration(seconds: 5),
          indicator: NumberSwiperIndicator(),
          children: list.map((model) {
            return InkWell(
              onTap: () {
                // TODO 跳转
              },
              child: new CachedNetworkImage(
                  fit: BoxFit.fill,
                  placeholder: (context, url) => ProgressView(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  imageUrl: model.imagePath),
            );
          }).toList()),
    );
  }

  Widget buildRepos(BuildContext context, List<ReposModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return new Container(
        height: 0.0,
      );
    }
    List<Widget> _children = list.map((model) {
      return new ReposItem(
        model,
        isHome: true,
      );
    }).toList();
    List<Widget> children = new List();
    children.add(new HeaderItem(
      leftIcon: Icons.book,
      titleId: Ids.recRepos,
      onTap: () {
        // TODO
      },
    ));
    children.addAll(_children);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
