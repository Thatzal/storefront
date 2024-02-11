

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';

AbuseContentReportWarning(context , Callback onTap){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return showDialog(context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, setModalState) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.white,

          child: Container(
            width:  isMobile?width:tabWidth*0.85,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                children: [

                  Text("Do you want to report the Abuse?", style:BlackBottomHeadStyle18500,textAlign: TextAlign.center,),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color:Color(0xFFFFEDEA),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width:  isMobile?width:tabWidth*0.85,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.warning_rounded,color:Color(0xFFf35627) ,),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 3,),
                                        Text("Warning",style: TextStyle(color: Color(0xFFA85346),fontSize: 14,fontWeight: FontWeight.w500),),
                                        SizedBox(height: 3,),
                                        Text("After reporting this user not able to biding in next level.",style: TextStyle(color: Color(0xFFC05D44),fontSize: 12,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  )
                                ],
                              )

                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              //padding: EdgeInsets.only(left: 10),
                              // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color:Color(0xFFf35627),
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                              ),
                              width: 3.5,
                              height: 70,
                            ),)
                        ],
                      ),
                    ],
                  ),
                  25.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },

                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          fixedSize: Size(isMobile?width*0.3:tabWidth*0.3, 40),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          primary:primaryColor,
                        ),
                        child: Text(
                          'Cancel',
                          style: WhiteButtonStyle,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          fixedSize: Size(isMobile?width*0.3:tabWidth*0.3, 40),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          primary:primaryColor,
                        ),
                        child: Text(
                          'Yes',
                          style: WhiteButtonStyle,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },);
    },).then((value) {
  });
}