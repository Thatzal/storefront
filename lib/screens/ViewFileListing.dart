import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/screens/widgets/ImageView.dart';
import 'package:socialapps/screens/widgets/ImageViewByUrl.dart';
import 'package:socialapps/screens/widgets/VideoPlayerByURL.dart';
import 'package:socialapps/screens/widgets/videoPlayer.dart';
import 'package:socialapps/screens/widgets/videoPlayerFromBase64.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
class GalleryScreen extends StatefulWidget {
   List MediaList;
   List ?UrlList ;

   GalleryScreen({super.key, required this.MediaList, this.UrlList});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getThumb();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: InkWell(onTap: () {Get.back();},child: Icon(Icons.arrow_back,size: 24,color: Colors.black,)),
              title:Text("Gallery",style: AppBarTitle,),
            ),
            body: Container(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  itemCount: widget.MediaList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 4/3
                  ),
                  itemBuilder: (context, index) {
                    var data = widget.MediaList[index];
                    var url = widget.UrlList![index];
                    print(data);
            print(url);

                    return InkWell(
                      onTap: () async {

                        if( "${data["name"].toString().substring(data["name"].toString().lastIndexOf('.'))}"  == ".mp4"){
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => videoPlayerByUrl(videoUrl:  url),));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewScreenByUrl(ImageUrl:  url),));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image:
                                "${data["name"].toString().substring(data["name"].toString().lastIndexOf('.'))}" == ".mp4"?
                                DecorationImage(image: AssetImage("assets/mp4placeholder.png"),fit: BoxFit.fill)
                                    :
                                DecorationImage(image:
                                NetworkImage(url.toString()),fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          "${data["name"].toString().substring(data["name"].toString().lastIndexOf('.'))}"  == ".mp4"?    Positioned(
                              top: 30,bottom: 30,left: 30,right: 30,
                              child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(Icons.play_arrow,size: 50,color: Colors.black,))):SizedBox()
                        ],
                      ),
                    );
                  },)),
          )),
    );
  }


  // Future<String> genThumbnailFile(String videoPath) async {
  //
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //     video:videoPath,
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight: 100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //     quality: 75,
  //   );
  //   print("fileName");
  //   print(fileName);
  //   return fileName.toString();
  // }
}