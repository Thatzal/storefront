import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/screens/widgets/ImageView.dart';
import 'package:socialapps/screens/widgets/ImageViewByUrl.dart';
import 'package:socialapps/screens/widgets/VideoPlayerByURL.dart';
import 'package:socialapps/screens/widgets/videoPlayer.dart';
import 'package:socialapps/screens/widgets/videoPlayerFromBase64.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GalleryScreenByUrl extends StatefulWidget {
  List MediaList;

  GalleryScreenByUrl({super.key, required this.MediaList});

  @override
  State<GalleryScreenByUrl> createState() => _GalleryScreenByUrlState();
}

class _GalleryScreenByUrlState extends State<GalleryScreenByUrl> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTempPath();
  }
  var tempPath = ""  ;
  getTempPath() async{
    tempPath = (await getApplicationDocumentsDirectory()).path;
  }

  // List thumbImagePath = [];
  // getThumb() async {
  //      for(var i = 0 ; i< widget.MediaList.length;i++){
  //        if("${widget.MediaList[i]["name"].toString().substring(widget.MediaList[i]["name"].toString().lastIndexOf('.'))}"  == ".mp4"){
  //          Uint8List bytes = base64Decode(widget.MediaList[i]["file"]);
  //          String dir = (await getApplicationDocumentsDirectory()).path;
  //          String fullPath = '$dir/abc.mp4';
  //          print("local file full path ${fullPath}");
  //          File file = File(fullPath);
  //          await file.writeAsBytes(bytes);
  //          String thumpImage = await genThumbnailFile(file.path).toString();
  //          setState(() {
  //            thumbImagePath.add(thumpImage);
  //          });
  //        }else{
  //        setState(() {
  //          thumbImagePath.add(widget.MediaList[i]["name"]);
  //        });
  //        }
  //      }
  // }

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
                  itemBuilder: (context, index)  {
                    var data = widget.MediaList[index];
                    return FutureBuilder<String>(
                        future: ThumImage(data),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: Column(
                              children: [
                                LoadingWidget(),
                                Container(
                                    padding: EdgeInsets.all(3),
                                    color: Colors.white,
                                    child: Text("Loading Video file",style: BlackDescStyle,))
                              ],
                            )); // Show a loading indicator while waiting for the future to complete.
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return InkWell(
                              onTap: () async {
                                if( "${data.toString().substring(data.toString().lastIndexOf('.'))}"  == ".mp4"){
                                  await Navigator.push(context, MaterialPageRoute(builder: (context) => videoPlayerByUrl(videoUrl:  "${Url.IMAGE_URL}${data}"),));
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewScreenByUrl(ImageUrl:  "${Url.IMAGE_URL}${data}"),));
                                }
                              },
                              child: Stack(
                                children: [
                                  tempPath == ""? SizedBox():  Container(
                                    decoration: BoxDecoration(
                                        image:
                                        "${data.toString().substring(data.toString().lastIndexOf('.'))}" == ".mp4"?
                                        DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill)
                                            :
                                        DecorationImage(image:
                                        NetworkImage("${Url.IMAGE_URL}${data}"),fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                  "${data.toString().substring(data.toString().lastIndexOf('.'))}"  == ".mp4"?
                                  Positioned(
                                      top: 35,bottom: 35,left: 35,right: 35,
                                      child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.grey.shade300,
                                          child: Center(child: Icon(Icons.play_arrow,size: 30,color: Colors.black,)))):SizedBox()
                                ],
                              ),
                            );
                          }
                        }
                    );
                  },)),
          )),
    );
   }
  }

  Future <String>ThumImage(VideoPath) async {
    if(VideoPath.toString().substring(VideoPath.toString().lastIndexOf('.')) == ".mp4"){
      print("${VideoPath} Video PaTAh");
      final uint8list = await VideoThumbnail.thumbnailFile(
        video: "${VideoPath}",
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 75,
      );
      print("${uint8list.toString()}Video PaTAh 2 ");
      return uint8list.toString();
    }else{
      return VideoPath.toString();
    }
  }

