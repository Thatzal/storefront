import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constatnt.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    var userId = sharedpreferences.getString("UserId");

    DataManager.getInstance().setuserId("UserId");
    if(userId==null){
      Timer(
          const Duration(seconds: 2),
              () async {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => login_screen(isGuestUser: false)));
          });
    } else{
      Timer(const Duration(seconds: 2),
              () async {
           if(userId == "1"){
             DataManager.getInstance().setuserId(sharedpreferences.getString("UserId"));
             DataManager.getInstance().setuserImage("null");
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2,),), (route) => false);

           }else{
             print("IsPlaceType");
             log(sharedpreferences.getString("isPlace").toString());


             DataManager.getInstance().setuserId(sharedpreferences.getString("UserId"));
             DataManager.getInstance().setphonedata(sharedpreferences.getString("UserMobile"));
             DataManager.getInstance().setuserImage(sharedpreferences.getString("userImage"));
             DataManager.getInstance().setuserName(sharedpreferences.getString("UserName"));
             DataManager.getInstance().setuserEmail(sharedpreferences.getString("UserEmail"));
             DataManager.getInstance().setOfferArea(sharedpreferences.getString("offerArea"));
             DataManager.getInstance().setUserDisplayName(sharedpreferences.getString("UserDisplayName"));
             DataManager.getInstance().setUserIsPlaceType(sharedpreferences.getString("isPlace"));
             DataManager.getInstance().setUserSecMobile(sharedpreferences.getString("userSecMobile"));
             print(DataManager.getInstance().getUserIsPlaceType().toString());
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2,),), (route) => false);
           }
         });
    }
  }
  @override
  Widget build(BuildContext context) {
    Constants.statusBar(Colors.transparent, Brightness.light);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile= ResponsiveHelper.isMobile(context);
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.tabBackGroundColor : Constants.tabBackGroundColor,
      body: responsiveContainer(
        context,Constants.primaryColor1,
        Image.asset("assets/splash.png",height: height,width:isMobile? width:tabWidth,fit: BoxFit.fill),
      ),
    );
  }
}
