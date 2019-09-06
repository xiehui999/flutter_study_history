import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';

class AboutPage extends StatelessWidget {
  bool isInit = true;
  ComModel github = new ComModel(
      title: 'GitHub', url: 'https://github.com/xiehui999', extra: 'Go Star');
  ComModel author = new ComModel(
      title: '简书', url: 'https://www.jianshu.com/u/d5b531888b2b', extra: '查看');
  ComModel weibo = new ComModel(
      title: '微博', url: 'https://weibo.com/745687294', extra: '问问题');

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    if (isInit) {
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.getVersion();
      });
      isInit = false;
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleAbout)),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            height: 160,
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: new Image.asset(
                    Utils.getImgPath('ali_connors'),
                    width: 72,
                    height: 72,
                    fit: BoxFit.fill,
                  ),
                ),
                Gaps.vGap10,
                new Text(
                  '版本号${AppConfig.version}',
                  style: new TextStyle(color: AppColors.gray_99, fontSize: 14),
                )
              ],
            ),
            decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border.all(width: 0.33, color: AppColors.divider)),
          ),
          new ArrowItem(github),
          new ArrowItem(author),
          new ArrowItem(weibo),
          new StreamBuilder(
              stream: bloc.versionStream,
              builder:
                  (BuildContext contex, AsyncSnapshot<VersionModel> snapshot) {
                VersionModel model = snapshot.data;
                return new Container(
                  child: Material(
                    color: Colors.white,
                    child: new ListTile(
                      onTap: () {
                        if (model == null) {
                          bloc.getVersion();
                        } else {
                          if (!Utils.isLatest(model.version)) {
                            NavigatorUtil.launchInBrowser(model.url,
                                title: model.title);
                          }
                        }
                      },
                      title: new Text('版本更新'),
                      trailing: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            model == null
                                ? ''
                                : (Utils.isLatest(model.version)
                                    ? '已是最新版本'
                                    : "有版本更新，去更新吧"),
                            style: new TextStyle(
                                color: (model != null &&
                                        Utils.isLatest(model.version)
                                    ? Colors.grey
                                    : Colors.red),
                                fontSize: 14),
                          ),
                          new Icon(
                            Icons.navigate_next,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
