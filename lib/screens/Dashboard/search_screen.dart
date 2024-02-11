import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/SearchPageController.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/screens/Dashboard/home/OtherUserProfileViewScreen.dart';
import 'package:socialapps/screens/Reaction/reactionList.dart';
import 'package:socialapps/screens/search/Templates_all.dart';
import 'package:socialapps/screens/search/Trending%20people.dart';
import 'package:socialapps/screens/search/all_recent_serach.dart';
import 'package:socialapps/screens/search/all_trending_serach.dart';
import 'package:socialapps/screens/search/recommanded_offer.dart';
import 'package:socialapps/screens/search/trending%20offers.dart';
import 'package:socialapps/screens/widgets/Notification_permission_bottomSheet.dart';
import 'package:socialapps/screens/widgets/OfferCradCommonFunction.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import '../../common/style.dart';
import '../GlobalSearch.dart';
import '../newOfferPage.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SearchPageController>(
        init: SearchPageController(),
        initState: (value) async {
          print("SearchInit");
          value.controller!.RecentSearch();
          value.controller!.TrendingSearch();
          value.controller!.getChoice();
          value.controller!.getRecentViewOffer();
          value.controller!.getTrendingPerson();
          value.controller!.getTemplates();
          value.controller!.getTreadingOffer();
          value.controller!.getRecommendedOffer();
          Timer(Duration(milliseconds: 50), () async {
            try {
              if (Platform.isAndroid) {
                await Permission.notification.isDenied.then((permission) async {
                  if (permission) {
                    Notification_permission_dialog(context).then((Notify) async {
                      value.controller!.enableNotification.value = await Permission.notification.isGranted;
                    });
                  } else {
                    value.controller!.enableNotification.value = true;
                  }
                });
              } else {
                var permissionNotificationStatus = await Permission.notification.status;

                if (!permissionNotificationStatus.isGranted) {
                  Notification_permission_dialog(context).then((Notify) async {
                    value.controller!.enableNotification.value = await Permission.notification.isGranted;
                  });
                } else {
                  value.controller!.enableNotification.value = true;
                }
              }
            } catch (e) {
              print('error in catch init state ${e}');
            }
          });
          value.controller!.scrollCommentsController = ScrollController();
        },
         // dispose: (value){
         //    value.controller!.scrollCommentsController.dispose();
         // },
       builder: (controller) {
         var width = MediaQuery.of(context).size.width;
         var height = MediaQuery.of(context).size.height;
         var tabWidth = ResponsiveHelper.TabModeWidth;
         var tabHeight = ResponsiveHelper.TabModeHeight;
         var isMobile= ResponsiveHelper.isMobile(context);
         return Scaffold(
           backgroundColor: Constants.newBackground,
           appBar: AppBar(
             elevation: 0,
             backgroundColor: Colors.white,
             title: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Flexible(
                   child: InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>
                           GlobalSearchScreen(SearchText: "",RecentSearch: controller.RecentSearchList,TreandingSearch: controller.TrendingSearchDataList),)).then((value) {
                         controller.TrendingSearch();
                         controller.RecentSearch(); });
                       //  Navigator.push(context, MaterialPageRoute(builder: (context) => CupertinoPickerExample(),));
                     },
                     child: Container(
                       height: 42,
                       margin: const EdgeInsets.only(right: 10,left:2,top: 5,bottom: 5),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(5),
                         boxShadow: [
                           BoxShadow(
                             color:Colors.grey.shade400,
                             blurRadius: 1.5,
                             spreadRadius: 1.5,
                           )
                         ],
                       ),
                       child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             15.width,
                             Flexible(child: Text("${Url.searchHint}",style:  greyHintStyle,overflow: TextOverflow.ellipsis,))
                       ] ),
                     ),
                   ),

                 ),
                 InkWell(
                   onTap:(){
                     Get.to(()=> NewOfferCreateScreen(Address: "",AddressTitle: "",From: "New",PrefillOfferData: PrefillOfferDataModel(),Type: "",OfferId: "",SubId: ""));
                   },
                   child: Container(
                     padding: EdgeInsets.all(8),
                     decoration: const BoxDecoration(shape: BoxShape.circle, color:Constants.primaryColor1,
                       boxShadow: [
                         BoxShadow(
                           color:Constants.primaryColor20,
                           blurRadius: 1.5,
                           spreadRadius: 1.5,
                           offset: Offset(
                             0,
                             3,
                           ),
                         )
                       ],
                     ),
                     child: Center(child: Image.asset("assets/edit.png",height: 22,width: 22,color: Constants.white),),
                   ),
                 ),
               ],

             ),
           ),
           body: Stack(
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 0),
                 child: RefreshIndicator(
                   onRefresh: () async {
                     await controller.getChoice();
                     await controller.getRecentViewOffer();
                     await controller.TrendingSearch();
                     await controller.RecentSearch();
                     await controller.getTrendingPerson();
                     await controller.getTemplates();
                     await controller.getTreadingOffer();
                     await controller.getRecommendedOffer();
                     return Future.value();
                   },
                   child: SingleChildScrollView(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:  [
                             Text("Recent Searches",style: BlackTitleStyle,),
                             Spacer(),
                             InkWell(
                                 onTap:(){
                                   Get.to(()=>AllRecentSearchScreen(RecentSearchList: controller.RecentSearchList.value,))!.then((value) {
                                     controller.TrendingSearch();
                                     controller.RecentSearch();
                                   });
                                 },
                                 child: Text("   ",style: PrimaryColorHeadStyle,)),
                             SizedBox(width: 5,),
                             Icon(Icons.arrow_forward,color: Constants.primaryColor1,size: 20,)
                           ],
                         ),
                         const SizedBox(width: 10,),
                         AnimatedSwitcher(duration: Duration(milliseconds: 10),
                           child: controller.isLoadRRecentSearch.value == false ?
                           ShimmerCardLoadingBuilder(context):
                           controller.RecentSearchList.isEmpty?
                           Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("Recent Searches not available!",style: greySubTitleItalicStyle,textAlign: TextAlign.center,),
                               ],
                             ),
                           ) :
                           SizedBox(
                             height: 45,
                             width: double.infinity,
                             child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                               physics: const ClampingScrollPhysics(),
                               shrinkWrap: true,
                               itemCount: controller.RecentSearchList.length >5 ? 5 :controller.RecentSearchList.length,
                               itemBuilder: (context, index) {
                                 var RecentSearchData = controller.RecentSearchList[index];

                                 return InkWell(
                                   onTap:(){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => GlobalSearchScreen(SearchText:RecentSearchData.searchText.toString(),RecentSearch: [], TreandingSearch: [] ),)).then((value) {
                                       controller.TrendingSearch();
                                       controller.RecentSearch();
                                     });
                                   },
                                   child: Container(
                                     margin: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                                     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                     decoration: BoxDecoration(color: Constants.greyLight, borderRadius: BorderRadius.circular(8),),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children:  [
                                         Text("${RecentSearchData.searchText}", style: BlackDescStyle,),
                                         SizedBox(width: 7,),
                                         Padding(
                                           padding: EdgeInsets.only(bottom: 0),
                                           child: Icon(Icons.access_time_outlined,color: Colors.black,size: 15,),
                                         ),
                                         SizedBox(width: 2,),
                                         Text(
                                           OfferCreateTime("${RecentSearchData.historyTimestamp.toString()}")
                                           ,style: BlackDescStyle,)
                                       ],
                                     ),
                                   ),
                                 );
                               },
                             ),
                           ),
                         ),
                         const SizedBox(height: 5,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:  [
                             Text("Trending Searches",style: BlackTitleStyle,),
                             Spacer(),
                             InkWell(
                                 onTap:(){
                                   Get.to(()=> AllTrendingSearchScreen(TrendingSearchDataList: controller.TrendingSearchDataList.value))!.then((value) {
                                     controller.TrendingSearch();
                                     controller.RecentSearch();
                                   });
                                 },
                                 child: Text("   ",style: PrimaryColorHeadStyle,)),
                             SizedBox(width: 5,),
                             Icon(Icons.arrow_forward,color: Constants.primaryColor1,size: 20,)
                           ],
                         ),
                         AnimatedSwitcher(duration: Duration(milliseconds: 10),
                           child:
                           controller.isLoadRTrendingSearch.value == false?ShimmerCardLoadingBuilder(context):
                           controller.TrendingSearchDataList.isEmpty?
                           Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("Trending Searches not available!",style: greySubTitleItalicStyle,textAlign: TextAlign.center,),
                               ],
                             ),
                           )
                               :SizedBox(
                             height: 45,
                             width: double.infinity,
                             child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                               physics: const ClampingScrollPhysics(),
                               shrinkWrap: true,
                               itemCount: controller.TrendingSearchDataList.length >5 ? 5 :controller.TrendingSearchDataList.length,
                               itemBuilder: (context, index) {
                                 var TrendingData = controller.TrendingSearchDataList[index];

                                 return InkWell(
                                   onTap:(){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => GlobalSearchScreen(SearchText:TrendingData.searchText.toString(),RecentSearch: [], TreandingSearch: [] ),)).then((value) {
                                       controller.TrendingSearch();
                                       controller.RecentSearch();
                                     });
                                   },
                                   child: Container(
                                     margin: const EdgeInsets.only(right: 10,top: 5,bottom: 5),
                                     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                     decoration: BoxDecoration(
                                       color: Constants.greyLight,
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Text(
                                           "${TrendingData.searchText}",
                                           style: BlackSubTitleStyle,
                                         ),
                                         const SizedBox(width: 15,),
                                         Image.asset("assets/trend.png",height: 24,color: Constants.black,)
                                       ],
                                     ),
                                   ),
                                 );
                               },
                             ),
                           ),
                         ),
                         const SizedBox(height: 5,),

                         controller.selectedChoiceList.contains("YOUR FAVOURITES")?Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             Padding(
                               padding: const EdgeInsets.only(bottom: 0.0),
                               child: const Text("Your Favourites",style: BlackTitleStyle,),
                             ),
                           ],
                         ):SizedBox(),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 5.0,top: 5),
                           child: AnimatedSwitcher(
                             duration:  Duration(milliseconds: 200),
                             child: controller.selectedChoiceList.contains("YOUR FAVOURITES")?
                             controller.getFavLoader.value == false ?
                             ShimmerLoadingBuilder(context) : controller.getFavoriteOfferList.isEmpty?
                             NotAvailableText("Your favourites offer not available!"):
                             DashBoardOfferBuilder(offerList: controller.getFavoriteOfferList,isYourOffer: false,controller: controller,Type: "Fav"):SizedBox(),
                           ),
                         ),
                         controller.selectedChoiceList.contains("YOUR OPEN OFFERS")?  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             Padding(
                               padding: const EdgeInsets.only(bottom: 0.0),
                               child: const Text("Your Open Offers",style: BlackTitleStyle,),
                             ),
                           ],
                         ):SizedBox(),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 5.0,top: 0),
                           child: AnimatedSwitcher(
                             duration:  Duration(milliseconds: 200),
                             child: controller.selectedChoiceList.contains("YOUR OPEN OFFERS")?
                             controller.getMyOfferLoader.value == false ?   ShimmerLoadingBuilder(context):
                             controller.getMyOffersList.isEmpty?
                             NotAvailableText("Your open offer not available!"):
                             DashBoardOfferBuilder(offerList: controller.getMyOffersList,isYourOffer: true,controller: controller,Type: "Open" ):SizedBox() ,
                           ),
                         ),
                         controller.selectedChoiceList.contains("YOUR COUNTERS")?  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             const Text("Your Counters Offers",style: BlackTitleStyle,),
                           ],
                         ):SizedBox(),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 0.0,top: 5),
                           child: AnimatedSwitcher(
                             duration:  Duration(milliseconds: 200),
                             child:   controller.selectedChoiceList.contains("YOUR COUNTERS")?
                             controller.getMyCountersOfferLoader.value == false ?   ShimmerLoadingBuilder(context):
                             controller.getMyCountersOffersList.isEmpty?
                             NotAvailableText("Your counters offers not available!"):
                             DashBoardOfferBuilder(offerList:controller.getMyCountersOffersList,isYourOffer: true,controller: controller,Type: "Counter") :SizedBox() ,
                           ),
                         ),
                         controller.selectedChoiceList.contains("YOUR CONFIRMED OFFERS")?  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             Padding(
                               padding: const EdgeInsets.only(bottom: 5.0),
                               child: const Text("Your Confirmed Offers",style: BlackTitleStyle,),
                             ),
                           ],
                         ):SizedBox(),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 5.0,top: 0),
                           child: AnimatedSwitcher(   duration:  Duration(milliseconds: 200),
                             child:     controller.selectedChoiceList.contains("YOUR CONFIRMED OFFERS")?
                             controller.getMyOfferLoader.value == false|| controller.getMyCountersOfferLoader.value == false ?  ShimmerLoadingBuilder(context):
                             controller.getMyOffersList.isEmpty && controller.getMyCountersOffersList.isEmpty?
                             NotAvailableText("Your confirmed offer not available!"):
                             DashBoardConfirmedOfferBuilder(getMyCounterOffersList: controller.getMyCountersOffersList,getMyOffersList: controller.getMyOffersList,isYourOffer: true) :SizedBox() ,
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             const Text("Trending Offers",style: BlackTitleStyle,),
                             const Spacer(),
                             InkWell(
                                 onTap:(){
                                   Get.to(()=> TrendingOffer())!.then((value) {
                                     controller.getTreadingOffer();
                                     controller.getRecommendedOffer();
                                   });},
                                 child: const Text("   ",style: PrimaryColorHeadStyle,)),
                             const SizedBox(width: 5,),
                             const Icon(Icons.arrow_forward,color: Constants.primaryColor1,size: 20,)
                           ],
                         ),
                         const SizedBox(height: 5,),
                         AnimatedSwitcher(duration: Duration(milliseconds: 200),
                           child:
                           controller.isLoadTrendingOffer.value == false ?   ShimmerLoadingBuilder(context):
                           controller.TrendingOfferList.isEmpty?
                           NotAvailableText("Trending offer not available!"):
                           DashBoardOfferBuilder(offerList:controller.TrendingOfferList,isYourOffer: false,controller: controller,Type: "Trending"),
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             const Text("Templates",style: BlackTitleStyle,),
                             const Spacer(),
                             InkWell(
                                 onTap:(){
                                   Get.to(()=> AllTemplatesScreens())!.then((value) {

                                   });},
                                 child: const Text("   ",style: PrimaryColorHeadStyle,)),
                             const SizedBox(width: 5,),
                             const Icon(Icons.arrow_forward,color: Constants.primaryColor1,size: 20,)
                           ],
                         ),
                         const SizedBox(height: 5,),
                         AnimatedSwitcher(
                           duration: Duration(milliseconds: 200),
                           child:    controller.isLoadTrendingOffer.value == false? ShimmerTemplateLoadingBuilder(context):
                           controller.TemplateList.isEmpty?
                           NotAvailableText("Offer templates not available!"):
                           DashBoardOfferTemplateBuilder(offerList:controller.TemplateList),
                           // SizedBox(
                           //   height: 250,
                           //   width: double.infinity,
                           //   child: ListView.builder(
                           //     scrollDirection: Axis.horizontal,
                           //     physics: const ClampingScrollPhysics(),
                           //     shrinkWrap: true,
                           //     itemCount: controller.TemplateList.length,
                           //     itemBuilder: (context, index) {
                           //       var data = controller.TemplateList[index];
                           //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${data.offerData!.createdAt.toString()}');
                           //       final currentTime = DateTime.now();
                           //       final diff_dy = currentTime.difference(startTime).inDays;
                           //       int years = diff_dy ~/ 365;
                           //       int months = (diff_dy-years*365) ~/ 30;
                           //       final diff_mi = currentTime.difference(startTime).inMinutes;
                           //       final diff_s = currentTime.difference(startTime).inSeconds;
                           //       final diff_hr = currentTime.difference(startTime).inHours;
                           //       return FutureBuilder(
                           //         future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.media),
                           //         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                           //           return Container(
                           //             margin: const EdgeInsets.only(right: 10),
                           //             width: 170,
                           //             child: Column(
                           //               mainAxisAlignment: MainAxisAlignment.start,
                           //               crossAxisAlignment: CrossAxisAlignment.start,
                           //               children: [
                           //                 InkWell(
                           //                   onTap: () async{
                           //                     var body = {
                           //                       "offer_id": data.offerData!.id.toString(),
                           //                       "user_id" : DataManager.getInstance().getuserId().toString()
                           //                     };
                           //                     DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount").then((value) {
                           //                         if( value["is_update"] == true){
                           //                           controller.getTreadingOffer();
                           //                           controller.getRecommendedOffer();
                           //                         }
                           //                     });
                           //
                           //                     final fromPeriodDate = data.offerData!.offerConditions!.fromperiod== null ?"":data.offerData!.offerConditions!.fromperiod.toString();
                           //                     final fromPeriodTime = data.offerData!.offerConditions!.fromperiodtime==null?"":data.offerData!.offerConditions!.fromperiodtime.toString();
                           //                     final toPeriodDate = data.offerData!.offerConditions!.toperiod == null ?"": data.offerData!.offerConditions!.toperiod.toString();
                           //                     final toPeriodTime = data.offerData!.offerConditions!.toperiodtime == null?"": data.offerData!.offerConditions!.toperiodtime.toString();
                           //                     List serviceTemp = jsonDecode("${data.offerData!.offerareas!.toString()}");
                           //                     List<ServiceAreaModel> serviceAreaList = serviceTemp.map((e) => ServiceAreaModel.fromJson(e)).toList();
                           //                     List<PrefillOfferBids>  FillBids = [];
                           //                     List<PrefillOfferItems>  FillItmsList = [];
                           //                     data.offerData!.offerBids!.forEach((element) {
                           //                       FillBids.add(PrefillOfferBids(
                           //                           comments:   element.comment.toString()
                           //                       ));
                           //                     });
                           //                     for(var j  = 0 ; j<data.offerData!.offerItems!.length;j++) {
                           //                       final imgBase64Str = [];
                           //
                           //                       for(var k = 0 ; k< data.offerData!.offerItems![j].itemMedia!.length ; k++){
                           //                         imgBase64Str.add({
                           //                           "file":"${await controller.networkImageToBase64('${Url.IMAGE_URL}${data.offerData!.offerItems![j].itemMedia![k].media}')}",
                           //                           "name": "temp${data.offerData!.offerItems![j].itemMedia![k].media.toString().substring( data.offerData!.offerItems![j].itemMedia![k].media.toString().lastIndexOf('.'))}"
                           //                         });
                           //                       }
                           //                       final fromPeriodDate = data.offerData!.offerItems![j].offerItemConditions!.fromperiod== null ?"":data.offerData!.offerItems![j].offerItemConditions!.fromperiod.toString();
                           //                       final fromPeriodTime = data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime==null?"":data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime.toString();
                           //                       final toPeriodDate = data.offerData!.offerItems![j].offerItemConditions!.toperiod == null ?"": data.offerData!.offerItems![j].offerItemConditions!.toperiod.toString();
                           //                       final toPeriodTime = data.offerData!.offerItems![j].offerItemConditions!.toperiodtime == null?"": data.offerData!.offerItems![j].offerItemConditions!.toperiodtime.toString();
                           //                       FillItmsList.add(
                           //                           PrefillOfferItems(
                           //                             name: "${data.offerData!.offerItems![j].name.toString()}" ,
                           //                             addon:data.offerData!.offerItems![j].addon,
                           //                             desc: "${data.offerData!.offerItems![j].desc.toString()}",
                           //                             itemMedia: imgBase64Str,
                           //                             offerItemConditions: PrefillOfferItemConditions(
                           //                               priority: data.offerData!.offerItems![j].offerItemConditions!.priority == null ? "": data.offerData!.offerItems![j].offerItemConditions!.priority.toString(),
                           //                               periodicity:data.offerData!.offerItems![j].offerItemConditions!.periodicity == null ? "": data.offerData!.offerItems![j].offerItemConditions!.periodicity.toString(),
                           //                               duration:  data.offerData!.offerItems![j].offerItemConditions!.duration==null?"": data.offerData!.offerItems![j].offerItemConditions!.duration.toString(),
                           //                               fromlocation: data.offerData!.offerItems![j].offerItemConditions!.fromlocation == null ?"": data.offerData!.offerItems![j].offerItemConditions!.fromlocation.toString(),
                           //                               tolocation:data.offerData!.offerItems![j].offerItemConditions!.tolocation == null ?"": data.offerData!.offerItems![j].offerItemConditions!.tolocation.toString(),
                           //                               atlocation: data.offerData!.offerItems![j].offerItemConditions!.atlocation == null ?"": data.offerData!.offerItems![j].offerItemConditions!.atlocation.toString(),
                           //                               expiry:data.offerData!.offerItems![j].offerItemConditions!.expiry==null?"": data.offerData!.offerItems![j].offerItemConditions!.expiry.toString(),
                           //                               servicepersons: data.offerData!.offerItems![j].offerItemConditions!.servicepersons,
                           //                               timePeriod:  "${fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime}",
                           //                             ),
                           //                             price: data.offerData!.offerItems![j].price,
                           //                             unit:  PrefillUnit(id: data.offerData!.offerItems![j].unit!.id,name: data.offerData!.offerItems![j].unit!.name),
                           //                             quantity: data.offerData!.offerItems![j].quantity,
                           //                             required: data.offerData!.offerItems![j].required,
                           //                             toggleState: data.offerData!.offerItems![j].toggleState,
                           //                             advancePrice:  data.offerData!.offerItems![j].advancePrice,
                           //                             maintenancePrice: data.offerData!.offerItems![j].maintenancePrice,
                           //                             advanceUnit:FillAdvanceUnit(id: data.offerData!.offerItems![j].advanceUnit!.id,name: data.offerData!.offerItems![j].advanceUnit!.name),
                           //                             maintenanceUnit: FillMaintenanceUnit(id: data.offerData!.offerItems![j].maintenanceUnit!.id,name: data.offerData!.offerItems![j].maintenanceUnit!.name),
                           //
                           //
                           //                           ));
                           //                     }
                           //                     var preFillDetails = PrefillOfferDataModel(
                           //                       addres: data.offerData!.addres.toString(),
                           //                       buyORsell:   data.offerData!.buyORsell.toString(),
                           //                       category: FillCategory(
                           //                         id:  data.offerData!.category!.id,
                           //                         name: data.offerData!.category!.name,
                           //                       ),
                           //                       segment: FillSegment(
                           //                         name: data.offerData!.segment!.name,
                           //                         id:data.offerData!.segment!.id,
                           //                         category:data.offerData!.segment!.category,
                           //                       ),
                           //                       subsegment: FillSubsegment(
                           //                         id:     data.offerData!.subsegment!.id,
                           //                         name: data.offerData!.subsegment!.name,
                           //                         segment:data.offerData!.subsegment!.segment,
                           //                       ),
                           //                       offerConditions: PrefillOfferConditions(
                           //                         fromPeriod: data.offerData!.offerConditions!.fromperiod,
                           //                         toPeriod: data.offerData!.offerConditions!.toperiod,
                           //                         fromPeriodTime: data.offerData!.offerConditions!.fromperiodtime,
                           //                         toPeriodTime: data.offerData!.offerConditions!.toperiodtime,
                           //                         priority:data.offerData!.offerConditions!.priority.toString().trim(),
                           //                         periodicity: data.offerData!.offerConditions!.periodicity.toString().trim(),
                           //                         duration: data.offerData!.offerConditions!.duration,
                           //                         fromlocation:data.offerData!.offerConditions!.fromlocation,
                           //                         tolocation: data.offerData!.offerConditions!.tolocation,
                           //                         atlocation: data.offerData!.offerConditions!.atlocation,
                           //                         expiry: data.offerData!.offerConditions!.expiry,
                           //                         servicepersons:  data.offerData!.offerConditions!.servicepersons,
                           //                         timePeriod:fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime,
                           //                       ),
                           //                       tabactivity: "New",
                           //                       offerareas:  serviceAreaList,
                           //                       offerBids: FillBids,
                           //                       offerItems: FillItmsList,
                           //                     );
                           //                     Navigator.push(context, MaterialPageRoute(builder: (context) => NewOfferCreateScreen(Address: "",AddressTitle: "",From: "Fill",PrefillOfferData:preFillDetails ,Type: "Template",OfferId: data.offerData!.id.toString(),SubId: data.offerData!.subscribers!.id.toString()),));
                           //
                           //                   },
                           //                   child: Stack(
                           //                     children: [
                           //                       Container(
                           //                         height: 110,
                           //                         decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                           //                             image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                           //                             DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                           //                             "${data.offerData!.offerItems!.first.itemMedia!.first.media.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.media.toString().lastIndexOf('.'))}" == ".mp4"?
                           //                             snapshot.connectionState == ConnectionState.waiting?
                           //                             DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                           //                                 :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                           //                             DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].media}"), fit: BoxFit.fill)),
                           //                       ),
                           //
                           //                       data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                           //                       data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                           //                       Positioned(
                           //                           top: 0,left: 0,
                           //                           child:  Container(
                           //                               padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                           //                               decoration:  BoxDecoration(
                           //                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                           //                                   color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor
                           //                               ),
                           //                               child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                           //                                 ,))):
                           //                       Positioned(
                           //                           top: 0,left: 0,
                           //                           child:  Container(
                           //                               padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                           //                               decoration:  BoxDecoration(
                           //                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                           //                                   color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor: Constants.redColor
                           //                               ),
                           //                               child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                           //                                 ,))):
                           //                       Positioned(
                           //                         top: 0,left: 0,
                           //                         child:  Container(
                           //                           padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                           //                           decoration:  BoxDecoration(
                           //                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                           //                               color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor
                           //                           ),
                           //                           child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                           //                         ),),
                           //                       Positioned(
                           //                         bottom: 0,right: 0,
                           //                         child: Container(
                           //                           width: 170,
                           //                           decoration: BoxDecoration(
                           //                               color: Colors.black45
                           //                           ),
                           //                           padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                           //                           child: Row(
                           //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           //                             children: [
                           //                               Flexible(
                           //                                 child: Stack(
                           //                                   children: [
                           //                                     Text(data.offerData!.subscribers!.username.toString() == "null" ?"":"${data.offerData!.subscribers!.username.toString()}",style: TextStyle(
                           //                                       fontSize: 14,
                           //                                       letterSpacing: 0.1,
                           //                                       fontWeight: FontWeight.w900,
                           //                                       foreground: Paint()
                           //                                         ..style = PaintingStyle.stroke
                           //                                         ..strokeWidth = 1.2
                           //                                         ..color =  Color(0xFF805705),
                           //                                     ),),
                           //                                     Text(data.offerData!.subscribers!.username.toString() == "null" ?"":"${data.offerData!.subscribers!.username.toString()}",style: TextStyle(
                           //                                         fontSize: 14,
                           //                                         letterSpacing: 0.1,
                           //                                         fontWeight: FontWeight.w600,
                           //                                         color: Colors.white
                           //                                     )),
                           //                                   ],
                           //                                 ),
                           //                               ),
                           //
                           //                               Row(
                           //                                 children: [
                           //                                   Image.asset("assets/view.png",height: 10,color: Colors.white,),
                           //                                   const SizedBox(width: 5,),
                           //                                   Text("${data.offerData!.offerviewcount!.length} Views",style: WhiteHeadingStyle,),
                           //                                 ],)
                           //                             ],
                           //                           ),
                           //                         ),
                           //                       ),
                           //                       Positioned(
                           //                         top: 0,right: 0,
                           //                         child:  Container(
                           //                           padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                           //                           decoration:  BoxDecoration(
                           //                               borderRadius: BorderRadius.only(topRight: Radius.circular(7)),
                           //                               color: Constants.templateBg
                           //                           ),
                           //                           child: Center(child: Text("TEMPLATE",style: WhiteHintStyle,)),
                           //                         ),),
                           //
                           //                     ],
                           //                   ),
                           //                 ),
                           //                 Expanded(
                           //                   child: Stack(
                           //                     children: [
                           //                       Container(
                           //                         decoration: BoxDecoration(
                           //                           borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),),
                           //                           border: Border.all(color: Constants.greyLight,width: 1),),
                           //                         padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                           //                         child: Column(
                           //                           crossAxisAlignment: CrossAxisAlignment.start,
                           //                           children: [
                           //                             Expanded(child:
                           //                             RichText(text:   TextSpan(
                           //                                 style:BlackHintStyle,
                           //                                 children: [
                           //                                   TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                           //                                   TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.subscribers!.username.toString()} ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} per ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                           //                                 ]
                           //                             )),
                           //                             ),
                           //                             const SizedBox(height: 10,),
                           //
                           //                             Row(
                           //                               mainAxisAlignment: MainAxisAlignment.start,
                           //                               crossAxisAlignment: CrossAxisAlignment.start,
                           //                               children: [
                           //                                 data.offerData!.like == 0 ?
                           //                                 data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()? Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 18,):
                           //                                 data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                           //                                 Builder(
                           //                                   builder: (ctx) {
                           //                                     return ReactionButton<String>(
                           //                                       onReactionChanged: (String? value) {
                           //                                         var body = {
                           //                                           "offer_id": data.offerData!.id.toString(),
                           //                                           "user_id" : DataManager.getInstance().getuserId().toString()
                           //                                         };
                           //                                         DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                           //                                         if(value == "like"){
                           //                                           DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                           //
                           //                                             Constants.showToast("${value["message"]}");
                           //
                           //                                             if( value["message"].toString().trim() == "Offer Liked"){
                           //                                               var data2 = OfferDataModelResult(
                           //                                                   offerCounters: data.offerCounters,
                           //                                                   offerData: MainOfferDetails(
                           //                                                       favourite: data.offerData!.favourite,
                           //                                                       addres: data.offerData!.addres,
                           //                                                       buyORsell:  data.offerData!.buyORsell,
                           //                                                       category: data.offerData!.category,
                           //                                                       segment: data.offerData!.segment,
                           //                                                       subsegment:  data.offerData!.subsegment,
                           //                                                       computedRating: data.offerData!.computedRating,
                           //                                                       counterdUser: data.offerData!.counterdUser,
                           //                                                       createdAt: data.offerData!.createdAt,
                           //                                                       id: data.offerData!.id,
                           //                                                       modified: data.offerData!.modified,
                           //                                                       offerareas: data.offerData!.offerareas,
                           //                                                       offerBids: data.offerData!.offerBids,
                           //                                                       offerConditions: data.offerData!.offerConditions,
                           //                                                       offerconfirmed:  data.offerData!.offerconfirmed,
                           //                                                       offercopycount: data.offerData!.offercopycount,
                           //                                                       offerevent: data.offerData!.offerevent,
                           //                                                       offerexecuteend: data.offerData!.offerexecuteend,
                           //                                                       offerexecutestart: data.offerData!.offerexecutestart,
                           //                                                       offerfavoritecount: data.offerData!.offerfavoritecount,
                           //                                                       offerItems: data.offerData!.offerItems,
                           //                                                       offerincepted: data.offerData!.offerincepted,
                           //                                                       offerinform: data.offerData!.offerinform,
                           //                                                       offerresponses:  data.offerData!.offerresponses,
                           //                                                       offerservicepercentage: data.offerData!.offerservicepercentage,
                           //                                                       offersignedoff:data.offerData!.offersignedoff,
                           //                                                       offerstatus:  data.offerData!.offerstatus,
                           //                                                       offertemplate: data.offerData!.offertemplate,
                           //                                                       offerviewcount: data.offerData!.offerviewcount,
                           //                                                       privacy: data.offerData!.privacy,
                           //                                                       subscribers:data.offerData!.subscribers,
                           //                                                       tabactivity: data.offerData!.tabactivity,
                           //                                                       userRating: data.offerData!.userRating,
                           //                                                       like: 1,
                           //                                                       offerLike: data.offerData!.offerLike!+1,
                           //                                                       offerDisLike: data.offerData!.offerDisLike,
                           //                                                       comments: data.offerData!.comments,
                           //                                                       ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                           //                                                   )
                           //                                               );
                           //                                               controller.TemplateList[index]= data2;
                           //                                             }
                           //                                           });
                           //                                         }else{
                           //                                           DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                           //
                           //                                             Constants.showToast("${value["message"]}");
                           //                                             if( value["message"].toString().trim() == "Offer Disliked"){
                           //                                               var data2 = OfferDataModelResult(
                           //                                                   offerCounters: data.offerCounters,
                           //                                                   offerData: MainOfferDetails(
                           //                                                       favourite: data.offerData!.favourite,
                           //                                                       addres: data.offerData!.addres,
                           //                                                       buyORsell:  data.offerData!.buyORsell,
                           //                                                       category: data.offerData!.category,
                           //                                                       segment: data.offerData!.segment,
                           //                                                       subsegment:  data.offerData!.subsegment,
                           //                                                       computedRating: data.offerData!.computedRating,
                           //                                                       counterdUser: data.offerData!.counterdUser,
                           //                                                       createdAt: data.offerData!.createdAt,
                           //                                                       id: data.offerData!.id,
                           //                                                       modified: data.offerData!.modified,
                           //                                                       offerareas: data.offerData!.offerareas,
                           //                                                       offerBids: data.offerData!.offerBids,
                           //                                                       offerConditions: data.offerData!.offerConditions,
                           //                                                       offerconfirmed:  data.offerData!.offerconfirmed,
                           //                                                       offercopycount: data.offerData!.offercopycount,
                           //                                                       offerevent: data.offerData!.offerevent,
                           //                                                       offerexecuteend: data.offerData!.offerexecuteend,
                           //                                                       offerexecutestart: data.offerData!.offerexecutestart,
                           //                                                       offerfavoritecount: data.offerData!.offerfavoritecount,
                           //                                                       offerItems: data.offerData!.offerItems,
                           //                                                       offerincepted: data.offerData!.offerincepted,
                           //                                                       offerinform: data.offerData!.offerinform,
                           //                                                       offerresponses:  data.offerData!.offerresponses,
                           //                                                       offerservicepercentage: data.offerData!.offerservicepercentage,
                           //                                                       offersignedoff:data.offerData!.offersignedoff,
                           //                                                       offerstatus:  data.offerData!.offerstatus,
                           //                                                       offertemplate: data.offerData!.offertemplate,
                           //                                                       offerviewcount: data.offerData!.offerviewcount,
                           //                                                       privacy: data.offerData!.privacy,
                           //                                                       subscribers:data.offerData!.subscribers,
                           //                                                       tabactivity: data.offerData!.tabactivity,
                           //                                                       userRating: data.offerData!.userRating,
                           //                                                       like: 2,
                           //                                                       offerLike: data.offerData!.offerLike,
                           //                                                       offerDisLike:data.offerData!.offerDisLike!+1,
                           //                                                       comments: data.offerData!.comments,
                           //                                                       ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                           //                                                   )
                           //                                               );
                           //                                               controller.TemplateList[index]= data2;
                           //                                             }
                           //                                           });
                           //                                         }
                           //                                       },
                           //                                       reactions: flagsReactions,
                           //                                       initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                           //                                         value: null,
                           //                                         icon:  Icon(
                           //                                           Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                           //                                         ),
                           //                                       ): Reaction<String>(
                           //                                         value: 'like',
                           //                                         icon:Icon(
                           //                                           Icons.thumb_up_alt_rounded,color: Constants.primaryColor,size: 18,
                           //                                         ),
                           //                                       ),
                           //                                       boxColor:Colors.amber.shade300 ,
                           //                                       boxRadius: 10,
                           //                                       boxElevation: 0,
                           //                                       boxDuration: const Duration(milliseconds: 200),
                           //                                       itemScaleDuration: const Duration(milliseconds: 100),
                           //                                     );
                           //                                   },
                           //                                 )
                           //                                     : Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 18,):
                           //                                 Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor,size: 18),
                           //                                 Spacer(),
                           //                                 InkWell(
                           //                                     onTap:(){
                           //                                       var body = {
                           //                                         "offer_id": data.offerData!.id.toString(),
                           //                                         "user_id" : DataManager.getInstance().getuserId().toString()
                           //                                       };
                           //                                       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                           //                                       DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                           //                                         if( value["message"].toString().trim() == "offer removed from favourite"){
                           //                                           Constants.showToast("${Url.UnMarkFav}");
                           //                                           var data2 = OfferDataModelResult(
                           //                                               offerCounters: data.offerCounters,
                           //                                               offerData: MainOfferDetails(
                           //                                                   addres: data.offerData!.addres,
                           //                                                   buyORsell:  data.offerData!.buyORsell,
                           //                                                   category: data.offerData!.category,
                           //                                                   segment: data.offerData!.segment,
                           //                                                   subsegment:  data.offerData!.subsegment,
                           //                                                   computedRating: data.offerData!.computedRating,
                           //                                                   counterdUser: data.offerData!.counterdUser,
                           //                                                   createdAt: data.offerData!.createdAt,
                           //                                                   id: data.offerData!.id,
                           //                                                   modified: data.offerData!.modified,
                           //                                                   offerareas: data.offerData!.offerareas,
                           //                                                   offerBids: data.offerData!.offerBids,
                           //                                                   offerConditions: data.offerData!.offerConditions,
                           //                                                   offerconfirmed:  data.offerData!.offerconfirmed,
                           //                                                   offercopycount: data.offerData!.offercopycount,
                           //                                                   offerevent: data.offerData!.offerevent,
                           //                                                   offerexecuteend: data.offerData!.offerexecuteend,
                           //                                                   offerexecutestart: data.offerData!.offerexecutestart,
                           //                                                   offerItems: data.offerData!.offerItems,
                           //                                                   offerincepted: data.offerData!.offerincepted,
                           //                                                   offerinform: data.offerData!.offerinform,
                           //                                                   offerresponses:  data.offerData!.offerresponses,
                           //                                                   offerservicepercentage: data.offerData!.offerservicepercentage,
                           //                                                   offersignedoff:data.offerData!.offersignedoff,
                           //                                                   offerstatus:  data.offerData!.offerstatus,
                           //                                                   offertemplate: data.offerData!.offertemplate,
                           //                                                   offerviewcount: data.offerData!.offerviewcount,
                           //                                                   privacy: data.offerData!.privacy,
                           //                                                   subscribers:data.offerData!.subscribers,
                           //                                                   tabactivity: data.offerData!.tabactivity,
                           //                                                   userRating: data.offerData!.userRating,
                           //                                                   favourite: false,
                           //                                                   offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                           //                                                   like: data.offerData!.like,
                           //                                                   offerLike: data.offerData!.offerLike,
                           //                                                   offerDisLike: data.offerData!.offerDisLike,
                           //                                                   comments: data.offerData!.comments,
                           //                                                   ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                           //                                               )
                           //                                           );
                           //                                           controller.TemplateList[index]= data2;
                           //                                         }else{
                           //                                           Constants.showToast("${Url.markFav}");
                           //                                           var data2 = OfferDataModelResult(
                           //                                               offerCounters: data.offerCounters,
                           //                                               offerData: MainOfferDetails(
                           //                                                   addres: data.offerData!.addres,
                           //                                                   buyORsell:  data.offerData!.buyORsell,
                           //                                                   category: data.offerData!.category,
                           //                                                   segment: data.offerData!.segment,
                           //                                                   subsegment:  data.offerData!.subsegment,
                           //                                                   computedRating: data.offerData!.computedRating,
                           //                                                   counterdUser: data.offerData!.counterdUser,
                           //                                                   createdAt: data.offerData!.createdAt,
                           //                                                   id: data.offerData!.id,
                           //                                                   modified: data.offerData!.modified,
                           //                                                   offerareas: data.offerData!.offerareas,
                           //                                                   offerBids: data.offerData!.offerBids,
                           //                                                   offerConditions: data.offerData!.offerConditions,
                           //                                                   offerconfirmed:  data.offerData!.offerconfirmed,
                           //                                                   offercopycount: data.offerData!.offercopycount,
                           //                                                   offerevent: data.offerData!.offerevent,
                           //                                                   offerexecuteend: data.offerData!.offerexecuteend,
                           //                                                   offerexecutestart: data.offerData!.offerexecutestart,
                           //                                                   offerItems: data.offerData!.offerItems,
                           //                                                   offerincepted: data.offerData!.offerincepted,
                           //                                                   offerinform: data.offerData!.offerinform,
                           //                                                   offerresponses:  data.offerData!.offerresponses,
                           //                                                   offerservicepercentage: data.offerData!.offerservicepercentage,
                           //                                                   offersignedoff:data.offerData!.offersignedoff,
                           //                                                   offerstatus:  data.offerData!.offerstatus,
                           //                                                   offertemplate: data.offerData!.offertemplate,
                           //                                                   offerviewcount: data.offerData!.offerviewcount,
                           //                                                   privacy: data.offerData!.privacy,
                           //                                                   subscribers:data.offerData!.subscribers,
                           //                                                   tabactivity: data.offerData!.tabactivity,
                           //                                                   userRating: data.offerData!.userRating,
                           //                                                   favourite: true,
                           //                                                   offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                           //                                                   like: data.offerData!.like,
                           //                                                   offerLike: data.offerData!.offerLike,
                           //                                                   offerDisLike: data.offerData!.offerDisLike,
                           //                                                   comments: data.offerData!.comments,
                           //                                                   ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                           //                                               )
                           //                                           );
                           //                                           controller.TemplateList[index]= data2;
                           //                                         }
                           //                                         controller.getTreadingOffer();
                           //                                         controller.getRecommendedOffer();
                           //                                       });
                           //                                     },
                           //                                     child: data.offerData!.favourite == true ? Padding(
                           //                                       padding: const EdgeInsets.only(bottom: 5.0),
                           //                                       child: Icon(Icons.favorite,color: Constants.primaryColor,size: 20,),
                           //                                     ):Padding(
                           //                                       padding: const EdgeInsets.only(bottom: 5.0),
                           //                                       child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 20),
                           //                                     )
                           //                                 ),
                           //                                 Padding(
                           //                                   padding: const EdgeInsets.only(left: 3.0),
                           //                                   child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                           //                                 ),
                           //
                           //                                 Spacer(),
                           //                                 Image.asset("assets/note.png",height: 15,color:Colors.grey),
                           //                                 Padding(
                           //                                   padding: const EdgeInsets.only(left: 3.0),
                           //                                   child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                           //                                 ),
                           //                                 Spacer(),
                           //                                 Image.asset("assets/time.png",height: 15,color: Constants.primaryColor,),
                           //                                 Padding(
                           //                                   padding: const EdgeInsets.only(left: 3.0),
                           //                                   child: Text(
                           //                                     diff_s <= 60? "$diff_s""s":
                           //                                     diff_mi <= 60 ?"$diff_mi""m":
                           //                                     diff_hr <= 24 ? "$diff_hr""h":
                           //                                     diff_dy <= 30 ? "$diff_dy""d":
                           //                                     months <= 12 ? "$months""months":
                           //                                     "$years"
                           //                                     ,style: BlackDescStyle,
                           //                                   ),
                           //                                 )
                           //                               ],
                           //                             ),
                           //                             (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? Text("${Url.NoRating}"):
                           //                             Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                           //                             "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primarySmallText,),
                           //
                           //                           ],
                           //                         ),
                           //                       ),
                           //
                           //                     ],
                           //                   ),
                           //                 )
                           //               ],
                           //             ),
                           //           );
                           //         },);
                           //     },
                           //   ),
                           // ),
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const Text("Recommended Offers",style: BlackTitleStyle,),
                             Flexible(child: const Text(" (Matching your choice)",style: BlackSubTitleItalicStyle,overflow: TextOverflow.ellipsis)),
                             const Spacer(),
                             InkWell(
                                 onTap: (){
                                   Get.to(()=> RecommendedOffer())!.then((value) {
                                     controller.getTreadingOffer();
                                     controller.getRecommendedOffer();
                                   });
                                 },
                                 child:
                                 Row(
                                     children: const [
                                       Text("   ",style: PrimaryColorHeadStyle,),
                                       SizedBox(width: 5,),
                                       Icon(Icons.arrow_forward,color: Constants.primaryColor1,size: 20,),
                                     ]
                                 )

                             ),
                           ],
                         ),
                         const SizedBox(height: 10,),
                         AnimatedSwitcher(duration: Duration(milliseconds: 200),
                           child: controller.isLoadRecommendedOffer.value == false ? ShimmerLoadingBuilder(context):
                           controller.RecommendedOfferList.isEmpty?
                           NotAvailableText("Offer not available!"):
                           DashBoardOfferBuilder(offerList:controller.RecommendedOfferList,isYourOffer: false,controller: controller,Type: "Recommended"),
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:[
                             Padding(
                               padding: const EdgeInsets.only(bottom: 8.0),
                               child: const Text("Recently Viewed offers ",style: BlackTitleStyle,),
                             ),
                           ],
                         ),
                         AnimatedSwitcher(
                             duration:  Duration(milliseconds: 200),
                             child:
                             controller.getRecentViewOfferLoader.value  == false?
                             ShimmerLoadingBuilder(context) : controller.getRecentViewOfferList.isEmpty?
                             NotAvailableText("Offer not available!"):
                             Padding(
                               padding: const EdgeInsets.only(bottom: 10.0),
                               child:   DashBoardOfferBuilder(offerList:controller.getRecentViewOfferList,isYourOffer: false,controller: controller,Type: "Recent"),
                             )
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children:  [
                             const Text("Trending People/Place",style: BlackTitleStyle,),
                             const Spacer(),
                             InkWell(
                               onTap: (){
                                 Get.to(()=>const TrendingPeople());
                               },
                               child: Row(
                                 children: const [
                                   Text("   ",style: PrimaryColorTitleStyle,),
                                   SizedBox(width: 5,),
                                   Icon(Icons.arrow_forward,color: Constants.primaryColor1,size: 20,),
                                 ],
                               ),
                             )
                           ],
                         ),
                         const SizedBox(height: 10,),
                         AnimatedSwitcher(
                           duration: Duration(milliseconds: 200),
                           child:   controller.isLoadRTrendingPlacedOffer.value == false? ShimmerPersonLoadingBuilder(context):
                           controller.TrendingPlacePeopleDataList.isEmpty?
                           NotAvailableText("People not available!"):
                           SizedBox(
                             height: 150,
                             width: double.infinity,
                             child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                               physics: const ClampingScrollPhysics(),
                               shrinkWrap: true,
                               itemCount: controller.TrendingPlacePeopleDataList.length,
                               itemBuilder: (context, index) {
                                 var data = controller.TrendingPlacePeopleDataList[index];
                                 return InkWell(
                                   onTap:(){
                                     Get.to(()=>ProfileViewScreen(userID: data.id.toString(),));
                                   },
                                   child: Container(
                                     margin: const EdgeInsets.only(right: 10),
                                     width: 150,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Stack(
                                           children: [
                                             Container(
                                               height: 150,
                                               decoration:  BoxDecoration(
                                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                                   image: data.profilePicture.toString() == "null"? DecorationImage(image: NetworkImage("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"), fit: BoxFit.cover):DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.profilePicture}"), fit: BoxFit.fill)),
                                             ),
                                             Positioned(
                                                 bottom: 0,
                                                 child: Container(
                                                     color: Colors.black45,
                                                     width: 150,
                                                     padding: EdgeInsets.symmetric(horizontal: 5),
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         Flexible(
                                                           child: Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             children: [
                                                               2.height,

                                                               Text("${data.displayname.toString()} - ${data.placeORperson.toString().toUpperCase()}",style: WhiteSubTitleStyle),
                                                               2.height,
                                                             ],
                                                           ),
                                                         ),

                                                         data.optDelivery == true? Builder(
                                                           builder: (ctx) {
                                                             return ReactionButton<String>(
                                                               onReactionChanged: (String? value) {
                                                                 var body = {
                                                                   "from_user": DataManager.getInstance().getuserId().toString(),
                                                                   "to_user":data.id.toString()
                                                                 };

                                                                 if(value == "like"){
                                                                   DrawAuraAPi.CreateDataApi(body:body,ApiEndPoint:"likeUser").then((value) {

                                                                     Constants.showToast("${value["message"]}");
                                                                   });
                                                                 }else{
                                                                   DrawAuraAPi.CreateDataApi(body:body,ApiEndPoint:"dislikeUser").then((value) {

                                                                     Constants.showToast("${value["message"]}");

                                                                   });                                                        }
                                                                 if(value == "like"){
                                                                   Constants.showToast("Liked");

                                                                 }else{
                                                                   Constants.showToast("DisLiked");

                                                                 }
                                                               },
                                                               reactions: flagsReactions,
                                                               initialReaction: 0 == 0 ?  Reaction<String>(
                                                                 value: null,
                                                                 icon:  CircleAvatar(
                                                                   radius: 12,backgroundColor:Constants.primaryColor1,
                                                                   child: Icon(
                                                                     Icons.thumb_up_outlined,color: Colors.white,size: 18,
                                                                   ),
                                                                 ),
                                                               ): Reaction<String>(
                                                                 value: 'like',
                                                                 icon: CircleAvatar(
                                                                   radius: 12,backgroundColor:Colors.white,
                                                                   child: Icon(
                                                                     Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                                                                   ),
                                                                 ),
                                                               ),
                                                               boxColor:Colors.amber.shade300 ,
                                                               boxRadius: 10,
                                                               boxElevation: 0,
                                                               boxDuration: const Duration(milliseconds: 200),
                                                               itemScaleDuration: const Duration(milliseconds: 100),
                                                             );
                                                           },
                                                         ):SizedBox(),
                                                       ],
                                                     )
                                                 )),

                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 );
                               },
                             ),
                           ),
                         ),
                         const SizedBox(height: 10,),
                       ],
                     ),
                   ),
                 )
               ),
               controller.NavigateLoader.value==true?
               Positioned(
                   child: Container(
                       height: MediaQuery.of(context).size.height,
                       width: isMobile?width:tabWidth,
                       color: Colors.black12,
                       child:Center(child: LoadingWidget(),)
                   )
               ):SizedBox()
             ],
           ),
         );
    }
    );
  }
}
















