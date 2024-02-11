import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:simple_rich_text/simple_rich_text.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/Auth/about_subscription_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetNotificationsModal.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:socialapps/screens/Dashboard/home/OtherUserProfileViewScreen.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import '../../../common/style.dart';

class OfferNotificationScreen extends StatefulWidget {
  List<NotificationListModel> OfferNotificationDataList;
  bool OfferNotificationLoader;
   OfferNotificationScreen({Key? key,required this.OfferNotificationDataList,required this.OfferNotificationLoader}) : super(key: key);

  @override
  State<OfferNotificationScreen> createState() => _OfferNotificationScreenState();
}

class _OfferNotificationScreenState extends State<OfferNotificationScreen> {

  bool isOnNavigatorLoader = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(
      body: widget.OfferNotificationLoader==true?const Center(child: LoadingWidget()):widget.OfferNotificationDataList.isEmpty?   Center(
        child: NotAvailableText("Notification not available!")
      ):
      Stack(

        children: [
            ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.OfferNotificationDataList.length,
            itemBuilder: (context, index) {

              List<NotificationListModel> reversedList = widget.OfferNotificationDataList.reversed.toList();
              var data = reversedList[index];
              final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${data.notifyingTimestamp.toString()}');
              final currentTime = DateTime.now();
              final diff_dy = currentTime.difference(startTime).inDays;
              int years = diff_dy ~/ 365;
              int months = (diff_dy-years*365) ~/ 30;
              final diff_mi = currentTime.difference(startTime).inMinutes;
              final diff_s = currentTime.difference(startTime).inSeconds;
              final diff_hr = currentTime.difference(startTime).inHours;
              return GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:Color(0xFFDFEAE4),
                            blurRadius: 1.5,
                            spreadRadius: 1.5,
                          )
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3,right: 5,top: 5,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(children:[
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                elevation: 4,
                                child: InkWell(
                                  onTap: (){
                                    if(data.type.toString().trim().toUpperCase() == "EXPIRED"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),));
                                    }else{
                                      Get.to(()=>ProfileViewScreen(userID: data.fromUser!.id.toString(),));
                                    }
                                  },
                                  child: Container(
                                    height: 60,width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                        image: data.type.toString().trim().toUpperCase() == "EXPIRED"||
                                            data.type.toString().trim().toUpperCase() == "OFFEREXPIRED"?
                                        DecorationImage(
                                            image: data.toUser!.profilePicture == ""? NetworkImage("https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"): NetworkImage("${Url.IMAGE_URL}${data.toUser!.profilePicture}"),fit: BoxFit.fill
                                        )
                                            :DecorationImage(
                                            image: data.fromUser!.profilePicture == ""? NetworkImage("https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png"): NetworkImage("${Url.IMAGE_URL}${data.fromUser!.profilePicture}"),fit: BoxFit.fill
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,right: 0,
                                  child:
                                      data.type.toString().trim().toUpperCase() == "DUPLICATE" ||
                                  //    data.type.toString().trim().toUpperCase() == "MATCH" ||
                                      data.type.toString().trim().toUpperCase() == "COMMENT" ||
                                      data.type.toString().trim().toUpperCase() == "TEMPLATE" ?
                                  Stack(
                                      children: [
                                        Image.asset("assets/infobg.png",height: 22,),
                                        Image.asset("assets/infoIcon.png",height: 22,),
                                      ]):
                                  data.type.toString().trim().toUpperCase() == "COUNTEROFFER" ?
                                  Image.asset("assets/BidCounter.png",height: 22,):
                                  data.type.toString().trim().toUpperCase() == "EXPIRED" ||
                                      data.type.toString().trim().toUpperCase() == "OFFEREXPIRED"?
                                  Image.asset("assets/expireNoti.png",height: 22,):
                                  data.type.toString().trim().toUpperCase() == "MAINOFFER" ?
                                  Image.asset("assets/messageNoti.png",height: 22,):
                                  data.type.toString().trim().toUpperCase() == "FOLLOW" ?
                                  Image.asset("assets/followNoti.png",height: 22,):
                                  data.type.toString().trim().toUpperCase() == "ITEMSELECTED" ?
                                  Image.asset("assets/ThumbsUp.png",height: 22,):
                                  data.type.toString().trim().toUpperCase() == "LIKE" ||
                                      data.type.toString().trim().toUpperCase() == "FAVOURITE" ||
                                      data.type.toString().trim().toUpperCase() == "DISLIKE" ?
                                  Image.asset("assets/like_notify.png",height: 22,)
                                      : Image.asset("assets/Tickicon.png",height: 25,))
                            ]
                            ),
                            10.width,
                         //   SimpleRichText(r'*_/this is all three*_/ (*{color:red}bold*, _{color:green}underlined_, and /{color:brown}italicized/). _{push:home;color:blue}clickable hyperlink to home screen_'),

                            // Text( "${data.fromUser!.displayname}" ,style: BlackDescStyleBold,),
                            Flexible(child: SimpleRichText("${data.notifyingMessage.toString()}",style: BlackDescStyleItelicHeigth13,maxLines: 3,textOverflow: TextOverflow.ellipsis,)),
                            // Flexible(
                            //   child: RichText(
                            //     overflow: TextOverflow.ellipsis,
                            //     maxLines: 3,
                            //     text: TextSpan(text: "${data.fromUser!.displayname}" ,style: BlackDescStyleBold,
                            //         recognizer: TapGestureRecognizer()..onTap = () {
                            //           Get.to(()=>ProfileViewScreen(userID: data.fromUser!.id.toString(),));
                            //         },
                            //         children:[
                            //          
                            //           TextSpan(text:' ${data.notifyingMessage.toString()}',style: BlackDescStyleItelicHeigth),
                            //           // TextSpan(text: ' ${data.entityValue} ',style: BlackTabDetailStyle),
                            //           // TextSpan(text: '${data.entityFieldValue}',style: BlackSubTitleItalicStyle, ),
                            //         ]),),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,right: 25,
                      child:  Row(
                        children:[
                          const Icon(Icons.watch_later_outlined,color: Constants.primaryColor1,size: 16,),
                          Text(   diff_s <= 60? "$diff_s""s":
                          diff_mi <= 60 ?"$diff_mi""m":
                          diff_hr <= 24 ? "$diff_hr""h":
                          diff_dy <= 30 ? "$diff_dy""d":
                          months <= 12 ? "$months""mo":
                          "$years""y",style: BlackFieldTitleStyle,)
                        ],
                      ),),

                  ],
                ),
                onTap: () {

                  if(
                  data.type.toString().trim().toUpperCase() == "MAINOFFER" ||
                      data.type.toString().trim().toUpperCase() == "COUNTEROFFER" ||
                      data.type.toString().trim().toUpperCase() == "TEMPLATE" ||
                      data.type.toString().trim().toUpperCase() == "DUPLICATE" ||
                      data.type.toString().trim().toUpperCase() == "INFORM" ||
                      data.type.toString().trim().toUpperCase() == "MATCH" ||
                      data.type.toString().trim().toUpperCase() == "ITEMSELECTED" ||
                      data.entityValue.toString()  != "null"
                  ) {
                    setState(() {
                      isOnNavigatorLoader = true;
                    });
                    var bodyparam = {
                      "user_id":DataManager.getInstance().getuserId().toString(),
                      "offer_id":data.offer.toString()
                    };
                    DrawAuraAPi.GetListData(body: bodyparam,ApiEndPoint: "getOfferDetailsWithCounter").then((OfferDetails) {
                      if(mounted){
                        setState(() {
                          OfferDataModelResult offerDetails = OfferDataModelResult.fromJson(OfferDetails["response"]);
                          var data = offerDetails;
                          var body = {
                            "offer_id": data.offerData!.id.toString(),
                            "user_id" : DataManager.getInstance().getuserId().toString()
                          };
                          bool  isCounterSellBuy = false ;
                          for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                            if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                              isCounterSellBuy = true;
                              break ;
                            }else{
                              isCounterSellBuy = false;
                            }
                          }
                          bool isConfirmingUser = false;
                          for(var i = 0 ; i<data.offerData!.ConfirmingSubscriber!.length; i++){
                            if(data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                              isConfirmingUser = true;
                              break ;
                            }else{
                              isConfirmingUser = false;
                            }
                          }
                          List <bool>isAllItemDone1 = [] ;
                          for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                            if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                              print("");
                              isAllItemDone1.add(true);
                            }else{
                              isAllItemDone1.add(false);
                            }
                          }
                          tapOnOffer(context,data,isCounterSellBuy,isConfirmingUser,isAllItemDone1);

                          isOnNavigatorLoader = false;

                        });
                      }
                    });

                  }
                  else if(
                  data.type.toString().trim().toUpperCase() == "FAVOURITE" ||
                      data.type.toString().trim().toUpperCase() == "LIKE" ||
                      data.type.toString().trim().toUpperCase() == "COMMENT" ||
                      data.type.toString().trim().toUpperCase() == "DISLIKE" ||
                      data.type.toString().trim().toUpperCase() == "FOLLOW" ||
                      data.type.toString().trim().toUpperCase() == "OFFEREXPIRED"
                  ){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 4),));
                  } else if(data.type.toString().trim().toUpperCase() == "EXPIRED"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => About_subscriptions(),));
                  }
                },
              );
            },),
          isOnNavigatorLoader == true?   Positioned(
            top: 0,bottom: 0,left: 0,right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: isMobile?width:tabWidth,
              decoration: BoxDecoration(color: Colors.black12),
              child:  Center(child: LoadingWidget()),
            ),
          ):SizedBox()
          ],
      ),
    );
  }

}
