import 'package:flutter/material.dart';

class RegexUtilPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RegexUtilPageState();
  }
}

class RegexType {
  String label;
  String regex;

  RegexType(this.label, this.regex);
}

class RegexUtilPageState extends State<RegexUtilPage> {
  List<RegexType> regexType = new List();
  RegexType currentRegexType = null;
  String _inputText = "";
  String _result = "";

  static const String regexMobileSimple = "MobileSimple";
  static const String regexMobileExact = "MobileExact";
  static const String regexTel = "Tel";
  static const String regexIdCard15 = "IdCard15";
  static const String regexIdCard18 = "IdCard18";
  static const String regexEmail = "Email";
  static const String regexUrl = "Url";
  static const String regexZh = "Zh";
  static const String regexDate = "Date";
  static const String regexIp = "Ip";

  @override
  void initState() {
    super.initState();
    currentRegexType = new RegexType(regexMobileSimple, "^[1]\\d{10}\$");
    regexType.add(new RegexType(regexMobileSimple, "^[1]\\d{10}\$"));
    regexType.add(new RegexType(regexMobileExact,
        "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[1,8,9]))\\d{8}\$"));
    regexType.add(new RegexType(regexTel, "^0\\d{2,3}[- ]?\\d{7,8}"));
    regexType.add(new RegexType(regexIdCard15,
        "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}\$"));
    regexType.add(new RegexType(regexIdCard18,
        "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9Xx])\$"));
    regexType.add(new RegexType(
        regexEmail, "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$"));
    regexType.add(new RegexType(regexUrl, "[a-zA-z]+://[^\\s]*"));
    regexType.add(new RegexType(regexZh, "[\\u4e00-\\u9fa5]"));
    regexType.add(new RegexType(regexDate,
        "^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\$"));
    regexType.add(new RegexType(regexIp,
        "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('正则表达式'),
        centerTitle: true,
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new SizedBox(
            width: double.infinity,
            child: new Card(
              elevation: 4.0,
              margin: EdgeInsets.all(10),
              child: new Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: regexType.map((value) {
                  return new Padding(
                    padding: EdgeInsets.only(top: 16, left: 5, right: 5),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          value.label,
                          style: new TextStyle(
                              fontSize: 13, color: Colors.grey[700]),
                        ),
                        new Checkbox(
                            value: (value.label == currentRegexType.label),
                            onChanged: (checked) {
                              setState(() {
                                currentRegexType = value;
                                inputCheck(_inputText);
                              });
                            })
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: new TextField(
              autofocus: false,
              style: new TextStyle(fontSize: 14, color: Colors.grey[700]),
              decoration: new InputDecoration(
                  hintText: '请输入...', hintStyle: new TextStyle(fontSize: 14)),
              onChanged: (value) {
                inputCheck(value);
              },
            ),
          ),
          new Container(
            alignment: Alignment.topLeft,
            height: 66,
            padding: EdgeInsets.all(16),
            child: new Text(
              _result,
              textAlign: TextAlign.start,
              style: new TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          )
        ],
      ),
    );
  }

  void inputCheck(String input) {
    _inputText = input;
    bool isCorrent = false;
    print(currentRegexType.label);
    print(currentRegexType.regex);
    if ((input ?? "").isNotEmpty && (currentRegexType.regex ?? "").isNotEmpty) {
      isCorrent = new RegExp(currentRegexType.regex).hasMatch(input);
    }
    setState(() {
      _result = currentRegexType.label + " is " + isCorrent.toString();
    });
  }
}
