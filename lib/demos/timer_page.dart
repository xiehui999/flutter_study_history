import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerPageState();
  }
}

class TimerPageState extends State<TimerPage> {
  int mTick = 0;
  String timerBtnTxt = "Start";
  Timer _mTimer;
  int mInterval = 1000;

  int mTotalTime = 10 * 1000;
  Timer _mCountDownTimer;
  int mCountDownTick = 0;
  String countDownBtnTxt = "Start";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    Duration duration = Duration(milliseconds: mInterval);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        mTick = timer.tick;
      });
    });
  }

  void startCountDownTimer() {
    updateCountDown(mTotalTime);
    Duration duration = new Duration(milliseconds: mInterval);
    _mCountDownTimer = Timer.periodic(duration, (Timer timer) {
      int time = mTotalTime - mInterval;
      mTotalTime = time;
      print(mTotalTime.toString()+"|||||||"+time.toString());
      if (time >= mInterval) {
        updateCountDown(time);
      } else if (time == 0) {
        updateCountDown(time);
        timer.cancel();
        _mCountDownTimer = null;
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: time), () {
          mTotalTime = 0;
          updateCountDown(0);
          timer.cancel();
          _mCountDownTimer = null;
        });
      }
    });
  }

  updateCountDown(int time) {
    setState(() {
      double _tink = time / 1000;
      if (_tink.toInt() == 0) {
        countDownBtnTxt = "Start";
        mTotalTime = 10 * 1000;
      }
      setState(() {
        mCountDownTick = _tink.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("定时器使用"),
      ),
      body: new Column(
        children: <Widget>[
          new Card(
            elevation: 4.0,
            margin: EdgeInsets.all(10),
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    height: 100,
                    color: Colors.grey[50],
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: new Text('Timer'),
                        ),
                        new Expanded(
                            flex: 1,
                            child: new Container(
                              child: new Text('${mTick}'),
                            )),
                        new InkWell(
                          child: new Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: new Text("${timerBtnTxt}"),
                          ),
                          onTap: () {
                            if (_mTimer != null && _mTimer.isActive) {
                              mTick = 0;
                              _mTimer.cancel();
                              timerBtnTxt = "Start";
                            } else {
                              startTimer();
                              timerBtnTxt = "Stop";
                            }
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ),
                  new Container(
                    height: 100,
                    color: Colors.grey[50],
                    margin: EdgeInsets.only(top: 10),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: new Text('CountDown'),
                        ),
                        new Expanded(
                            child: new Container(
                          alignment: Alignment.center,
                          child: new Text('${mCountDownTick}'),
                        )),
                        new InkWell(
                          child: new Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[100],
                            alignment: Alignment.center,
                            child: new Text('${countDownBtnTxt}'),
                          ),
                          onTap: () {
                            if (_mCountDownTimer != null &&
                                _mCountDownTimer.isActive) {
                              _mCountDownTimer.cancel();
                              countDownBtnTxt = "Start";
                            } else {
                              startCountDownTimer();
                              countDownBtnTxt = "Stop";
                            }
                            setState(() {

                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
