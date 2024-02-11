

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/IntermediateOfferDataModel.dart';
import 'package:socialapps/screens/Dashboard/home/OtherUserProfileViewScreen.dart';
import 'package:socialapps/screens/lastCounterScreen.dart';
import '../../../common/style.dart';
import '../../../constant/constatnt.dart';
import '../../../model/CertificationListModel.dart';
import '../../../model/CollageListModel.dart';
import '../../../model/SchoolListModel.dart';
import '../../../model/intermediateCounterOfferDataModel.dart';
import '../../../model/workExperiencesListModel.dart';

extension StringExtension on String {
    String capitalise() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}

class HomeDetailScreen extends StatefulWidget {
  String offerId;
  HomeDetailScreen({Key? key,required this.offerId}) : super(key: key);

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  var startTime;
  var currentTime;
  var diff_dy;
  var diff_hr;
  IntermediateOfferDataModel ? OfferDetails;
  List<IntermediateCounterOfferDataModel> OfferCountersList = [];
  bool loader = true;
  bool butttonLoader = false;
  String  ExpiredIn = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  var getOfferIntermediatDetails;
  load(){
    Future.delayed(Duration.zero,() {
      if (mounted) {
        setState(() {
          loader = true;
        });
      }
    },);
    DrawAuraAPi.getOfferIntermediatDetails(offer_id: widget.offerId.toString()).then((IntermediatDetailsResponse) {
      if(IntermediatDetailsResponse["status"] == "200") {

        getOfferIntermediatDetails = IntermediatDetailsResponse;

        OfferDetails = IntermediateOfferDataModel.fromJson(getOfferIntermediatDetails["OfferData"]);
        OfferCountersList = List.from( getOfferIntermediatDetails["OfferCounters"]).map<IntermediateCounterOfferDataModel>((item) => IntermediateCounterOfferDataModel.fromJson(item)).toList() ;
        // startTime =DateFormat('dd-MM-yyyy HH:mm').parse(OfferDetails!.createdAt.toString());
        // currentTime = DateTime.now();
        // diff_dy = currentTime.difference(startTime).inDays;
        // diff_hr = currentTime.difference(startTime).inHours;
        if(OfferDetails!.offerConditions!.expiry.toString() == "null"){
          ExpiredIn = "--";
        }else{
          DateTime DateTimeData = DateFormat("dd-MM-yyyy HH:mm").parse("${OfferDetails!.offerConditions!.expiry}");
          DateTime dt2 = DateTime.now();
          int totalDays = DateTimeData.difference(dt2).inDays;
          int years = totalDays ~/ 365;
          int months = (totalDays-years*365) ~/ 30;
          int days = totalDays-years*365-months*30;
          int doneHours = years*365*24;
          int hours = DateTimeData.difference(dt2).inHours  -(doneHours) -(months*30*24) - (days*24);
          int min = (((DateTimeData.difference(dt2).inMinutes - (years*365*24*60)) -(months*30*24*60)) - (days*24*60) )-hours*60;
          String empty = "";
          ExpiredIn = "${years != 0 ? '${years} Years': empty} ${ months != 0 ? '${months} Months': empty } ${days != 0 ?'${days} Days': empty } ${ hours != 0 ?'${hours} Hours': empty } ${ min != 0 ?'${min} Minutes': empty}";

        }

        print(ExpiredIn);
        Future.delayed(Duration(milliseconds: 400),() {
          if (mounted) {
            setState(() {
              loader = false;
            });
          }
        },);
      }else{
        Future.delayed(Duration(milliseconds: 400),() {
          if (mounted) {
            setState(() {
              loader = false;
            });
          }
        },);
      }
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: BlackBottomHeadStyleBold,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: loader == true? Text(""): Text(OfferDetails!.subscribers!.displayname.toString(),style: AppBarTitle,),
          actions: [
            loader== true?SizedBox(): OfferDetails!.offerstatus.toString().trim().toUpperCase() == "CLOSED" ?
                InkWell(
                  onTap: (){
                    Constants.showToast("These Offer are closed");
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(color: Constants.primaryColor1,borderRadius: BorderRadius.circular(8)),
                      child: Center(child: const Text("OFFER CLOSED",style: WhiteButtonStyle,)),
            ),
                )
                :  InkWell(
              onTap: OfferDetails!.counterdUser!.isEmpty? (){
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, ModalState) {
                      return Dialog(
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          elevation: 16,
                          child: Container(
                            width:  isMobile?width:tabWidth*0.85,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              children: [
                              Container(
                              height: 100,
                              child: OverflowBox(
                                minHeight: 150,
                                maxHeight: 150,
                                maxWidth: 150,minWidth: 150,
                                child: Lottie.asset('assets/close_json.json',fit: BoxFit.fill,),
                              ),
                              ),

                                Padding(
                                  padding: EdgeInsets.only(top:10,bottom: 10),
                                  child: Text('Close Offer !',style: BlackFieldStyleBold,textAlign: TextAlign.center),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: Text("Are you sure you want to \nclose these offer?",style: Black87HintStyle,textAlign: TextAlign.center),
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
                                          ModalState(() {
                                            butttonLoader = true;
                                          });
                                          DrawAuraAPi.changeOfferStatus(offerId:OfferDetails!.id.toString() ,CLOSED: "CLOSED").then((value) {
                                            ModalState(() {
                                              butttonLoader= false;
                                            });
                                            Navigator.pop(context);
                                            if(value["status"] == "200"){
                                              load();
                                            }else{
                                              Constants.showToast(value["message"]);
                                            }

                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Constants.primaryColor1,
                                          fixedSize: Size(isMobile?width*0.3:tabWidth*0.3, 35),
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(7)),
                                        ),
                                        child: butttonLoader == true ? SizedBox(height: 24,width: 24,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)): Text("Yes",style:WhiteButtonStyle,)),
                                  ],
                                ),
                              ],
                            ),
                          )
                      );
                    },);
                  },
                );
              }:(){
                Constants.showToast("COUNTER OFFERS ALREADY RECEIVED. CAN’T CLOSE");
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
               decoration: BoxDecoration(color: const Color(0XFFFDCF0DD),borderRadius: BorderRadius.circular(8)),
                child: Center(child: const Text("CLOSE OFFER",style: BlackTitleBoldStyle,)),
              ),
            )
          ],
        ),
        body: loader== true? Center(
          child: LoadingWidget(),
        ) :
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Status: ",style: BlackTitleBoldStyle,),
                  Text(OfferDetails!.offerstatus.toString(),style: PrimaryColorTitleStyle,),
                  SizedBox(width: 5,),
                  Text("Response: ",style: BlackTitleBoldStyle,),
                  Text(OfferDetails!.offerresponses.toString(),style: PrimaryColorTitleStyle,),
                  SizedBox(width: 5,),
                  Text("Serviced: ",style: BlackTitleItalicStyle,),
                  Text("${OfferDetails!.offerservicepercentage!.split(".").first.toString()}%",style: PrimaryColorTitleStyle,),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Expire In: ",style: BlackTitleItalicStyle,),
                  Flexible(child: Text(ExpiredIn,style: PrimaryColor13500Style,)),
              ],),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: isMobile?width*0.42:tabWidth*0.42,
                        height: 180,
                        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(10), image:OfferDetails!.offerItems![0].itemMedia!.isEmpty?const DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.fill):DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${OfferDetails!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.cover)),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)), color: OfferDetails!.buyORsell.toString() == "SELL" ? Colors.red : Constants.primaryColor1),
                            child: Center(
                                child: Text("${OfferDetails!.buyORsell.toString()}", style: WhiteSubTitleStyle, textAlign: TextAlign.center,)),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 25,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10)), color: Colors.black26),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(Icons.remove_red_eye_outlined,size: 12,color: Colors.white,),
                                  ),
                                ),
                                Center(child: Text("${OfferDetails!.offerviewcount!.length} View", style: whiteSubtitleSmallText, textAlign: TextAlign.center,)),
                              ],
                            ),
                          )),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: isMobile?width*0.44:tabWidth*0.44,
                      child:  Text.rich(
                        TextSpan(
                            text: '${OfferDetails!.category!.name.toString()}',
                            style: BlackCardTitle,
                            children: <InlineSpan>[
                              TextSpan(
                                text: " ${OfferDetails!.segment!.name.toString()} ${OfferDetails!.subsegment!.name.toString()}, ${OfferDetails!.subscribers!.displayname.toString()} ${OfferDetails!.offerItems!.first.name.toString()} ${OfferDetails!.offerItems!.first.price.toString()} / ${OfferDetails!.offerItems!.first.unit!.name.toString()}",
                                style: BlackSubCardTitle,
                              )
                            ]
                        ),),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      Icon(Icons.favorite_border,size: 20,color: primaryColor,),
                      SizedBox(width: 5,),
                      Text(OfferDetails!.offerfavoritecount.toString(),style: grey12500StyleE,),
                      SizedBox(width: 10,),
                      Image.asset("assets/note.png",height: 15,color:primaryColor),
                      SizedBox(width: 5,),
                      Text(OfferDetails!.offercopycount.toString(),style: grey12500StyleE,),
                      SizedBox(width: 10,),
                      Icon(Icons.access_time,size: 18,color: primaryColor,),
                      SizedBox(width: 3,),
                      diff_hr==null?Text(""):Text(diff_hr<=24?"${diff_hr}h":"${diff_dy}d",style: grey12500StyleE,),
                    ],
                  ),
                   Text("${OfferDetails!.category!.name.toString().toUpperCase()}, Offered by you",style: grey12500StyleE,)
                ],
              ),
              const SizedBox(height: 5,),
              const Divider(color: Colors.grey,),
              OfferCountersList.isEmpty?Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                child: Column(
                  children: [

                    NotAvailableText("No counter available on this offer")
                  ],
                ),
              ): Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: OfferCountersList.length,
                  itemBuilder: (context, index) {
                    var MainData = OfferCountersList[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("${OfferDetails!.category!.name}, ${OfferDetails!.segment!.name}, ${OfferDetails!.subsegment!.name}, ${OfferDetails!.offerItems!.first.name} ${OfferDetails!.offerItems!.first.price} ${OfferDetails!.offerItems!.first.unit!.name}",style: BlackHeadingStyle,),
                        const SizedBox(height: 5,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: MainData.counter!.length,
                          itemBuilder: (context, j) {
                            DateTime DateTimeData = DateFormat("dd-MM-yyyy HH:mm").parse("${MainData.counter![j].createdAt}");
                            DateTime dt2 = DateTime.now();
                            Duration diff = dt2.difference(DateTimeData);
                          return   Row(
                            children:  [
                              Text.rich(
                              overflow: TextOverflow.ellipsis,
                                TextSpan(
                                text:"${MainData.counter![j].tabactivity.toString()}" == "QUERY" ? "Queried by " : 
                                ("${MainData.counter![j].tabactivity.toString()}" == "EXECUTE" ? "Executed by " :
                                ("${MainData.counter![j].tabactivity.toString()}" == "SIGN-OFF" ? "Signed off by " : 
                                "${MainData.counter![j].tabactivity.toString().capitalise()}" + "ed by ")), 
                                    style:greySubTitleItalicStyle,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: MainData.counter![j].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"you": "${MainData.counter![j].fromCounter!.displayname}",
                                        style:greySubTitleStyle,
                                      ),
                                    ]
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.access_time,size: 15,color: primaryColor,),
                              SizedBox(width: 2,),
                              Text(diff.inSeconds <60?"${diff.inSeconds}s":diff.inMinutes <60?"${diff.inMinutes}m":diff.inHours < 24?"${diff.inHours}h":"${diff.inDays}d",style: grey12500StyleE,),
                            ],
                          );

                        },),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            InkWell(
                              onTap:(){
                                Get.to(()=>ProfileViewScreen(userID: MainData.counter!.first.fromCounter!.id.toString(),));
                                },
                              child: ClipOval(
                                child: Image.network(
                                  "${MainData.counter!.first.fromCounter!.profilePicture}",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                                    return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fill,);
                                  },),
                              ),
                            ),

                            InkWell(
                              onTap:(){
      // if (OfferDetails!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))) {
      // Constants.showToast("${Url.abusedReportMessage.toString()}");
      // } else {
        Get.to(() =>
            lastCounterScreen(OferId: OfferDetails!.id.toString(),
                to_Couter_Id: MainData.counter!.first.fromCounter!.id
                    .toString()))!.then((value) {
          load();
        });
      //}
                                // if(OfferDetails!.offerstatus.toString().trim().toUpperCase() == "CLOSED"){
                                //   Constants.showToast("These Offer are closed");
                                // }else {
                                //   var body = {
                                //     "offer_id" : OfferDetails!.id.toString()
                                //   };
                                //   DrawAuraAPi.CrateDataApi(body: body,ApiEndPoint: "checkOfferStatus").then((value) {
                                //     if(value["offer_status"] == "LIVE"){
                                //       Get.to(() =>
                                //           lastCounterScreen(OferId: OfferDetails!.id.toString(), to_Couter_Id: MainData.counter!.first.fromCounter!.id.toString()))!.then((value) {
                                //         load();
                                //       });
                                //     }else{
                                //
                                //       showDialog(context: context,
                                //         builder: (context) {
                                //           return  StatefulBuilder(builder: (context, setState) {
                                //             return Dialog(
                                //               alignment: Alignment.center,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                //               elevation: BorderSide.strokeAlignOutside,
                                //               child: Container(
                                //                 padding: EdgeInsets.only( top: 0,bottom: 0),
                                //                 width: MediaQuery.of(context).size.width*0.85,
                                //                 decoration:  BoxDecoration(color: Color(0x1A52B46B),
                                //                     borderRadius: BorderRadius.circular(7),
                                //                     border: Border.all(color: Constants.greyDark,width: 0.5)
                                //                 ),
                                //                 child: ListView(
                                //                   shrinkWrap: true,
                                //                   children: [
                                //                     Padding(
                                //                       padding: const EdgeInsets.only(top: 30),
                                //                       child: SizedBox(
                                //                         width: MediaQuery.of(context).size.width*0.55,
                                //                         child: Center(
                                //                           child: RichText(
                                //                             textAlign: TextAlign.center,
                                //                             text:  TextSpan(
                                //                                 children: [
                                //                                   TextSpan(text: 'This Offer is Closed', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color:Colors.black,height: 1.5)),
                                //                                 ]
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     SizedBox(height: 10,),
                                //                     Row(
                                //                       mainAxisAlignment: MainAxisAlignment.center,
                                //                       children: [
                                //                         Padding(
                                //                           padding: const EdgeInsets.only(bottom: 20),
                                //                           child: ElevatedButton(
                                //                               style: ElevatedButton.styleFrom(
                                //                                   padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 2),
                                //                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), backgroundColor:Constants.primaryColor, elevation: 1),
                                //                               onPressed: () {
                                //                                 Navigator.pop(context);
                                //                               },
                                //                               child: Text("OK",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Constants.white),)),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             );
                                //           },);
                                //         },);
                                //     }
                                //
                                //   });
                                // }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Constants.primaryColor1),
                                child: const Icon(Icons.arrow_forward,color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  );
                },),
              )
            ],
          ),
        ),
      ),
    )
    );
  }

}
Future<Duration> DateTimeDiff(DateTime fromDate ,DateTime toDate)  async{
  Duration diff = toDate.difference(fromDate);
  return diff;
}
