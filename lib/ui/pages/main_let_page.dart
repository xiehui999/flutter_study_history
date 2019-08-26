import 'package:flutter/material.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'package:flutter_study_history/ui/pages/page_index.dart';

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}

class MainLeftPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainLeftPageState();
  }
}

class MainLeftPageState extends State<MainLeftPage> {
  List<PageInfo> _pageInfo = new List();
  PageInfo loginOut =
      PageInfo(Ids.titleSignOut, Icons.power_settings_new, null);
  String _userName;

  @override
  void initState() {
    super.initState();
    _pageInfo.add(PageInfo(Ids.titleCollection, Icons.collections, null));
    _pageInfo.add(PageInfo(Ids.titleSetting, Icons.settings, null));
    _pageInfo.add(PageInfo(Ids.titleAbout, Icons.info, null));
    _pageInfo.add(PageInfo(Ids.titleShare, Icons.share, null));
  }

  @override
  Widget build(BuildContext context) {
    if (Util.isLogin()) {
      _pageInfo.add(loginOut);
      UserModel userModel =
          SpHelper.getObject<UserModel>(BaseConstant.keyUserModel);
      _userName = userModel?.username ?? "";
    } else {
      _userName = "Code4Android";
      if (_pageInfo.contains(loginOut)) {
        _pageInfo.remove(loginOut);
      }
    }
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            height: 176,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().statusBarHeight, left: 10.0),
            child: new Stack(
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      width: 64,
                      height: 64,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage(Utils.getImgPath('ali_connors')))),
                    ),
                    new Text(
                      _userName,
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Gaps.vGap5,
                    new Text(
                      '个人简介',
                      style: new TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
                new Align(
                  alignment: Alignment.topRight,
                  child: new IconButton(
                      icon: new Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: null),
                )
              ],
            ),
          ),
          new Container(
            height: 50,
            child: new Material(
              color: Colors.grey[200],
              child: new InkWell(
                onTap: () {},
                child: new Center(
                  child: new Text(
                    'Flutter Demos',
                    style: new TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
              child: new ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  itemCount: _pageInfo.length,
                  itemBuilder: (BuildContext context, int index) {
                    PageInfo pageInfo = _pageInfo[index];
                    return new ListTile(
                      leading: new Icon(pageInfo.iconData),
                      title:
                          Text(IntlUtil.getString(context, pageInfo.titleId)),
                      onTap: (){
                        NavigatorUtil.pushPage(context,pageInfo.page);
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
