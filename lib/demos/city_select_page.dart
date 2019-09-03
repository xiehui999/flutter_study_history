import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_history/common/component_index.dart';
import 'dart:convert';
import 'package:lpinyin/lpinyin.dart';

class CityInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  CityInfo({this.name, this.tagIndex, this.namePinyin});

  CityInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'] == null ? '' : json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension,
      };

  @override
  String getSuspensionTag() {
    return tagIndex;
  }

  @override
  String toString() =>
      "CityBean {" +
      " \"name\":\"" +
      name +
      "\"" +
      " ,\"tagIndex\":\"" +
      tagIndex +
      "\"" +
      " ,\"namePinyin\":\"" +
      namePinyin +
      "\"" '}';
}

class CitySelectPage extends StatefulWidget {
  final String title;

  CitySelectPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return new CitySelectPageState();
  }
}

class CitySelectPageState extends State<CitySelectPage> {
  List<CityInfo> _cityList = new List();
  List<CityInfo> _hotCityList = new List();
  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('assets/data/china.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((value) {
        _cityList.add(CityInfo(name: value['name']));
      });
      _handleList(_cityList);
      _hotCityList.add(CityInfo(name: '北京市', tagIndex: '热门'));
      _hotCityList.add(CityInfo(name: '广州市', tagIndex: '热门'));
      _hotCityList.add(CityInfo(name: '成都市', tagIndex: '热门'));
      _hotCityList.add(CityInfo(name: '深圳市', tagIndex: '热门'));
      _hotCityList.add(CityInfo(name: '杭州市', tagIndex: '热门'));
      _hotCityList.add(CityInfo(name: '武汉市', tagIndex: '热门'));
      _hotCityList.add(CityInfo(name: '郑州市', tagIndex: '热门'));
      setState(() {
        _suspensionTag = _hotCityList[0].getSuspensionTag();
      });
    });
  }

  void _handleList(List<CityInfo> cityList) {
    if (cityList == null || cityList.isEmpty) return;
    for (int i = 0, length = cityList.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(cityList[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();

      cityList[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        cityList[i].tagIndex = tag;
      } else {
        cityList[i].tagIndex = "#";
      }
    }
    print(cityList);
    SuspensionUtil.sortListBySuspensionTag(cityList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            height: 50.0,
            child: new Text('当前城市：成都市'),
          ),
          Expanded(
              flex: 1,
              child: new AzListView(
                data: _cityList,
                topData: _hotCityList,
                itemBuilder: (context, model) => _buildListItem(model),
                suspensionWidget: _buildSusWidget(_suspensionTag),
                isUseRealIndex: true,
                itemHeight: _itemHeight,
                suspensionHeight: _suspensionHeight,
                onSusTagChanged: _onSusTagChanged,
              ))
        ],
      ),
    );
  }

  _buildListItem(CityInfo model) {
    return Column(
      children: <Widget>[
        Offstage(
          offstage: !(model.isShowSuspension == true),
          child: _buildSusWidget(model.getSuspensionTag()),
        ),
        SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
            title: new Text(model.name),
            onTap: () {
              Navigator.pop(context, model);
            },

          ),
        )
      ],
    );
  }

  _buildSusWidget(String suspensionTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: EdgeInsets.only(left: 15),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: new Text(
        suspensionTag,
        softWrap: false,
        style: TextStyle(fontSize: 14, color: Color(0xff999999)),
      ),
    );
  }

  void _onSusTagChanged(String value) {
    print('_onSusTagChanged');
    print(value);
    setState(() {
      _suspensionTag = value;
    });
  }
}
