import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';

import '../../common/style.dart';

Future<dynamic> Notification_permission_dialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var tabWidth = ResponsiveHelper.TabModeWidth;
      var tabHeight = ResponsiveHelper.TabModeHeight;
      var isMobile= ResponsiveHelper.isMobile(context);
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetAnimationDuration: Duration(milliseconds: 100),
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        elevation: 2,
        child: Container(
          width: ResponsiveHelper.isMobile(context)?null:ResponsiveHelper.TabModeWidth*0.85,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                // Container(
                //   height: 4,
                //   width: 32,
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Color(0xFF7F7C85)),
                // ),
                SizedBox(
                  height: 10,
                ),
                Lottie.asset(
                  'assets/Notification.json',
                  height: 100,
                  width: 100,
                ),
                Text(
                  "Enable Notifications?",
                  style: BlackBottomHeadStyle18500,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(

                  "To receive Offer alerts and your account updates, turn on the Notifications!",
                  style: blue14500, textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: isMobile?width*0.35:tabWidth*0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Constants.primaryColor1, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.primaryColor1.withOpacity(0.10),
                              blurRadius: 2.0,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text("Close",style: PrimaryColorStyle16500,)),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // WidgetsFlutterBinding.ensureInitialized();
                        requestNotificationPermission();
                      },
                      child: Container(
                        height: 40,
                        width: isMobile?width*0.35:tabWidth*0.35,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor1,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.primaryColor1.withOpacity(0.10),
                              blurRadius: 2.0,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(child: Text("Allow", style: WhiteButtonStyle16500,)),),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  // await Get.bottomSheet(
  //   barrierColor: Colors.black12,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
  //   ),
  //   enableDrag: true,
  //   Container(
  //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //     ),
  //     child: SingleChildScrollView(
  //       physics: NeverScrollableScrollPhysics(),
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 4,
  //             width: 32,
  //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Color(0xFF7F7C85)),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Lottie.asset(
  //             'assets/Notification.json',
  //             height: 100,
  //             width: 100,
  //           ),
  //           Text(
  //             "Enable Notifications?",
  //             style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             "To receive booking alerts and turf tournaments updates, turn on the Notifications!",
  //             style: TextStyle(color: Color(0xFF00204F), fontSize: 14, fontWeight: FontWeight.w500),
  //             textAlign: TextAlign.center,
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   Get.back();
  //                 },
  //                 child: Container(
  //                   height: 45,
  //                   width: MediaQuery.of(context).size.width * 0.42,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(25),
  //                     border: Border.all(color: Constants.buttonColor, width: 1.5),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Constants.buttonColor.withOpacity(0.10),
  //                         blurRadius: 1.0,
  //                         spreadRadius: 1,
  //                         offset: const Offset(0, 4),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Center(
  //                       child: Text(
  //                     "Close",
  //                     style: TextStyle(fontWeight: FontWeight.w500, color: Constants.buttonColor, fontSize: 16),
  //                   )),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   // WidgetsFlutterBinding.ensureInitialized();
  //                   requestPermission();
  //                 },
  //                 child: Container(
  //                   height: 45,
  //                   width: MediaQuery.of(context).size.width * 0.42,
  //                   decoration: BoxDecoration(
  //                     color: Constants.buttonColor,
  //                     borderRadius: BorderRadius.circular(25),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Constants.buttonColor.withOpacity(0.10),
  //                         blurRadius: 1.0,
  //                         spreadRadius: 1,
  //                         offset: const Offset(0, 4),
  //                       ),
  //                     ],
  //                   ),
  //                   child: Center(
  //                       child: Text(
  //                     "Allow",
  //                     style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
  //                   )),
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   ),
  // );
}

requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    Get.back();
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User grander provisional permission');
    Get.back();
  } else {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      print("Android V");
      print(release);
      if (int.parse(release) >= 13) {
        // await Permission.notification.request().then(
        //       (value) => print(value.index),
        //     );
        await Permission.notification.isDenied.then((value) {
          print(value);
          if (value) {
            //print("permission is NOT granted.");
            Permission.notification.request().then((value) {
              //print("permission is NOT granted.");
              if (value.index == 1) {
                print("Granteddddd");
                Get.back();
              }
            });
          } else {
            print("permission is granted");
            Get.back();
          }
        });
      } else {
        openAppSettings().then((value) async {
          await Permission.notification.isDenied.then((value) {
            if (value) {
              Permission.notification.request();
              print("Permission Not granted");
            } else {
              Get.back();
            }
          });
        });
      }
      // var sdkInt = androidInfo.version.sdkInt;
      // var manufacturer = androidInfo.manufacturer;
      // var model = androidInfo.model;
      // print('Android $release (SDK $sdkInt), $manufacturer $model');
    } else {
      PermissionStatus status = await Permission.notification.request();
      if (status.isGranted) {
        print("isGranted");
        Get.back();
        // notification permission is granted
      } else {
        await openAppSettings().then((value) async {
          print("open settings ios");
          await Permission.notification.isDenied.then((value) {
            if (value) {
              Permission.notification.request();
              print("Permission Not granted");
            } else {
              Get.back();
            }
          });
        });
        // Open settings to enable notification permission
      }
    }

    print('User declined or has not accepted permission');
  }
}
