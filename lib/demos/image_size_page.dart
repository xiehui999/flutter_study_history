import 'dart:async';

import 'package:flutter/material.dart';
import 'package:base_library/base_library.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageSizePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ImageSizePageState();
  }
}

class ImageSizePageState extends State<ImageSizePage> {
  String cacheImgInfo1 = "[CachedNetworkImage] loading...";
  String netImgInfo1 = "[网络图片1] loading...";
  String localImgInfo1 = "[本地图片 ali_connors] loading...";
  String imageUrl =
      'http://www.dhzjw.gov.cn/UploadFiles/2017-02/459/201702/14871748657091200.jpg';

  Widget _buildItem(String info, {double height = 50}) {
    return new Container(
      alignment: Alignment.center,
      height: height,
      child: new Text(
        info,
        style: TextStyles.listContent,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.33, color: AppColors.divider))),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCachedNetworkImage();
    _loadNetImage();
    _loadlLcalImage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('获取图片尺寸'),
      ),
      body: new ListView(
        children: <Widget>[
          _buildItem(cacheImgInfo1),
          _buildItem(netImgInfo1),
          _buildItem(localImgInfo1),
        ],
      ),
    );
  }

  void _loadCachedNetworkImage() {
    Image image = new Image(image: new CachedNetworkImageProvider(imageUrl));
    image.image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        cacheImgInfo1 = "[CachedNetworkImage]" + info.toString();
      });
    }));
  }

  void _loadNetImage() {
    Image.network(imageUrl)
        .image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        netImgInfo1 = "[网络图片1]" + info.toString();
      });
    }));
  }

  void _loadlLcalImage() {
    Image.asset('assets/images/3.0x/ali_connors.png')
        .image
        .resolve(new ImageConfiguration())
        .addListener(new ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            localImgInfo1 = "本地图片 ali_connors" + info.toString();
          });
        }, onError: (dynamic exception, StackTrace stackTrace) {
          //加载失败情况
        }));
  }
}
