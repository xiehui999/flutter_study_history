import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

typedef void OnLoadMore(bool up);
typedef OnRefreshCallback = Future<void> Function({bool isReload});

class RefreshScaffold extends StatefulWidget {
  final String labelId;
  final int loadStatus;
  final RefreshController controller;
  final bool enablePullUp;
  final OnRefreshCallback onRefresh;
  final OnLoadMore onLoadMore;
  final Widget child;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const RefreshScaffold(
      {Key key,
      this.labelId,
      this.loadStatus,
      @required this.controller,
      this.enablePullUp: true,
      this.onRefresh,
      this.onLoadMore,
      this.child,
      this.itemCount,
      this.itemBuilder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new RefreshScaffoldState();
  }
}

class RefreshScaffoldState extends State<RefreshScaffold>
    with AutomaticKeepAliveClientMixin {
  bool isShowFloatBtn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.scrollController.addListener(() {
        int offset = widget.controller.scrollController.offset.toInt();
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > 480 && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  buildFloatigActionButton() {
    if (widget.controller.scrollController == null ||
        widget.controller.scrollController.offset < 480) {
      return null;
    }
    return new FloatingActionButton(
      onPressed: () {
        widget.controller.scrollController.animateTo(0.0,
            duration: new Duration(milliseconds: 300), curve: Curves.linear);
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.keyboard_arrow_up),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new RefreshIndicator(
              child: new SmartRefresher(
                child: widget.child ??
                    new ListView.builder(
                      itemBuilder: widget.itemBuilder,
                      itemCount: widget.itemCount,
                    ),
                controller: widget.controller,
                enablePullDown: false,
                enablePullUp: widget.enablePullUp,
                enableOverScroll: false,
                onRefresh: widget.onLoadMore,
              ),
              onRefresh: widget.onRefresh)
        ],
      ),
      floatingActionButton: buildFloatigActionButton(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
