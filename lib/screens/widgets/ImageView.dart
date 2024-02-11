
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';

class ImageViewScreen extends StatefulWidget {
  var videoUrl;
  ImageViewScreen({Key? key,this.videoUrl}) : super(key: key);

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
           Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text("Image View",style: AppBarTitle,),

              ),
              body: Container(
                  child: PhotoView(
                    imageProvider: MemoryImage(base64Decode(widget.videoUrl)),
                  )
              )
          )),
    );
  }
}
