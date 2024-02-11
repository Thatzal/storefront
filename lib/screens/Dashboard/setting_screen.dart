
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/SettingScreenController.dart';
import 'package:socialapps/screens/setting/push_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/screens/widgets/GuestLogInScreen.dart';
import 'package:socialapps/screens/widgets/PrivacyPolicyAgree.dart';
import 'package:socialapps/screens/widgets/feedback_dialog.dart';
import '../../Auth/login_screen.dart';
import '../../common/style.dart';
import '../setting/about_tatzal.dart';
import '../setting/manage_adress_screen.dart';
import '../setting/manage_profile_screen.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../widgets/ManageAccountBottomSheet.dart';
import '../widgets/TermsAndConditionsAgree.dart';
import 'package:get/get.dart';

class setting_screen extends StatelessWidget {
  const setting_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingController>(
        init: SettingController(),
      initState: (state) async{
          state.controller!.GetUserAccount();
      },
      builder: (controller) {
        var width = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).size.height;
        var tabWidth = ResponsiveHelper.TabModeWidth;
        var tabHeight = ResponsiveHelper.TabModeHeight;
        var isMobile= ResponsiveHelper.isMobile(context);
        print(controller.token.value);
        return Scaffold(
          backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          body: responsiveContainer(context,
              ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leadingWidth: 150,
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Center(child: Text("Settings", style: AppBarTitle,),),
                  ),
                  actions: [
                    DataManager.getInstance().getuserId().toString() == "1"?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 85,
                            child: InkWell(
                              onTap: () async {
                                final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                                sharedpreferences.clear();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: true),), (route) => false);

                              },
                              child: Card(
                                elevation: 1,
                                shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  // side: BorderSide(color: Color(0xFFdbe3e5),width: 1.5)
                                ),
                                color: primaryColor,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:const [
                                    Text("Log In", style: WhiteTitleStyle),
                                    SizedBox(width: 5,),
                                    Icon(Icons.login,color: Colors.white,size: 16,),
                                  ],
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        :
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: InkWell(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        elevation: 16,
                                        child: Container(
                                          width: ResponsiveHelper.isMobile(context)?MediaQuery.sizeOf(context).width:ResponsiveHelper.TabModeWidth*0.9,
                                          child: ListView(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(vertical: 20),
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 70,width: 130,
                                                    decoration: BoxDecoration(
                                                      color: Constants.primaryColor1,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset("assets/Thatzal_logo.png"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top:10,bottom: 10),
                                                child: Text('Come back soon!',style: Black87DescStyle,textAlign: TextAlign.center),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(bottom: 20.0),
                                                child: Text("Are you sure you want to logout?",style: Black87HintStyle,textAlign: TextAlign.center),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () async{
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Constants.primaryColor1,
                                                        fixedSize: Size(ResponsiveHelper.isMobile(context)?width*0.30:ResponsiveHelper.TabModeWidth*0.30, 35),
                                                        elevation: 1,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7)),
                                                      ),
                                                      child: const Text("Cancel",style:WhiteButtonStyle,)),
                                                  ElevatedButton(
                                                      onPressed: () async{

                                                          controller.butttonLoader.value = true;

                                                        Future.delayed(const Duration(
                                                            milliseconds: 200), () async {
                                                          final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                                                          sharedpreferences.clear();
                                                          var body = {
                                                            "id":DataManager.getInstance().getuserId().toString(),
                                                            "deviceToken" : "",
                                                          };
                                                          DrawAuraAPi.CreateDataApi(ApiEndPoint: "updateSubscriberProfile",body: body);
                                                          controller.butttonLoader.value = false;
                                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                                                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: false),), (route) => false);

                                                        });
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Constants.primaryColor1,
                                                        fixedSize: Size(ResponsiveHelper.isMobile(context)?width*0.30:ResponsiveHelper.TabModeWidth*0.30, 35),
                                                        elevation: 1,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(7)),
                                                      ),
                                                      child: const Text("Logout",style:WhiteButtonStyle,)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                    );
                                  },
                                );

                              },
                              child: Card(
                                elevation: 1,
                                shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  // side: BorderSide(color: Color(0xFFdbe3e5),width: 1.5)
                                ),
                                color: primaryColor,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:const [
                                    Text(" Logout", style: WhiteTitleStyle),
                                    SizedBox(width: 14,),
                                    Icon(Icons.logout_rounded,color: Colors.white,size: 15,),
                                  ],
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      //   child: Column(
                      //     children: [
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children:  [
                      //           Align(
                      //               alignment:Alignment.topLeft,
                      //               child: Text("Subscription",style: BlackTabStyle,)),
                      //           SizedBox(
                      //             height: 5,
                      //           ),
                      //           Align(
                      //               alignment: Alignment.topLeft  ,
                      //               child: isLoading == true ? Text("Valid till : -- ",style: greySubTitleItalicStyle,):
                      //               Text("Valid till : ${PlanResultDetails!.expireAt == null ? "--" :PlanResultDetails!.expireAt}",style: greySubTitleItalicStyle,)
                      //           )
                      //         ],),
                      //       const SizedBox(height: 10,),
                      //       // isLoading? SizedBox(): Row(
                      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       //   children: [
                      //       //     Container(
                      //       //       height: 25,
                      //       //       alignment: Alignment.centerLeft,
                      //       //       child: ElevatedButton(
                      //       //           style: ElevatedButton.styleFrom(
                      //       //               backgroundColor:   Constants.primaryColor,
                      //       //               fixedSize: Size(ResponsiveHelper.isMobile(context)?width*0.23:ResponsiveHelper.TabModeWidth*0.23, 12),
                      //       //               padding: EdgeInsets.zero,
                      //       //               elevation: 0
                      //       //           ),
                      //       //           onPressed: () {
                      //       //             Navigator.push(context, MaterialPageRoute(builder: (context) => About_subscriptions(),));
                      //       //           }, child: const Text("Current plan",style: WhiteHintStyle,)),
                      //       //     ),
                      //       //     PlanResultDetails!.plan!.type.toString().toUpperCase()=="FREE"?
                      //       //     Container(
                      //       //       height: 25,
                      //       //       alignment: Alignment.centerLeft,
                      //       //       child: ElevatedButton(
                      //       //           style: ElevatedButton.styleFrom(
                      //       //               backgroundColor:  Constants.primaryColor,
                      //       //               fixedSize: Size(ResponsiveHelper.isMobile(context)?width*0.23:ResponsiveHelper.TabModeWidth*0.23, 12),
                      //       //               padding: EdgeInsets.zero,
                      //       //               elevation: 0
                      //       //           ),
                      //       //           onPressed: () {
                      //       //             Navigator.push(context, MaterialPageRoute(builder: (context) => About_subscriptions(),));
                      //       //           }, child: const Text("Pay Now",style: WhiteHintStyle,)),
                      //       //     ):SizedBox(),
                      //       //   ],
                      //       // ),
                      //       const SizedBox(height: 8,),
                      //       isLoading?ButtonLoaderGreen():
                      //       PlanResultDetails!.plan!.type == null ?SizedBox():   Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(PlanResultDetails!.plan!.type == null?"": "${ PlanResultDetails!.plan!.type}",style: BlackTitleStyle,),
                      //           Text(PlanResultDetails!.plan!.price == null ? "--": "Rs.${ PlanResultDetails!.plan!.price}/-",style: BlackSubTitleStyle,),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 8,
                      //       ),
                      //
                      //       isLoading?  SizedBox():
                      //
                      //       PlanResultDetails!.expireAt.toString() == "Expired" ?
                      //       Container(
                      //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //         decoration:  BoxDecoration(
                      //             color: Colors.transparent,
                      //             borderRadius: BorderRadius.circular(3),
                      //             border: Border.all(color: Constants.primaryColor,width: 1.5)
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text("Your plan has been expired please subscribe now for publish other offers."),
                      //             const SizedBox(height: 10,),
                      //             // InkWell(
                      //             //     onTap:(){
                      //             //       Get.to(()=>subcription_screen(From: "Setting",));
                      //             //     },
                      //             //     child: const Text("Manage Plans & Payments",style: PrimarySubTitleStyleUl)),
                      //             5.height
                      //           ],
                      //         ),
                      //       )
                      //           :
                      //       Container(
                      //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //         decoration:  BoxDecoration(
                      //             color: Colors.transparent,
                      //             borderRadius: BorderRadius.circular(3),
                      //             border: Border.all(color: Constants.primaryColor,width: 1.5)
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children:  [
                      //                     SizedBox(
                      //                       width: ResponsiveHelper.isMobile(context)?width*0.7:ResponsiveHelper.TabModeWidth*0.7,
                      //                       child: Text(
                      //                         PlanResultDetails!.plan!.title== null ? "-": "${PlanResultDetails!.plan!.title}",style: greyFieldStyle,
                      //                         textAlign: TextAlign.left,
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                       width: ResponsiveHelper.isMobile(context)?width*0.7:ResponsiveHelper.TabModeWidth*0.7,
                      //                       child: Text(
                      //                         PlanResultDetails!.plan!.subTitle == null ? "": "${PlanResultDetails!.plan!.subTitle}",style: greyFieldStyle,
                      //                         textAlign: TextAlign.left,
                      //                       ),
                      //                     ),
                      //                     Text(
                      //                       PlanResultDetails!.expireAt == null ? "--": "Expire on : ${PlanResultDetails!.expireAt}",style: greyFieldStyle,
                      //                       textAlign: TextAlign.left,
                      //                     ),
                      //                     Text(
                      //                       "Switch off to cancel auto renew.",style: greyFieldStyle,
                      //                       textAlign: TextAlign.left,
                      //                     )
                      //                   ],
                      //                 ),
                      //                 FlutterSwitch(
                      //                   showOnOff: false,
                      //                   value: onSwitch,
                      //                   toggleSize: 20,
                      //                   padding: 0.5,
                      //                   height: 20,
                      //                   width: 35,valueFontSize: 14,
                      //                   activeColor:SwitchActiveColor,
                      //                   inactiveColor: SwitchUnActiveColor,
                      //                   onToggle: (newVal) async {
                      //                     setState(() {
                      //                       onSwitch = !onSwitch;
                      //                     });
                      //
                      //                   },
                      //                 ),
                      //
                      //               ],
                      //             ),
                      //             // const SizedBox(height: 10,),
                      //             // InkWell(
                      //             //     onTap:(){
                      //             //       Get.to(()=>subcription_screen(From: "Setting",));
                      //             //     },
                      //             //     child: const Text("Manage Plans & Payments",style: BlackSubTitleStyleUl)),
                      //             5.height
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Column(
                        children: [
                          Divider(color: DividerColor,thickness: 1,),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                if(DataManager.getInstance().getuserId().toString() == "1"){
                                  GuestLoginDialog(context);
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ManageProfileScreen(From: "Setting"),));
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Manage Profile / Page",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                if(DataManager.getInstance().getuserId().toString() == "1"){
                                  GuestLoginDialog(context);
                                }else{

                                  if(controller.isGetSubscriberAccounts.value ){
                                    Constants.showToast("Please wait getting your account");
                                  }else {
                                    ManageAccount(context,
                                        getUserAccountList: controller.getUserAccountList,
                                        selectedUserValue: controller.selectedUserValue.value,
                                        token: controller.token.value);
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Manage Accounts",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                if(DataManager.getInstance().getuserId().toString() == "1"){
                                  GuestLoginDialog(context);
                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ManageAddressScreen(from: "setting"),));
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Manage Addresses",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){


                                Navigator.push(context,MaterialPageRoute(builder: (context) => const push_notification(),));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Push Notifications",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  TermsAndConditionAgree(From: "Setting"),));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Terms of Service",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  PrivacyPolicyAgree(From: "Setting"),));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Privacy Policy",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                if(DataManager.getInstance().getuserId().toString() == "1"){
                                  GuestLoginDialog(context);
                                }else{
                                  showFeedBackDialog(context);
                                }

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Feedback",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),

                          Padding(
                            padding: const EdgeInsets.only(top: 7.0,bottom: 7,left: 20,right: 20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutThatZalScreen(),));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("About Thatzal",style: BlackHeadingStyle,),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: primaryColor,),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: DividerColor,thickness: 1,),


                        ],
                      )
                    ],
                  ),
                ),

              )),
        );
      },
    );
  }
}



