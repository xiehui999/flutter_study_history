import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class _Page {
  final String labelId;

  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  new _Page(Ids.titleHome),
  new _Page(Ids.titleRepos),
  new _Page(Ids.titleEvents),
  new _Page(Ids.titleSystem),
];

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: _allPages.length,
        child: new Scaffold(
          appBar: new MyAppBar(
            leading: new Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(Utils.getImgPath('ali_connors')))),
            ),
            centerTitle: true,
            title: TabLayout(),
          ),
        ));
  }
}

class TabLayout extends StatelessWidget {
  //indicatorSize 焦点时底部线宽度
  @override
  Widget build(BuildContext context) {
    return new TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.all(12.0),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _allPages
            .map((_Page page) => new Tab(
                  text: IntlUtil.getString(context, page.labelId),
                ))
            .toList());
  }
}
