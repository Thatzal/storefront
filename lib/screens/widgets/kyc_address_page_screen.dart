// import 'dart:io';
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:socialapps/Apis/api.dart';
// import 'package:socialapps/common/ResponsiveBuilder.dart';
// import 'package:socialapps/common/style.dart';
// import 'package:socialapps/constant/constatnt.dart';
// import 'package:socialapps/constant/loader.dart';
// import 'package:socialapps/constant/text_form_feild.dart';
// import 'package:socialapps/controller/DataManager.dart';
// import 'package:socialapps/model/GetKYCListModel.dart';
//
// Future<dynamic> KYCDocumentsAddressPage (BuildContext context,
//     {From,required KYCDocData KYDDocDetails}) {
//   TextEditingController kycdocController  = TextEditingController(text: From == "New"? "":KYDDocDetails.kycId.toString());
//   TextEditingController mobilenController  = TextEditingController(text: From == "New"? "":KYDDocDetails.phoneNumberOtp.toString());
//   TextEditingController KycDocFrontImageNameController  = TextEditingController();
//   TextEditingController KycDocBackImageNameController  = TextEditingController();
//   String? KYCAadhaarImagePath;
//   String? KYCAadhaarImagePath1;
//   String? selectedValue;
//   List getDocumentList=["Aadhaar Card","Voter Id","Pan Card","Driving License","Passport" ];
//   bool isSaveLoader =false;
//   return showModalBottomSheet(
//     backgroundColor: Colors.white,
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//     ),
//     builder: (BuildContext context) {
//       var width = MediaQuery.of(context).size.width;
//       var height = MediaQuery.of(context).size.height;
//       var tabWidth = ResponsiveHelper.TabModeWidth;
//       var tabHeight = ResponsiveHelper.TabModeHeight;
//       var isMobile= ResponsiveHelper.isMobile(context);
//       return StatefulBuilder(
//         builder: (context, setModalState) {
//           return Container(
//               height: MediaQuery.of(context).size.height * 0.80,
//               child: Scaffold(
//                 body: SafeArea(
//                   child: ListView(
//                     padding:
//                     EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     children: <Widget>[
//                       15.height,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text( From == "New" ?" Add KYC Address proof ":"Edit KYC Address proof",style: BlackBottomHeadStyle18500,),
//                           InkWell(
//                               onTap: (){
//                                 Navigator.pop(context);
//                               },
//                               child: Icon(Icons.close,size: 28,color: Colors.grey.shade800,))
//                         ],
//                       ),
//                       15.height,
//                       Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Select Document Type", style: BlackDescStyle,)),
//                       7.height,
//                       Container(
//                         height: 38,
//                         color: Colors.white,
//                         width: isMobile?width*0.7:tabWidth*0.7,
//                         child:
//                         DropdownButtonHideUnderline(
//                           child: DropdownButton2(
//                             hint:  Center(child: Text('Choose Document', style: Constants.hintStyle,)),
//                             items: getDocumentList.map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10.0,top: 8),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(item, style: BlackFieldStyle),
//                                       ],
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             )).toList(),
//                             value: selectedValue,
//                             onChanged: (value) {
//                               setModalState(() {
//                                 selectedValue = value;
//                               });
//                             },
//
//                             iconStyleData: const IconStyleData(
//                               icon: Icon(Icons.keyboard_arrow_down_sharp,),
//                               iconSize: 10,
//                               iconEnabledColor: Colors.white,
//                               iconDisabledColor:Colors.white,
//                             ),
//                             buttonStyleData: ButtonStyleData(
//                                 height:  35,
//                                 width:isMobile?width*0.9:tabWidth*0.9,
//                                 padding: const EdgeInsets.only(left: 10, right: 3),
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Constants.lightGreen,width: 1),
//                                     borderRadius: BorderRadius.circular(5),color: Colors.white),
//                                 elevation:  0,
//                                 overlayColor: MaterialStateProperty.all(Colors.white)
//                             ),
//                             menuItemStyleData: MenuItemStyleData(
//                               height: 33,
//                               selectedMenuItemBuilder: (context, child) {
//                                 return     Container(
//                                   padding: const EdgeInsets.only(left: 0, right: 0),
//                                   width:isMobile?width*0.3:tabWidth*0.3,
//                                   height: 30,color:Constants.primaryColor1,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       child,
//                                       const Padding(
//                                         padding: EdgeInsets.only(right: 5.0),
//                                         child: Icon(Icons.done,color: Colors.white,size: 20,),
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               },
//                               padding: const EdgeInsets.only(left: 8, right: 3),
//                             ),
//                             dropdownStyleData: DropdownStyleData(
//                               maxHeight: 200,
//                               padding: const EdgeInsets.only(left: 0, right: 0),
//                               width: isMobile?width*0.9:tabWidth*0.9,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.white,
//                                   border: Border.all(color:  Constants.primaryColor1,width: 1)
//                               ),
//                               elevation: 1,
//                               scrollbarTheme: ScrollbarThemeData(
//                                   radius:  const Radius.circular(20),
//                                   thickness: MaterialStateProperty.all(5.0),
//                                   minThumbLength: 20
//                               ),
//                               offset: const Offset(0, -5),
//                             ),
//                             style:  BlackFieldStyle
//                           ),
//                           // menuItemStyleData: const MenuItemStyleData(
//                           //   height: 30,
//                           // ),
//                         ),
//                       ),
//
//                       10.height,
//                       Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Document Number", style: BlackDescStyle,)),
//                       7.height,
//                       Container(
//                         height: 38,
//                         color: Colors.white,
//                         width: isMobile?width*0.7:tabWidth*0.7,
//                         child:
//                         TextFormField(
//                           controller: kycdocController,
//                           style: BlackFieldStyle,
//                           keyboardType: TextInputType.text,
//                           decoration: inputDecoration(context,hint: "Enter Kyc Document No.",  ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter Document Number';
//                             }
//                             // return null;
//                           },
//                           // obscureText: true,
//                         ),
//                       ),
//
//                       10.height,
//                       Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Mobile Number", style: BlackDescStyle,)),
//                       7.height,
//                       Container(
//                         height: 38,
//                         color: Colors.white,
//                         width: isMobile?width*0.7:tabWidth*0.7,
//
//                         child:
//                         TextFormField(
//                           controller: mobilenController,
//                           style: BlackFieldStyle,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [LengthLimitingTextInputFormatter(10),FilteringTextInputFormatter.digitsOnly],
//                           decoration: inputDecoration(context,hint: "Enter Mobile number", ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter Mobile Number';
//                             }
//                             // return null;
//                           },
//                           // obscureText: true,
//                         ),
//                       ),
//                       10.height,
//                       Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Document's Front Image", style: BlackDescStyle,)),
//                       7.height,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Container(
//                               height: 38,
//                               color: Colors.white,
//                               width: isMobile?width*0.7:tabWidth*0.7,
//
//                               child: TextFormField(
//
//                                 controller: KycDocFrontImageNameController,
//                                 style: BlackFieldStyle,
//                                 keyboardType: TextInputType.text,
//                                 readOnly: true,
//                                 decoration: inputDecoration(context,hint: "KYC Document Front Image", ),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               final ImagePicker picker = ImagePicker();
//                               final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                               XFile? xfilePick = pickedFile;
//                               setModalState(
//                                     () {
//                                   if (xfilePick != null) {
//                                     KycDocFrontImageNameController.text = pickedFile!.name.toString();
//                                     KYCAadhaarImagePath = pickedFile.path;
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
//                                         const SnackBar(content: Text('Nothing is selected',style: BlackFieldStyle,)));
//                                   }
//                                 },
//                               );
//
//                             },
//                             child:  Container(
//                                 width:isMobile?width*0.2:tabWidth*0.2,
//                                 height: 38 ,
//                                 decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen)),
//                                 child:KYCAadhaarImagePath == null ? Center (child:Text("Upload Image",style: greyHintStyle,)):Image.file(File(KYCAadhaarImagePath.toString()),fit: BoxFit.fill,)
//                             ),
//
//                           ),
//                         ],
//                       ),
//                       10.height,
//                       10.height,
//                       Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Document's Back Image", style: BlackDescStyle,)),
//                       7.height,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Container(
//                               height: 38,
//                               color: Colors.white,
//                               width: isMobile?width*0.7:tabWidth*0.7,
//
//                               child: TextFormField(
//
//                                 controller: KycDocBackImageNameController,
//                                 style: BlackFieldStyle,
//                                 keyboardType: TextInputType.text,
//                                 readOnly: true,
//                                 decoration: inputDecoration(context,hint: "KYC Document Back Image", ),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               final ImagePicker picker = ImagePicker();
//                               final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                               XFile? xfilePick = pickedFile;
//                               setModalState(
//                                     () {
//                                   if (xfilePick != null) {
//                                     KycDocBackImageNameController.text = pickedFile!.name.toString();
//                                     KYCAadhaarImagePath1 = pickedFile!.path;
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
//                                         const SnackBar(content: Text('Nothing is selected')));
//                                   }
//                                 },
//                               );
//
//                             },
//                             child:  Container(
//                                 width: isMobile?width*0.2:tabWidth*0.2,
//                                 height: 38 ,
//                                 decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(5),border: Border.all(color: Constants.lightGreen)),
//                                 child:KYCAadhaarImagePath1 == null ? Center (child:Text("Upload Image",style: greyHintStyle,)):Image.file(File(KYCAadhaarImagePath1.toString()),fit: BoxFit.fill,)
//                             ),
//
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 bottomSheet: Container(
//                   height: 80,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border(
//                           top: BorderSide(
//                               color: Constants.lightGreen, width: 1.5))),
//                   child: Center(
//                       child: ElevatedButton(
//                         child:   isSaveLoader? ButtonLoaderWhite(): Text(
//                           From == "New" ? "Save" : "Update",
//                           style: WhiteButtonStyle,
//                         ),
//                         onPressed: () {
//                           setModalState(() {
//                             isSaveLoader = true;
//                           });
//                           Map<String, String> bodyParam = From == "New"
//                               ? {
//                             "user":DataManager.getInstance().getuserId().toString(),
//                             "phone_number_otp":mobilenController.text,
//                             "kyc_name":selectedValue.toString(),
//                             "kyc_id":kycdocController.text,
//                           }
//                               : {
//                             "id":DataManager.getInstance().getuserId().toString(),
//                             "phone_number_otp":mobilenController.text,
//                             "kyc_name":selectedValue.toString(),
//                             "kyc_id":kycdocController.text,
//                           };
//                           String EndPoint =  From == "New" ?"addSubscriberKYC" : "addSubscriberKYC";
//                           DrawAuraAPi.KycDocUploadApi(data: bodyParam,backImage: KYCAadhaarImagePath1,frontImage: KYCAadhaarImagePath,EndPoint: EndPoint.toString())
//                               .then((value) {
//                             if (value.statusCode == 200) {
//                               setModalState(() {
//                                 isSaveLoader = false;
//                               });
//                               Constants.showToast("Kyc Update Successfully");
//                               Navigator.pop(context);
//                             } else {
//                               setModalState(() {
//                                 isSaveLoader = false;
//                               });
//                               Constants.showToast("Kyc Update Failed");
//                               Navigator.pop(context);
//                             }
//                           });
//
//
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Constants.primaryColor1,
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40),
//                           ),
//                           fixedSize:
//                           Size(isMobile?width*0.8:tabWidth*0.8, 40),
//                         ),
//                       )),
//                 ),
//               ));
//         },
//       );
//     },
//   );
// }
//
//
//
