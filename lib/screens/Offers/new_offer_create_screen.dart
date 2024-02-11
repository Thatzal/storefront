// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ffi';
// import 'dart:io';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:socialapps/common/ResponsiveBuilder.dart';
// import 'package:socialapps/common/style.dart';
// import 'package:socialapps/constant/constatnt.dart';
// import 'package:socialapps/controller/NewOfferController.dart';
// import 'package:socialapps/screens/widgets/NewAddressPickers/NewAddressPickerList.dart';
//
// class NewOfferCreatorScreen extends StatelessWidget {
//   const NewOfferCreatorScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     var tabWidth = ResponsiveHelper.TabModeWidth;
//     var tabHeight = ResponsiveHelper.TabModeHeight;
//      return GetX<NewOfferController>(
//        initState: (value){
//
//        },
//        init: NewOfferController(),
//        builder: (controller) {
//          return  responsiveContainer(
//            context,
//            ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
//             Scaffold(
//               appBar:AppBar(
//                 backgroundColor: const Color(0xFFE7E6E6),
//                 toolbarHeight: 40,
//                 elevation: 0,
//                 automaticallyImplyLeading: false,
//                 title:controller.cateLoader.value==true?const SizedBox(): Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(controller.saveAddressTitle.value==""?"":controller.saveAddressTitle.value=="null"? "":'${controller.saveAddressTitle.value}', style: BlackTitleStyle),
//                     Flexible(
//                       child: Container(
//                         height: 30,
//                         margin: EdgeInsets.only(left:5),
//                         padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child:Center(
//                           child: TextFormField(
//                             controller: controller.adressLocationController.value.text.isEmpty?TextEditingController(text:"Select Address"): controller.adressLocationController.value,
//                             onTap:() async {
//                               if(controller.LatitudeLongitude.value == null ){
//                                 Constants.showToast("Please wait");
//                               }else{
//                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewAddressPickerList(latLong: LatitudeLongitude!,isAppPlaceView: true))).then((value) {
//                                   adressLocationController.text = value;
//                                   _currentTapindex == 1 ?  OfferFromLocationController.text = adressLocationController.text :OfferToLocationController.text =  adressLocationController.text;
//                                   isViewOfferToLocation=true;
//                                 });
//                               }
//                             },
//                             readOnly:true,
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration(hintText:"Select Address", fillColor:  Colors.white, hintStyle: greyHintStyle,
//                               focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
//                               enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
//                               floatingLabelBehavior: FloatingLabelBehavior.never,
//                               contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
//                               border: const OutlineInputBorder(),
//                             ),
//                             style: Black87HintStyle,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//            ),
//          );
//        },
//      );
//   }
// }
