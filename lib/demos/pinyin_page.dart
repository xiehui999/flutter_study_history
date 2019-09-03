import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:flustars/flustars.dart';

class PinyinPage extends StatefulWidget {
  final String title;

  PinyinPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return new PinyinPageState();
  }
}

class PinYinItem {
  String title;
  int type;
  PinyinFormat format;

  PinYinItem(this.title, this.type, this.format);
}

class PinyinPageState extends State<PinyinPage> {
  TextEditingController controller = new TextEditingController();
  String _inputText = '大前端工程师';
  PinyinFormat _pinyinFormat = PinyinFormat.WITH_TONE_MARK;
  String _pinyinResult;
  static const int TYPE_PINYIN = 1;
  static const int TYPE_SIMPLIFIED = 2;
  static const int TYPE_TRADITIONAL = 3;
  int _convertType = TYPE_PINYIN;
  WidgetUtil widgetUtil = new WidgetUtil();
  List<PinYinItem> typeList = new List();

  @override
  void initState() {
    super.initState();
    typeList
        .add(new PinYinItem('带声调', TYPE_PINYIN, PinyinFormat.WITH_TONE_MARK));
    typeList
        .add(new PinYinItem('不带声调', TYPE_PINYIN, PinyinFormat.WITHOUT_TONE));
    typeList.add(
        new PinYinItem('带数字声调', TYPE_PINYIN, PinyinFormat.WITH_TONE_NUMBER));
    typeList.add(new PinYinItem('繁->简', TYPE_SIMPLIFIED, null));
    typeList.add(new PinYinItem('简->繁', TYPE_TRADITIONAL, null));
  }

  @override
  Widget build(BuildContext context) {
    widgetUtil.asyncPrepare(context, true, (Rect rect) {});
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          new Card(
            elevation: 4.0,
            margin: EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: typeList.map((item) {
                    return new Padding(
                      padding: EdgeInsets.only(top: 16, left: 5, right: 5),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            item.title,
                            style: new TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          new Checkbox(
                              value: ((_pinyinFormat == null ||
                                      (_pinyinFormat == item.format)) &&
                                  _convertType == item.type),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _convertType = item.type;
                                    _pinyinFormat = item.format;
                                    convertToPinyin(_inputText);
                                  });
                                }
                              })
                        ],
                      ),
                    );
                  }).toList(),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: new TextField(
                    controller: controller,
                    autofocus: false,
                    onChanged: (value) {
                      textChange(value);
                    },
                    style: new TextStyle(fontSize: 14, color: Colors.grey[900]),
                    decoration: new InputDecoration(
                        hintText: '请输入',
                        hintStyle: new TextStyle(fontSize: 14)),
                  ),
                ),
                new Container(
                  alignment: Alignment.topLeft,
                  height: 66,
                  padding: EdgeInsets.all(10),
                  child: new Text(
                    '$_pinyinResult',
                    textAlign: TextAlign.start,
                    style: new TextStyle(color: Colors.grey[900], fontSize: 14),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void textChange(String text) {
    _inputText = text;
    if (text == null || text.length == 0) {
      setState(() {
        _pinyinResult = "";
      });
    } else {
      setState(() {
        convertToPinyin(text);
      });
    }
  }

  void convertToPinyin(String text) {
    switch (_convertType) {
      case TYPE_PINYIN:
        try {
          _pinyinResult = PinyinHelper.getPinyin(text,
              separator: " ",
              format: _pinyinFormat ?? PinyinFormat.WITH_TONE_MARK);
        } catch (ex) {
          _pinyinResult = ex.toString();
        }
        break;
      case TYPE_SIMPLIFIED:
        _pinyinResult = ChineseHelper.convertToSimplifiedChinese(text);
        break;
      case TYPE_TRADITIONAL:
        _pinyinResult = ChineseHelper.convertToTraditionalChinese(text);
        break;
    }
  }
}
