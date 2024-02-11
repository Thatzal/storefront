
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/Auth/login_screen.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/screens/Dashboard/dashboard_screen.dart';

import '../../common/ResponsiveBuilder.dart';

Future<void> GuestLoginDialog(BuildContext context) async {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  bool accountSwitchLoader = false;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setDialogState) {
        return Dialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 16,
            insetPadding: EdgeInsets.symmetric(horizontal:22),
            child: Container(
              width:  isMobile?width:tabWidth*0.85,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 0),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top:0,bottom: 10),
                        child: Text('Account',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                      ),
                      Row(
                        children: [
                          Flexible(child: Text("Login/Create Account for User specific services ",style:  TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
                        ],
                      ),

                      SizedBox(height: 15,),

                      ElevatedButton(
                        onPressed: () async{
                          final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                          sharedpreferences.clear();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: true),), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor1,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fixedSize:
                          Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.8:ResponsiveHelper.TabModeWidth*0.8, 40),
                        ),
                        child: Center(
                          child: Text("LogIn",style: WhiteButtonStyle,),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                   left: 0,
                      top: 5,
                      child:  InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(Icons.clear_outlined,color: Constants.primaryColor1,size: 18,),
                          ),

                        ),
                      ))
                ],
              ),
            )
        );
      },);
    },
  );
}

class GuestUserLogInScreen extends StatelessWidget {
  const GuestUserLogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(
        context,
        ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
         Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFFF5F5F5),
            automaticallyImplyLeading: false,
            titleSpacing: 40,
            title: const Text("Guest", style: AppBarTitle),

          ),
          body:    Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top:0,bottom: 10),
                        child: Text('Account',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                      ),
                      Row(
                        children: [
                          Flexible(child: Text("Login/Create Account for User specific services ",style:  TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
                        ],
                      ),

                      SizedBox(height: 15,),

                      ElevatedButton(
                        onPressed: () async{
                          final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
                          sharedpreferences.clear();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login_screen(isGuestUser: true),), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor1,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fixedSize:
                          Size(ResponsiveHelper.isMobile(context)?MediaQuery.of(context).size.width * 0.8:ResponsiveHelper.TabModeWidth*0.8, 40),
                        ),
                        child: Center(
                          child: Text("LogIn",style: WhiteButtonStyle,),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    left: 25,
                    top: 5,
                    child:  InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard_screen(backIndex: 2),), (route) => false);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.clear_outlined,color: Constants.primaryColor1,size: 18,),
                        ),

                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
