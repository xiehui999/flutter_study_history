import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/ui/pages/page_index.dart';

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
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.search), onPressed: null)
            ],
            leading: new Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(Utils.getImgPath('ali_connors')))),
            ),
            centerTitle: true,
            title: TabLayout(),
          ),
          body: new TabBarViewLayout(),
          drawer: new Drawer(child: new MainLeftPage(),),
        ));
  }
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    switch (labelId) {
      case Ids.titleHome:
        return new HomePage(
          labelId: page.labelId,
        );
        break;
      case Ids.titleRepos:
        return ReposPage(
          labelId: labelId,
        );
        break;
      case Ids.titleEvents:
        return new EventsPage(
          labelId: labelId,
        );
        break;
      case Ids.titleSystem:
        return SystemPage(
          labelId: labelId,
        );
        break;
      default:
        return Container(child: new Text('默认页面'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new TabBarView(
        children: _allPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
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
