import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/model/TrendingPersonModel.dart';
import 'package:socialapps/screens/Dashboard/home/OtherUserProfileViewScreen.dart';

import '../../common/style.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
class TrendingPeople extends StatefulWidget {
  const TrendingPeople({Key? key}) : super(key: key);
  @override
  State<TrendingPeople> createState() => _TrendingPeopleState();
}

class _TrendingPeopleState extends State<TrendingPeople> {
  bool isLoadRTrendingPlacedOffer = false;
  List<TrendingPersonData> TrendingPlacePeopleDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  load(){
    DrawAuraAPi.getTrendingPersonPlace( limit: 0.toString()).then((TrendingPlaceRes) {
      if(TrendingPlaceRes.isNotEmpty) {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            setState(() {
              TrendingPlacePeopleDataList = TrendingPlaceRes;
              isLoadRTrendingPlacedOffer = true;
            });
          }
        },);
      }else{
        if (mounted) {
          setState(() {
            isLoadRTrendingPlacedOffer = true;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return Scaffold(
        backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
        body: responsiveContainer(context,
            ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading:InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back,color: Colors.black,)),
                title: const Text("Trending People / Place",style: AppBarTitle,),
                elevation: 0,
              ),
              body:isLoadRTrendingPlacedOffer == false ? Center(child: LoadingWidget()):
              TrendingPlacePeopleDataList.isEmpty ? Center(
                child: NotAvailableText("Not found!")
              ):
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                child: GridView.builder(
                  gridDelegate:
                   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: ResponsiveHelper.isMobile(context)?2 / 1.8 :2 / 1.4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 2,
                  ),

                  itemCount: TrendingPlacePeopleDataList.length,
                  itemBuilder: (context, index) {
                    var data = TrendingPlacePeopleDataList[index];
                    return  InkWell(
                      onTap: (){
                        Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                      },
                      child: Container(
                        // margin: const EdgeInsets.only(right: 10),
                        width: isMobile?width*5:tabWidth*0.5,
                        child:    Stack(
                          children: [
                            Container(
                              width: isMobile?width*5:tabWidth*0.5,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                  image: data.profilePicture.toString() == "null"? DecorationImage(image: AssetImage("assets/home.png"), fit: BoxFit.fill):DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.profilePicture}"), fit: BoxFit.fill)),
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                    color: Colors.black45,
                                    width: isMobile?width*5:tabWidth*0.5,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        2.height,


                                        Text("${data.displayname.toString()} - ${data.placeORperson.toString().toUpperCase()}",style: WhiteSubTitleStyle),
                                        2.height,
                                      ],
                                    )
                                )
                            ),
                          ],
                        ),
                      ),
                    );
                  }, ),
              )
          )),
    );
  }
}
