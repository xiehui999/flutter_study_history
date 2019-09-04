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
                          ),
                          new Checkbox(
                              value: (_dateFormat == DateFormat.NORMAL),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.NORMAL;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_NORMAL
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
                            "Y-M-D-H-M",
                            style: new TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          new Checkbox(
                              value: (_dateFormat ==
                                  DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat =
                                        DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE;
                                    inputCheck(isZH
                                        ? DateFormat
                                            .ZH_YEAR_MONTH_DAY_HOUR_MINUTE
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
                            "Y-M-D",
                            style: new TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          new Checkbox(
                              value: (_dateFormat == DateFormat.YEAR_MONTH_DAY),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.YEAR_MONTH_DAY;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_YEAR_MONTH_DAY
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(top: 16, left: 5, right: 5),
                      child: new Column(
                        children: <Widget>[
                          new Text(
                            'Y-M',
                            style: new TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          new Checkbox(
                              value: (_dateFormat == DateFormat.YEAR_MONTH),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.YEAR_MONTH;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_YEAR_MONTH
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 5.0, right: 5.0),
                      child: new Column(
                        children: <Widget>[
                          new Text("M_D",
                              style: new TextStyle(
                                  fontSize: 12.0, color: Colors.grey[700])),
                          new Checkbox(
                              value: (_dateFormat == DateFormat.MONTH_DAY),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.MONTH_DAY;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_MONTH_DAY
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 5.0, right: 5.0),
                      child: new Column(
                        children: <Widget>[
                          new Text("M_D_H_M",
                              style: new TextStyle(
                                  fontSize: 12.0, color: Colors.grey[700])),
                          new Checkbox(
                              value: (_dateFormat ==
                                  DateFormat.MONTH_DAY_HOUR_MINUTE),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat =
                                        DateFormat.MONTH_DAY_HOUR_MINUTE;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_MONTH_DAY_HOUR_MINUTE
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 5.0, right: 5.0),
                      child: new Column(
                        children: <Widget>[
                          new Text("H_M_S",
                              style: new TextStyle(
                                  fontSize: 12.0, color: Colors.grey[700])),
                          new Checkbox(
                              value: (_dateFormat ==
                                  DateFormat.HOUR_MINUTE_SECOND),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.HOUR_MINUTE_SECOND;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_HOUR_MINUTE_SECOND
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 5.0, right: 5.0),
                      child: new Column(
                        children: <Widget>[
                          new Text("H_M",
                              style: new TextStyle(
                                  fontSize: 12.0, color: Colors.grey[700])),
                          new Checkbox(
                              value: (_dateFormat == DateFormat.HOUR_MINUTE),
                              onChanged: (value) {
                                if (value) {
                                  setState(() {
                                    _dateFormat = DateFormat.HOUR_MINUTE;
                                    inputCheck(isZH
                                        ? DateFormat.ZH_HOUR_MINUTE
                                        : _dateFormat);
                                  });
                                }
                              })
                        ],
                      ),
                    )
                  ],
                ),
                new Container(
                  alignment: Alignment.topLeft,
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
          DateUtil.getZHWeekDay(DateTime.now())+"\n"+DateTime.now().toString();
    });
  }
}
