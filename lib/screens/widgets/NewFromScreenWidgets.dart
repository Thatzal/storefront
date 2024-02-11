
   import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/model/filtterOfferDetailsModel.dart';

   horizontalCardScroll(context,Callback onTap(i),List<FiltterOfferDetailsModel> List){
   return  SizedBox(
       height: 45,
       width: double.infinity,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         physics: const ClampingScrollPhysics(),
         shrinkWrap: true,
         itemCount:List.length,
         itemBuilder: (context, index) {
           var data = List[index];
           return InkWell(
             onTap: onTap(index),
             child: Container(
               margin: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
               decoration: BoxDecoration(color: Constants.greyLight, borderRadius: BorderRadius.circular(8),),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children:  [
                   Text("${data.offerItems!.first.name.toString()}", style: BlackDescStyle,),
                   SizedBox(width: 7,),
                   // Padding(
                   //   padding: EdgeInsets.only(bottom: 0),
                   //   child: Icon(Icons.access_time_outlined,color: Colors.black,size: 15,),
                   // ),
                   // SizedBox(width: 2,),
                   // Text("4d"
                   //   // diff_s <= 60? "$diff_s""s":
                   //   // diff_mi <= 60 ?"$diff_mi""m":
                   //   // diff_hr <= 24 ? "$diff_hr""h":
                   //   // diff_dy <= 30 ? "$diff_dy""d":
                   //   // months <= 12 ? "$months""months":
                   //   // "$years"
                   //
                   //   ,style: BlackDescStyle,)
                 ],
               ),
             ),
           );
         },
       ),
     );
   }

   TextForNewAdd(context,{required String text,required Callback  onTap}){
     return Padding(
       padding: const EdgeInsets.only(top: 5.0,right: 5),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(text,style: BlackDescStyleItelic,),
           2.width,
           InkWell(
               onTap: onTap,
               child: Icon(Icons.add_circle_sharp,color: primaryColor,size: 22,))
         ],
       ),
     );
   }