
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/common/style.dart';



Widget NewOfferFillList({String? searchText,required Callback onTap,required String EndText}){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200,width: 1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
           Flexible(child: Text("${searchText}", style: BlackFieldStyle,overflow: TextOverflow.ellipsis,maxLines: 1)),
          Text("${EndText}",style: BlackTitleBoldStyle15500,)
        ],
      ),
    ),
  );
}



// CommonVerticalCardForOfferFill(
//     context,FiltterOfferDetailsModel  data,
//     AsyncSnapshot<String> snapshot,
//
//     List<FiltterOfferDetailsModel> offerList,
//     int index,
//     Callback onTap,
//
//     ){
//   var width = MediaQuery.of(context).size.width;
//   var height = MediaQuery.of(context).size.height;
//   var tabWidth = ResponsiveHelper.TabModeWidth;
//   var tabHeight = ResponsiveHelper.TabModeHeight;
//   var isMobile= ResponsiveHelper.isMobile(context);
//   return Stack(
//     children: [
//       Container(
//         margin: const EdgeInsets.only(right: 5),
//         decoration: BoxDecoration(
//           borderRadius:  BorderRadius.circular(8),
//           border: Border.all(color: Constants.greyLight,width: 1),),
//         width: isMobile? width*0.5:tabWidth*0.5,
//         // height: 250,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: onTap,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 110,
//                     decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//                         image:data!.offerItems![0].itemMedia!.isEmpty?const
//                         DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
//                         "${data!.offerItems!.first.itemMedia!.first.file.toString().substring(data!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
//                         snapshot.connectionState == ConnectionState.waiting?
//                         DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
//                             :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
//                         DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.cover)), ),
//
//
//
//                   data!.buyORsell.toString() =="DELIVER_SELL" || data!.buyORsell.toString() =="DELIVER_BUY" ?
//                   data!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
//                   Positioned(
//                       top: 0,left: 0,
//                       child:  Container(
//                           padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
//                           decoration:  BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
//                               color: data!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
//                           ),
//                           child: Center(child: Text(" ${data!.buyORsell.toString()}",style: WhiteHeadingStyle,)
//                             ,))):
//                   Positioned(
//                       top: 0,left: 0,
//                       child:  Container(
//                           padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
//                           decoration:  BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
//                               color: data!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
//                           ),
//                           child: Center(child: Text( " ${data!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
//                             ,))):
//
//
//                   Positioned(
//                     top: 0,left: 0,
//                     child:  Container(
//                       padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
//                       decoration:  BoxDecoration(
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
//                           color: data!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
//                       ),
//                       child: Center(child: Text( "${data!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
//                     ),),
//
//
//                   Positioned(
//                     bottom: 0,right: 0,
//                     child: Container(
//                       width: isMobile? width*0.5:tabWidth*0.5,
//                       decoration: BoxDecoration(
//                           color: Colors.black45
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: Stack(
//                               children: [
//                                 Text(data!.subscribers!.username.toString() == "null" ?"":"${data!.subscribers!.username.toString()}",style: CardUserNameStyleUp,),
//                                 Text(data!.subscribers!.username.toString() == "null" ?"":"${data!.subscribers!.username.toString()}",style: CardUserNameStyleDown),
//                               ],
//                             ),
//                           ),
//
//                           Row(
//                             children: [
//
//                               Image.asset("assets/view.png",height: 10,color: Colors.white,),
//                               const SizedBox(width: 5,),
//                               Text("${data!.offerviewcount!.length}",style: WhiteHeadingStyle,),
//                               2.width,
//                               SizedBox(
//                                   height: 15,width: 5,
//                                   child: VerticalDivider(color: Colors.white,thickness: 1,)),
//                               // Padding(
//                               //   padding: const EdgeInsets.only(left: 4.0),
//                               //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
//                               // ),
//
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 2.0),
//                                 child: Text(
//                                   OfferCreateTime("${data!.createdAt.toString()}")
//                                   ,style: WhiteHeadingStyle,
//                                 ),
//                               )
//                             ],)
//                         ],
//                       ),
//                     ),
//                   ),
//                   data!.offertemplate == true? Positioned(
//                     top: 0,right: 0,
//                     child:  Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
//                       decoration:  BoxDecoration(
//                           borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
//                           color: Constants.templateBg
//                       ),
//                       child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
//                     ),):SizedBox(),
//
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   RichText(
//                       maxLines: 3,
//                       text:   TextSpan(
//                           style:BlackHintStyle,
//                           children: [
//                             TextSpan(text: "${data!.category!.name.toString()}",style: BlackCardTitle),
//                             TextSpan(text: " ${data!.segment!.name.toString()} ${data!.subsegment!.name.toString()}, ${data!.offerItems!.first.name.toString()} ${data.offerItems!.first.price.toString()} per ${data.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
//                           ]
//                       )),
//                   const SizedBox(height: 3,),
//
//                   // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical:0.0),
//                     child: Row(
//                       children: [
//                         Flexible(child: Text(data!.counterdUser!.isEmpty  || data.counterdUser == null || data.counterdUser == "null"? "${Url.NoResponded}":"${data.counterdUser!.length} ${data.counterdUser!.length >= 2? Url.peopleResponded:Url.personResponded}", style: greyHintStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis)),
//                         SizedBox(width: 4,),
//                         data!.counterdUser!.isEmpty?SizedBox():
//                         Stack(
//                           children: [
//                             SizedBox(width: 55,),
//                             ClipOval(
//                               child: Image.network(
//                                 "${Url.IMAGE_URL}${data!.counterdUser![0].image}",
//                                 height: 22,
//                                 width: 22,
//                                 fit: BoxFit.fill,
//                                 errorBuilder: (BuildContext context, Object exception,
//                                     StackTrace? stackTrace) {
//                                   return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
//                                     height: 22,
//                                     width: 22,
//                                     fit: BoxFit.fill,);
//                                 },),
//                             ),
//                             data!.counterdUser!.length >= 2?  Positioned(
//                                 left: 7,
//                                 top: 0,bottom: 0,
//                                 child: ClipOval(
//                                   child: Image.network(
//                                     "${Url.IMAGE_URL}${data!.counterdUser![1].image}",
//                                     height: 22,
//                                     width: 22,
//                                     fit: BoxFit.fill,
//                                     errorBuilder: (BuildContext context, Object exception,
//                                         StackTrace? stackTrace) {
//                                       return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
//                                         height: 22,
//                                         width: 22,
//                                         fit: BoxFit.fill,);
//                                     },),
//                                 )):SizedBox(),
//                             data!.counterdUser!.length >= 3?  Positioned(
//                                 left: 15,
//                                 top: 0,bottom: 0,
//                                 child: ClipOval(
//                                   child:
//                                   Image.network(
//                                     "${Url.IMAGE_URL}${data!.counterdUser![2].image}",
//                                     height: 22,
//                                     width: 22,
//                                     fit: BoxFit.fill,
//                                     errorBuilder: (BuildContext context, Object exception,
//                                         StackTrace? stackTrace) {
//                                       return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
//                                         height: 22,
//                                         width: 22,
//                                         fit: BoxFit.fill,);
//                                     },),
//                                 )):SizedBox(),
//                             data!.counterdUser!.length >= 4?   Positioned(
//                                 left: 23,
//                                 top: 0,bottom: 0,
//                                 child: ClipOval(
//                                   child:
//                                   Image.network(
//                                     "${Url.IMAGE_URL}${data!.counterdUser![3].image}",
//                                     height: 22,
//                                     width: 22,
//                                     fit: BoxFit.fill,
//                                     errorBuilder: (BuildContext context, Object exception,
//                                         StackTrace? stackTrace) {
//                                       return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
//                                         height: 22,
//                                         width: 22,
//                                         fit: BoxFit.fill,);
//                                     },),
//                                 )):SizedBox(),
//                             data!.counterdUser!.length >= 5?  Positioned(
//                                 left: 22,
//                                 top: 0,bottom: 0,
//                                 child: CircleAvatar(
//                                     backgroundColor: Constants.lightGreen,
//                                     child: Center(
//                                       child: Text("+${ data!.counterdUser!.length-4}",style: BlackHintStyle,),
//                                     )
//                                 )):SizedBox(),
//                           ],
//                         )
//
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                      Padding(
//                         padding: const EdgeInsets.only(top: 5.0),
//                         child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
//                       ),
//
//                       (data!.offerLike! + data!.offerDisLike!) == 0 ? SizedBox():
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0,left: 2),
//                         child: Text(((data!.offerLike! / ( data!.offerLike! + data.offerDisLike!))*100) <0 ? "00":
//                         "${((data!.offerLike! / ( data!.offerLike! + data.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerLike! + data.offerDisLike! })",style: primary10500,),
//                       ),
//
//                       Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0),
//                         child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 2.0,top: 5),
//                         child: Text("${data!.offerfavoritecount.toString()}",style: greyFieldStyle,),
//                       ),
//
//                       Spacer(),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0),
//                         child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
//                         child: Text("${data!.offercopycount.toString()}",style: greyFieldStyle,),
//                       ),
//                     ],
//                   ),
//                   // isCounterSellBuy == true ?
//                   // Padding(
//                   //   padding: const EdgeInsets.symmetric(vertical:0.0),
//                   //   child: Text.rich(
//                   //       maxLines: 1,
//                   //       TextSpan(
//                   //       text:"${data.offerCounters!.first.counter![0].tabactivity}  by  ",
//                   //       style:greyHintStyle,
//                   //       children: <InlineSpan>[
//                   //         TextSpan(
//                   //           text: data.offerCounters!.first.counter![0].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![0].fromCounter!.username.toString()}",
//                   //           style:grey12500StyleE,
//                   //         ),
//                   //
//                   //       ]
//                   //   )),
//                   // ) :
//                   // SizedBox(),
//                   //
//                   // isCounterSellBuy == true ?
//                   // data.offerCounters!.first.counter!.length <= 1 ?SizedBox():
//                   // Text.rich(
//                   //   maxLines: 1,
//                   //     TextSpan(
//                   //     text:"${data.offerCounters!.first.counter![1].tabactivity}  by  ",
//                   //     style:greyHintStyle,
//                   //     children: <InlineSpan>[
//                   //       TextSpan(
//                   //         text: data.offerCounters!.first.counter![1].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![1].fromCounter!.username.toString()}",
//                   //         style:grey12500StyleE,
//                   //       ),
//                   //       TextSpan(
//                   //         text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
//                   //         style:grey12500StyleE,
//                   //       ),
//                   //     ]
//                   // ))
//                   //     : SizedBox(),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       data!.offerstatus.toString().trim().toUpperCase() == "CLOSED" ?
//       Positioned(
//         top: 0,bottom: 0,left: 0,right: 0,
//         child: InkWell(
//           onTap: onTap,
//           child: Container(
//             margin: const EdgeInsets.only(right: 5),
//             width: isMobile? width*0.5:tabWidth*0.5,
//             decoration:  BoxDecoration(
//               borderRadius:  BorderRadius.circular(8),
//               color: Constants.closeOfferCard,
//             ),
//           ),
//         ),
//       ) :SizedBox(),
//
//       Positioned(
//           bottom:0,right: 5,
//           child: privetPublicLogoNew(isPrivet: data.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
//       ),
//     ],
//   );
//
// }

