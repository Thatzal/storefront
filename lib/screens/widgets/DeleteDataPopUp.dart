import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loader.dart';

import '../../common/ResponsiveBuilder.dart';

Future<dynamic> DeleteDataPopUp(BuildContext context,{required String ApiEndPoint,required Map<dynamic,String> body}){
   return showDialog<void>(
     context: context,

     builder: (BuildContext context) {
       bool isDelete = false;
       var width = MediaQuery.of(context).size.width;
       var height = MediaQuery.of(context).size.height;
       var tabWidth = ResponsiveHelper.TabModeWidth;
       var tabHeight = ResponsiveHelper.TabModeHeight;
       var isMobile= ResponsiveHelper.isMobile(context);
       return StatefulBuilder(builder: (context, setModalSate) {
         return  Dialog(
             shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
             elevation: 16,
             child: Container(
               width:  isMobile?width:tabWidth*0.8,
               margin: EdgeInsets.symmetric(horizontal: 20),
               child: ListView(
                 shrinkWrap: true,
                 padding: const EdgeInsets.symmetric(vertical: 20),
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.delete_forever_outlined,color: Colors.red,size: 48),
                     ],
                   ),
                   15.height,
                   const Padding(
                     padding: EdgeInsets.only(bottom: 20.0),
                     child: Text("Are you sure you want \nto Delete ?",style:BlackHeadingStyle,textAlign: TextAlign.center,
                   ),
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
                             fixedSize: Size(isMobile?width*0.3:tabWidth*0.3, 35),
                             elevation: 1,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(7)),
                           ),
                           child: const Text("Cancel",style:WhiteButtonStyle,)),
                       ElevatedButton(
                           onPressed: () async{
                             setModalSate((){
                               isDelete = true;
                             });
                             DrawAuraAPi.CreateDataApi(ApiEndPoint:ApiEndPoint,body: body ).then((value) {
                               setModalSate((){
                                 isDelete = false;
                               });
                               Constants.showToast(value["message"]);
                               Navigator.pop(context);
                             });
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Constants.primaryColor1,
                             fixedSize: Size(isMobile?width*0.3:tabWidth*0.3, 35),
                             elevation: 1,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(7)),
                           ),
                           child: isDelete == true? ButtonLoaderWhite(): Text("Delete",style:WhiteButtonStyle,)),
                     ],
                   ),
                 ],
               ),
             )
         );
       },);
     },
   );
}