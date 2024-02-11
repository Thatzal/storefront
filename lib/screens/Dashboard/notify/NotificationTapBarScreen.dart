import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetNotificationsModal.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/screens/Dashboard/notify/AllNotificationScreen.dart';
import 'package:socialapps/screens/Dashboard/notify/OfferNotificationScreen.dart';
import 'package:socialapps/screens/Dashboard/notify/RecentNotificationScreen.dart';
import 'package:socialapps/screens/Dashboard/notify/SystemNotificationScreen.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'package:get/get.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
class NotifyScreen extends StatefulWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  bool ALlNotificationLoader = true;
  bool SystemNotificationLoader = true;
  bool RecentNotificationLoader = true;
  bool OfferNotificationLoader = true;
  TabController? _tabController;
  List<NotificationListModel> NotificationList = [];
  List<NotificationListModel> OfferNotificationList = [];
  List<NotificationListModel> SystemNotificationList = [];
  List<NotificationListModel> RecentNotificationList = [];

  load(){
    DrawAuraAPi.getNotificationsListApi(user_Id: DataManager.getInstance().getuserId().toString()).then((AllNotificationData) {
      print(AllNotificationData);
      if(mounted){
        setState(() {
          NotificationList = [];
          OfferNotificationList = [];
          SystemNotificationList = [];
          RecentNotificationList = [];

          NotificationList = AllNotificationData;
          RecentNotificationList = AllNotificationData;
          ALlNotificationLoader = false;
          for(var i = 0 ;i <AllNotificationData.length; i++ ){
            // final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${AllNotificationData[i].notifyingTimestamp.toString()}');
            // final currentTime = DateTime.now();
            // final diff_hr = currentTime.difference(startTime).inHours;
            //      print(diff_hr);
            // if(diff_hr <=  24 ){
            //   RecentNotificationList.add(AllNotificationData[i]);
            //   RecentNotificationLoader = false;
            // }
          if( AllNotificationData[i].type.toString().trim().toUpperCase() == "EXPIRED"
              || AllNotificationData[i].type.toString().trim().toUpperCase() == "FOLLOW"
            ){
              SystemNotificationList.add(AllNotificationData[i]);
              SystemNotificationLoader = false;
            }else if(
                AllNotificationData[i].type.toString().trim().toUpperCase() == "COUNTEROFFER" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "INFORM" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "DUPLICATE" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "TEMPLATE" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "FAVOURITE" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "MAINOFFER" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "ITEMSELECTED" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "DISLIKE" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "LIKE" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "MATCH" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "COMMENT" ||
                AllNotificationData[i].type.toString().trim().toUpperCase() == "OFFEREXPIRED"
            ){
              OfferNotificationList.add(AllNotificationData[i]);
              OfferNotificationLoader = false;
            }
          }
        });
      }
    }).whenComplete(() {
      Future.delayed(Duration(seconds: 3),() {
        if(mounted){
          setState(() {
            ALlNotificationLoader = false;
            SystemNotificationLoader = false;
            OfferNotificationLoader = false;
            RecentNotificationLoader = false;
          });
        }
      },);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    load();
    super.initState();
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
              backgroundColor: Colors.white,
              titleSpacing: 40,
              title: const Text("Notifications", style: AppBarTitle,
              ),
              automaticallyImplyLeading: false,
              actions: [
                InkWell(onTap: () {Get.to(()=> NewOfferCreateScreen(Address: "",AddressTitle: "",From: "New",PrefillOfferData: PrefillOfferDataModel(),Type: "",OfferId: "",SubId: ""));},
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(8),
                    decoration:  BoxDecoration(shape: BoxShape.circle, color:Constants.primaryColor1,
                      boxShadow: [
                        BoxShadow(
                          color:Constants.primaryColor20,
                          blurRadius: 1.5,
                          spreadRadius: 2,
                          offset: Offset(
                            0,
                            3,
                          ),
                        )
                      ],
                    ),
                    child: Center(child: Image.asset("assets/edit.png",height: 22,width: 22,color: Constants.white),),
                  ),)
              ],
            ),
            body: DefaultTabController(
              length:4,
              animationDuration: const Duration(milliseconds: 200),
              initialIndex: 0,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // color: Colors.black12,
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color:  Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFD2D0D0),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(0,4)
                          )
                        ]

                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 35,
                    child: TabBar(
                      labelColor: Colors.black,
                      controller: _tabController,
                      isScrollable: true,
                      indicatorWeight: 3.0,
                      indicatorColor:Colors.black,
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                      labelPadding: EdgeInsets.zero,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: BlackTabStyle,
                      tabs: <Widget>[
                        Tab(
                          // icon:Icon(Icons.home_outlined),
                          child:Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7.0),
                            decoration: const BoxDecoration(
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:Radius.circular(10) ),
                            ),
                            child: const Text('On offers',style: BlackTabStyle,),),
                        ),
                        Tab(
                          // icon:Icon(Icons.home_outlined),
                          child:Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7.0),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('System',style: BlackTabStyle,),),
                        ),
                        Tab(
                          // icon:Icon(Icons.home_outlined),
                          child:Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4.0),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Closing',style: BlackTabStyle,),),
                        ),
                        Tab(
                          // icon:Icon(Icons.home_outlined),
                          child:Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7.0),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('All',style: BlackTabStyle,),),
                        ),

                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TabBarView(
                      controller: _tabController,
                      children:  [
                        RefreshIndicator(
                          onRefresh: () async{
                            await  load();
                            return Future.value();
                          },
                          child: OfferNotificationScreen(OfferNotificationDataList: OfferNotificationList,OfferNotificationLoader: OfferNotificationLoader),
                        ),
                        RefreshIndicator(
                          onRefresh: () async{
                            await  load();
                            return Future.value();
                          },
                          child: SystemNotificationScreen(SystemNotificationDataList: SystemNotificationList,SystemNotificationLoader: SystemNotificationLoader),
                        ),
                        RefreshIndicator(
                          onRefresh: () async{
                            await  load();
                            return Future.value();
                          },
                          child:  RecentNotificationScreen(RecentNotificationDataList: RecentNotificationList,recentNotificationLoader: RecentNotificationLoader),
                        ),
                        RefreshIndicator(
                          onRefresh: () async{
                            await  load();
                            return Future.value();
                          },
                          child: AllNotificationScreen(AllNotificationDataList: NotificationList,AllNotificationLoader: ALlNotificationLoader),
                        ),



                      ],
                    ),
                  ),
                ],
              ),
            )
          )),
    );
  }
}
