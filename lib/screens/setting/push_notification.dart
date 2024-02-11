
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';

import '../../common/style.dart';
import '../../model/GetPushNotificationModal.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
class push_notification extends StatefulWidget {
  const push_notification({Key? key}) : super(key: key);

  @override
  State<push_notification> createState() => _push_notificationState();
}

class _push_notificationState extends State<push_notification> {

  bool loader = false;
  bool isnotify_offer_response = true;
  bool isnotify_offer_confirmation = true;
  bool isnotify_offer_executions = true;
  bool notify_offer_cancellation = true;
  bool notify_offer_copy = true;
  bool notify_offer_favorited = true;
  bool notify_follower = true;
  bool notify_mentions = true;
  bool notify_views = true;
  bool notify_expiry = true;
  bool notify_matched_offers = true;
  bool notify_current_loc_connect = true;


  GetPushNotificationResult? PushNotificationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load(){
    setState(() {
      loader=true;
    });
    DrawAuraAPi().getPushNotificationApi().then((value) {
         print(value.result.toString());
         // PushNotificationSettings=value.result;
         setState(() {
           isnotify_offer_response = value.result!.notifyOfferResponse!;
           isnotify_offer_confirmation = value.result!.notifyOfferConfirmation!;
           isnotify_offer_executions = value.result!.notifyOfferExecutions!;
           notify_offer_cancellation = value.result!.notifyOfferCancellation!;
           notify_offer_copy = value.result!.notifyOfferCopy!;
           notify_offer_favorited = value.result!.notifyOfferFavorited!;
           notify_follower = value.result!.notifyFollower!;
           notify_mentions = value.result!.notifyMentions!;
           notify_views = value.result!.notifyViews!;
           notify_expiry = value.result!.notifyExpiry!;
           notify_matched_offers = value.result!.notifyMatchedOffers!;
           notify_current_loc_connect = value.result!.notifyCurrentLocConnect!;
           loader=false;
         });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,titleSpacing: 0,
              leading: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back,color: Colors.black,)),
              title: const Text("Push Notification",style: AppBarTitle),
            ),
            body:loader==false?SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),

                    width: isMobile?width:tabWidth,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFE0E0E0),
                    ),
                    child: const Text("FROM THATZAL",style: BlackTitleBoldStyle,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("New followers",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_follower,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_follower = !notify_follower;
                            });
                            var newFollowers = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_follower":notify_follower.toString(),
                            };
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: newFollowers).then((value) {
                              if(value["status"]=="200"){
                                String OnOff = notify_follower == true ?"on":"off";
                                Constants.showToast("Followers notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current location connect alert",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_current_loc_connect,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_current_loc_connect = !notify_current_loc_connect;
                            });
                            var locationValue = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_current_loc_connect":notify_current_loc_connect.toString(),
                            };
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: locationValue).then((value) {
                              if(value["status"]=="200"){
                                String OnOff = notify_current_loc_connect == true ?"on":"off";
                                Constants.showToast("Current location connect alert notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Offer expiry",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_expiry,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_expiry = !notify_expiry;
                            });
                            var expiryValue = {
                              "id":DataManager.getInstance().userId,
                              "notify_expiry":notify_expiry.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: expiryValue).then((value) {
                              if(value["status"]=="200"){
                                String OnOff = notify_expiry == true ?"on":"off";
                                Constants.showToast("Offer expiry notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),


                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 15,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Offer executions",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: isnotify_offer_executions,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              isnotify_offer_executions = !isnotify_offer_executions;
                            });
                            var executionsValue = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_offer_executions":isnotify_offer_executions.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: executionsValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = isnotify_offer_executions == true ?"on":"off";
                                Constants.showToast("Offer executions notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,height: 0),


                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                    width: isMobile?width:tabWidth,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFE0E0E0),
                    ),
                    child: const Text("FROM SUBSCRIBERS",style: BlackTitleBoldStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User responses",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: isnotify_offer_response,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              isnotify_offer_response = !isnotify_offer_response;
                            });
                            var responseValue = {
                              "id":DataManager.getInstance().userId,
                              "notify_offer_response":isnotify_offer_response.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: responseValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = isnotify_offer_response == true ?"on":"off";
                                Constants.showToast("User responses notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User confirmations",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: isnotify_offer_confirmation,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              isnotify_offer_confirmation = !isnotify_offer_confirmation;
                            });
                            var confirmValue = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_offer_confirmation":isnotify_offer_confirmation.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: confirmValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = isnotify_offer_confirmation == true ?"on":"off";
                                Constants.showToast("User confirmations notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Matching offers",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_matched_offers,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_matched_offers = !notify_matched_offers;
                            });
                            var matchingValue = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_matched_offers":notify_matched_offers.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: matchingValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = notify_matched_offers == true ?"on":"off";
                                Constants.showToast("Matching offers notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User favourites",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_offer_favorited,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_offer_favorited = !notify_offer_favorited;
                            });
                            var favoriteValue = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_offer_favorited":notify_offer_favorited.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: favoriteValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = notify_offer_favorited == true ?"on":"off";
                                Constants.showToast("User favourites notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Offer duplications",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_offer_copy,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_offer_copy = !notify_offer_copy;
                            });
                            var duplicateValue = {
                              "id":DataManager.getInstance().userId.toString(),
                              "notify_offer_copy":notify_offer_copy.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: duplicateValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = notify_offer_copy == true ?"on":"off";
                                Constants.showToast("Offer duplications notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User mentions",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_mentions,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_mentions = !notify_mentions;
                            });
                            var mentionValue = {
                              "id":DataManager.getInstance().userId,
                              "notify_mentions":notify_mentions.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: mentionValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = notify_mentions == true ?"on":"off";
                                Constants.showToast("User mentions notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User views",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_views,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_views = !notify_views;
                            });
                            var viewValue = {
                              "id":DataManager.getInstance().userId,
                              "notify_views":notify_views.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: viewValue).then((value) {

                              if(value["status"]=="200"){
                                String OnOff = notify_views == true ?"on":"off";
                                Constants.showToast("User views notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),

                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User cancellations",style: BlackFieldStyle,),
                        FlutterSwitch(
                          showOnOff: false,
                          value: notify_offer_cancellation,
                          toggleSize: 20,
                          padding: 1,
                          height: 20,
                          width: 35,valueFontSize: 14,
                          activeColor:SwitchButtonActiveColor,
                          inactiveColor: SwitchUnActiveColor,
                          onToggle: (newVal) async {
                            setState(() {
                              notify_offer_cancellation = !notify_offer_cancellation;
                            });
                            var cancellationsValue = {
                              "id":DataManager.getInstance().userId,
                              "notify_offer_cancellation":notify_offer_cancellation.toString(),
                            };
                            // print(newFollowrs);
                            DrawAuraAPi().updatePushNotificationSettingsApi(notifyValue: cancellationsValue).then((value) {
                              if(value["status"]=="200"){
                                String OnOff = notify_offer_cancellation == true ?"on":"off";
                                Constants.showToast("User cancellations notification is $OnOff" );
                              }else{
                                Fluttertoast.showToast(
                                    msg: value["message"].toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0
                                );
                              }
                              // print("followers");
                              // print(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(color: DividerColor,thickness: 1,),
                ],
              ),
            ):const Center(child: LoadingWidget()),
          )),
    );

  }
}
