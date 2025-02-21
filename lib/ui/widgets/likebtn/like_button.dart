import 'package:flutter/material.dart';
import 'model.dart';
import 'dot_painter.dart';

typedef LikeCallBack = void Function(bool isLike);

class LikeButton extends StatefulWidget {
  final double width;
  final LikeIcon icon;
  final Duration duration;
  final DotColor dotColor;
  final Color circleStartColor;
  final Color circleEndColor;
  final LikeCallBack onIconClicked;

  const LikeButton(
      {Key key,
      @required this.width,
      this.icon = const LikeIcon(
        Icons.favorite,
        iconColor: Colors.pinkAccent,
      ),
      this.duration = const Duration(milliseconds: 5000),
      this.dotColor = const DotColor(
        dotPrimaryColor: const Color(0xFFFFC107),
        dotSecondaryColor: const Color(0xFFFF9800),
        dotThirdColor: const Color(0xFFFF5722),
        dotLastColor: const Color(0xFFF44336),
      ),
      this.circleStartColor = const Color(0xFFFF5722),
      this.circleEndColor = const Color(0xFFFFC107),
      this.onIconClicked})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new LikeButtonState();
  }
}

class LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> outerCircle;
  Animation<double> interCircle;
  Animation<double> scale;
  Animation<double> dots;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() {
            setState(() {});
          });
    _initAllAmimations();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CustomPaint(
          size: Size(widget.width, widget.width),
          painter: DotPainter(
            currentProgress: dots.value,
            color1: widget.dotColor.dotPrimaryColor,
            color2: widget.dotColor.dotSecondaryColor,
            color3: widget.dotColor.dotThirdColorReal,
            color4: widget.dotColor.dotLastColorReal,
          ),
        ),
        new Container(
          width: widget.width,
          height: widget.width,
          alignment: Alignment.center,
          child: Transform.scale(
              scale: isLiked ? scale.value : 1.0,
              child: GestureDetector(
                child: Icon(
                  widget.icon.icon,
                  color: isLiked ? widget.icon.iconColor : Colors.grey,
                  size: widget.width * 0.4,
                ),
                onTap: _onTap,
              )),
        )
      ],
    );
  }

  void _initAllAmimations() {
    outerCircle = new Tween<double>(begin: 0.1, end: 1.2).animate(
        new CurvedAnimation(
            parent: _controller,
            curve: new Interval(0.2, 0.5, curve: Curves.ease)));
    interCircle = new Tween<double>(begin: 0.2, end: 1.0).animate(
        new CurvedAnimation(
            parent: _controller,
            curve: new Interval(0.2, 0.5, curve: Curves.ease)));
    scale = new Tween<double>(begin: 0.2, end: 1.0).animate(new CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.35, 0.7, curve: OvershootCurve())));
    dots = new Tween<double>(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.1, 1.0, curve: Curves.decelerate)));
  }

  void _onTap() {
    if (_controller.isAnimating) return;
    isLiked = !isLiked;
    if (isLiked) {
      _controller.reset();
      _controller.forward();
    } else {
      setState(() {});
    }
    if (widget.onIconClicked != null) widget.onIconClicked(isLiked);
  }
}
