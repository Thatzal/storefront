
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/screens/widgets/ImageViewByUrl.dart';
import 'package:socialapps/screens/widgets/VideoPlayerByURL.dart';


ImageGalleryView(context,List MediaList, List UrlList,setState){
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return  Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 100),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          child: Container(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemCount: MediaList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4/4
                ),
                itemBuilder: (context, index) {
                  var data = MediaList[index];
                  var url = UrlList[index];
                  return GestureDetector(
                    onTap: () async {
                      print("ImageViw");
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
                                child: Icon(Icons.play_arrow,size: 50,color: Colors.black,))):SizedBox(),
                        Positioned(
                          bottom: 0,
                          right: 0,left: 0,
                          child: InkWell(
                            onTap: (){
                             setModalState((){
                               MediaList.removeAt(index);
                               UrlList.removeAt(index);
                               Navigator.pop(context);
                             });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                              ),
                              child: Center(
                                  child: Text("Remove",style: WhiteTitleStyle,)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },)),
        );
      },
    );
  },).then((value) {
    setState((){});
  });
}

ImageGalleryViewWithModal(context,setModalNewState,List MediaList, List UrlList,setState){
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return  Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 100),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          child: Container(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                itemCount: MediaList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4/4
                ),
                itemBuilder: (context, index) {
                  var data = MediaList[index];
                  var url = UrlList[index];
                  return GestureDetector(
                    onTap: () async {
                      print("ImageViw");
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
                                child: Icon(Icons.play_arrow,size: 50,color: Colors.black,))):SizedBox(),
                        Positioned(
                          bottom: 0,
                          right: 0,left: 0,
                          child: InkWell(
                            onTap: (){
                              setModalState((){
                                MediaList.removeAt(index);
                                UrlList.removeAt(index);
                                Navigator.pop(context);
                              });
                              setModalNewState((){});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                              ),
                              child: Center(
                                  child: Text("Remove",style: WhiteTitleStyle,)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },)),
        );
      },
    );
  },).then((value) {
    setState((){});
  });
}


class GalleryScreenNewOffer extends StatefulWidget {
  List MediaList;
  List ?UrlList ;

  GalleryScreenNewOffer({super.key, required this.MediaList, this.UrlList});

  @override
  State<GalleryScreenNewOffer> createState() => _GalleryScreenNewOfferState();
}

class _GalleryScreenNewOfferState extends State<GalleryScreenNewOffer> {
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