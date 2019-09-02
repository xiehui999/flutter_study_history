import 'package:flutter/material.dart';
import 'package:flutter_study_history/utils/util_index.dart';
import 'package:flutter_study_history/utils/navigator_util.dart';
import 'package:flutter_study_history/demos/index.dart';

class ItemModel {
  String title;
  Widget page;

  ItemModel(this.title, this.page);
}

class MainDemosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainDemosPageState();
  }
}

class MainDemosPageState extends State<MainDemosPage> {
  List<ItemModel> mItemList = new List();

  @override
  void initState() {
    super.initState();
    mItemList.add(new ItemModel('GitHub首页', null));
    mItemList.add(new ItemModel('汉字转拼音', new PinyinPage('汉字转拼音')));
    mItemList.add(new ItemModel('城市列表', null));
    mItemList.add(new ItemModel('Date Util', null));
    mItemList.add(new ItemModel('Regex Util', null));
    mItemList.add(new ItemModel('Widget Util', null));
    mItemList.add(new ItemModel('Timer Util', null));
    mItemList.add(new ItemModel('Money Util', null));
    mItemList.add(new ItemModel('Timeline Util', null));
    mItemList.add(new ItemModel('圆形/圆角头像"', null));
    mItemList.add(new ItemModel('获取图片尺寸', null));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demos'),
        centerTitle: true,
      ),
      body: new ListView.builder(
          itemCount: mItemList.length,
          itemBuilder: (BuildContext context, int index) {
            ItemModel model = mItemList[index];
            return buildItem(model);
          }),
    );
  }

  Widget buildItem(ItemModel model) {
    return new InkWell(
      onTap: () {
        if (model.page == null) {
          NavigatorUtil.pushWeb(context,
              url: 'https://github.com/xiehui999', title: 'GitHub首页');
        } else {
          NavigatorUtil.pushPage(context, model.page, pageName: model.title);
        }
      },
      child: new Container(
        height: 50,
        child: new Center(
          child: new Text(
            model.title,
            style: new TextStyle(color: Color(0xFF666666), fontSize: 14),
          ),
        ),
        decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(width: 0.33, color: Color(0xffefefef)),
            borderRadius: BorderRadius.all(Radius.circular(2))),
      ),
    );
  }
}
