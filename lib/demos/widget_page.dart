import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WidgetPageState();
  }
}

class WidgetPageState extends State<WidgetPage> {
  double testHeight = 50.0;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Widget Util'),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            child: new Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TestPage(testHeight),
              ),
            ),
          ),
          new Container(
            child: new TestPage2(),
            margin: EdgeInsets.all(10),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            setState(() {
              isOpen = !isOpen;
              testHeight = isOpen ? 100.0 : 50.0;
            });
          },
          child: new Icon(Icons.add)),
    );
  }
}

class TestPage extends StatefulWidget {
  final double _height;

  TestPage(this._height);

  @override
  State<StatefulWidget> createState() {
    return new TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  String mCenterTxt = "";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      RenderBox box = context.findRenderObject();
      if (box != null && box.semanticBounds != null) {
        setState(() {
          mCenterTxt = "width: " +
              box.semanticBounds.width.toString() +
              "height: " +
              box.semanticBounds.height.toString() +
              "\n" +
              box.semanticBounds.toString();
        });
      }
    });
    return new Container(
      height: widget._height,
      color: Colors.cyan[200],
      child: new Center(
        child: new Text(mCenterTxt),
      ),
    );
  }
}

class TestPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestPage2State();
  }
}

class TestPage2State extends State<TestPage2> {
  String defText = "点击获取Widget在屏幕上的坐标";
  String contentText = "";

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100,
      color: Colors.cyan[100],
      child: new InkWell(
        onTap: () {
          RenderBox box = context.findRenderObject();
          print(box);
          if (box == null) {
            setState(() {
              contentText = "未获取到信息";
            });
          } else {
            setState(() {
              Offset offset = box.localToGlobal(Offset.zero);
              contentText = defText + "\n" + "Offset: " + offset.toString();
            });
          }
        },
        child: new Center(
          child: new Text(contentText),
        ),
      ),
    );
  }
}
