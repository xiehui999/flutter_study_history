import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class DatePage extends StatefulWidget {
  final String title;

  DatePage(this.title);

  @override
  State<StatefulWidget> createState() {
    return new DatePageState();
  }
}

class DatePageState extends State<DatePage> {
  DateFormat _dateFormat = DateFormat.NORMAL;
  bool isZH = true;
  String _checkResult = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(top: 16, left: 5, right: 5),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            'Is ZH',
                            style: new TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          new Checkbox(
                              activeColor: Colors.red,
                              value: (isZH == true),
                              onChanged: (value) {
                                setState(() {
                                  isZH = value;
                                });
                              })
                        ],
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 16, left: 5, right: 5),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            'DEFAULT',
                            style: new TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          new Checkbox(
                              value: (_dateFormat == DateFormat.DEFAULT),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.DEFAULT;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_DEFAULT
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 16, left: 5, right: 5),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            "NORMAL",
                            style: new TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                new Container(
                  alignment: Alignment.topLeft,
                  height: 80,
                  padding: EdgeInsets.all(16),
                  child: new Text(
                    _checkResult,
                    textAlign: TextAlign.start,
                    style: new TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void inputCheck(DateFormat dateFormat) {
    setState(() {
      _checkResult = "Now:   " +
          DateUtil.getDateStrByMs(DateTime.now().millisecondsSinceEpoch,
              format: dateFormat) +
          "\n" +
          DateUtil.getWeekDay(DateTime.now()) +
          "   " +
          DateUtil.getZHWeekDay(DateTime.now());
    });
  }
}
