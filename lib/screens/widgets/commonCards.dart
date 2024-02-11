import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/screens/Reaction/reactionList.dart';
import 'package:socialapps/screens/widgets/OfferCradCommonFunction.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import '../../Apis/urls.dart';

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}

CommonVerticalCard(
    context,OfferDataModelResult  data,
    AsyncSnapshot<String> snapshot,
    bool isCounterSellBuy,
    List<OfferDataModelResult> offerList,
    int index,
    Callback onTap,
    bool isYourOffer,
    List<bool> isAllItemDone1,
    bool  isConfirmingUser
    ){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(8),
          border: Border.all(color: Constants.greyLight,width: 1),),
        width: isMobile? width*0.5:tabWidth*0.5,
        // height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              onLongPress: (){
                LongPressForDelete(context,data,offerList: offerList,index: index);
              },
              child: Stack(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                        DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                        "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                        snapshot.connectionState == ConnectionState.waiting?
                        DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                            :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.fill)), ),
                  isYourOffer ?
                  Positioned(
                      top: 0,
                      left: 0,
                      child: data.offerData!.buyORsell == "SELL" || data.offerData!.buyORsell == "BUY" ?
                      Container(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "SELL" ? Colors.red : Constants.primaryColor1),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell.toString()}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      )
                          : data.offerData!.buyORsell == "DELIVER_BUY" || data.offerData!.buyORsell == "DELIVER_SELL"
                          ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "DELIVER_SELL" ? Colors.red : Constants.primaryColor1),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell.toString()}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      )
                          : Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "COUNTER SELL" ? Constants.primaryColor1 : Colors.red),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell == "COUNTER SELL" ? "COUNTER BUY" : "COUNTER SELL"}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      ))
                      :

                  data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                            ,))):
                  isCounterSellBuy == true ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text("COUNTER ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( "COUNTER ${data.offerData!.buyORsell.toString() == "BUY"?"SELL":"BUY"}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                    top: 0,left: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                          color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                      ),
                      child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                    ),),


                  Positioned(
                    bottom: 0,right: 0,
                    child: Container(
                      width: isMobile? width*0.5:tabWidth*0.5,
                      decoration: BoxDecoration(
                          color: Colors.black45
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleUp,overflow: TextOverflow.ellipsis,),
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleDown,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),

                          Row(
                            children: [

                              Image.asset("assets/view.png",height: 10,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text("${data.offerData!.offerviewcount!.length}",style: WhiteHeadingStyle,),
                              2.width,
                              SizedBox(
                                  height: 15,width: 5,
                                  child: VerticalDivider(color: Colors.white,thickness: 1,)),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                  ,style: WhiteHeadingStyle,
                                ),
                              )
                            ],)
                        ],
                      ),
                    ),
                  ),
                  data.offerData!.offertemplate == true? Positioned(
                    top: 0,right: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                          color: Constants.templateBg
                      ),
                      child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
                    ),):SizedBox(),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      maxLines: 3,
                      text:   TextSpan(
                          style:BlackHintStyle,
                          children: [
                            TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                            TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} / ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                          ]
                      )),
                  const SizedBox(height: 3,),

                  // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
                  data.offerData!.offertemplate == true?SizedBox():
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:0.0),
                    child: Row(
                      children: [

                        Flexible(child: Text(data.offerData!.counterdUser!.isEmpty  || data.offerData!.counterdUser == null || data.offerData!.counterdUser == "null"? "${Url.NoResponded}":"${data.offerData!.counterdUser!.length} ${data.offerData!.counterdUser!.length >= 2? Url.peopleResponded:Url.personResponded}", style: greyHintStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 4,),
                        data.offerData!.counterdUser!.isEmpty?SizedBox():
                        Stack(
                          children: [
                            SizedBox(width: 55,),
                            ClipOval(
                              child: Image.network(
                                "${Url.IMAGE_URL}${data.offerData!.counterdUser![0].image}",
                                height: 22,
                                width: 22,
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                  return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,);
                                },),
                            ),
                            data.offerData!.counterdUser!.length >= 2?  Positioned(
                                left: 7,
                                top: 0,bottom: 0,
                                child: ClipOval(
                                  child: Image.network(
                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![1].image}",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.fill,);
                                    },),
                                )):SizedBox(),
                            data.offerData!.counterdUser!.length >= 3?  Positioned(
                                left: 15,
                                top: 0,bottom: 0,
                                child: ClipOval(
                                  child:
                                  Image.network(
                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![2].image}",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.fill,);
                                    },),
                                )):SizedBox(),
                            data.offerData!.counterdUser!.length >= 4?   Positioned(
                                left: 23,
                                top: 0,bottom: 0,
                                child: ClipOval(
                                  child:
                                  Image.network(
                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![3].image}",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.fill,);
                                    },),
                                )):SizedBox(),
                            data.offerData!.counterdUser!.length >= 5?  Positioned(
                                left: 22,
                                top: 0,bottom: 0,
                                child: CircleAvatar(
                                    backgroundColor: Constants.lightGreen,
                                    child: Center(
                                      child: Text("+${ data.offerData!.counterdUser!.length-4}",style: BlackHintStyle,),
                                    )
                                )):SizedBox(),
                          ],
                        )

                      ],
                    ),
                  ):
                  isCounterSellBuy == true?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:0.0),
                    child: Text.rich(
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        TextSpan(
                        text:"${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "QUERY" ? "Queried by " : 
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "EXECUTE" ? "Executed by " :
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "SIGN-OFF" ? "Signed off by " : 
                        "${data.offerCounters!.last.counter!.last.tabactivity.toString().capitalize()}" + "ed by ")), 
                        style:greyHintStyle,
                        children: <InlineSpan>[
                          TextSpan(
                            text: data.offerCounters!.last.counter!.last.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"you": "${data.offerCounters!.last.counter!.last.fromCounter!.displayname.toString()}",
                            style:grey12500StyleE,
                          ),

                        ]
                    )),
                  ) :SizedBox()
                  ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.offerData!.like == 0 ?
                      data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()
                          ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      ):
                      data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                      Builder(
                        builder: (ctx) {
                          return ReactionButton<String>(
                            onReactionChanged: (String? value) {
                              var body = {
                                "offer_id": data.offerData!.id.toString(),
                                "user_id" : DataManager.getInstance().getuserId().toString()
                              };
                              DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                              if(value == "like"){
                                DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Liked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 1,
                                            offerLike: data.offerData!.offerLike!+1,
                                            offerDisLike: data.offerData!.offerDisLike,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }else{
                                DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Disliked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 2,
                                            offerLike: data.offerData!.offerLike,
                                            offerDisLike:data.offerData!.offerDisLike!+1,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }
                            },
                            reactions: flagsReactions,
                            initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                              value: null,
                              icon:  Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                                ),
                              ),
                            ): Reaction<String>(
                              value: 'like',
                              icon:Icon(
                                Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                              ),
                            ),
                            boxColor:Colors.amber.shade300 ,
                            boxRadius: 10,
                            boxElevation: 0,
                            boxDuration: const Duration(milliseconds: 200),
                            itemScaleDuration: const Duration(milliseconds: 100),
                          );
                        },
                      ): Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      )
                          :Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
                      ),

                      (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 2),
                        child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                        "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                      ),

                      Spacer(),
                      InkWell(
                          onTap:(){
                            var body = {
                              "offer_id": data.offerData!.id.toString(),
                              "user_id" : DataManager.getInstance().getuserId().toString()
                            };
                            DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                            DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                              if( value["message"].toString().trim() == "offer removed from favourite"){
                                Constants.showToast("${Url.UnMarkFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: false,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }else{
                                Constants.showToast("${Url.markFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: true,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }
                            });
                          },
                          child: data.offerData!.favourite == true ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 18,),
                          ):Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5),
                        child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                      ),
                      //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // InkWell(
                      //     onTap:(){
                      //       var body = {
                      //         "offer_id": data.offerData!.id.toString(),
                      //         "user_id" : DataManager.getInstance().getuserId().toString()
                      //       };
                      //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                      //       bool isCommentsLoading = true;
                      //       List<CommentsDataList> CommentsList = [];
                      //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                      //         CommentsList = value;
                      //         isCommentsLoading = false;
                      //       });
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                      //         context: context, builder: (context) {
                      //         return  StatefulBuilder(builder: (context, modalState) {
                      //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                      //             modalState((){});
                      //
                      //           },):null;
                      //           return Container(
                      //               height: MediaQuery.of(context).size.height*0.8,
                      //               width:isMobile?width:tabWidth,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                      //                 color:Color(0x33DCF0DD),
                      //               ),
                      //               child: Scaffold(
                      //                 backgroundColor: Colors.transparent,
                      //                 body: Column(
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Container(
                      //                         height: 3.5,
                      //                         margin: EdgeInsets.only(top: 13),
                      //                         width: 38,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(5),
                      //                           color: Colors.black54,
                      //                         )),
                      //                     20.height,
                      //                     Text("Comments",style:BlackSubTitleStyle,),
                      //                     10.height,
                      //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                      //                     2.height,
                      //                     // isCommentsLoading?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                      //                     //   child: LoadingWidget(),
                      //                     // )
                      //                     //     :
                      //                     //
                      //                     // CommentsList.isEmpty?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                      //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                      //                     // )
                      //                     //     : Expanded(
                      //                     //   child: ListView.builder(
                      //                     //     controller: scrollCommentsController,
                      //                     //     itemCount: CommentsList.length,
                      //                     //     padding: EdgeInsets.only(bottom: 100),
                      //                     //     itemBuilder: (context, i) {
                      //                     //       var CommentsData = CommentsList[i];
                      //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                      //                     //       final currentTime = DateTime.now();
                      //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                      //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                      //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                      //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                      //                     //       return Row(
                      //                     //         mainAxisAlignment: MainAxisAlignment.start,
                      //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //         children: [
                      //                     //           Container(
                      //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                      //                     //             height: 40,
                      //                     //             width: 40,
                      //                     //             decoration: BoxDecoration(
                      //                     //                 shape: BoxShape.circle,
                      //                     //                 image:
                      //                     //                 CommentsData.user!.profilePicture == null ||
                      //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                      //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                      //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                      //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                      //                     //             ),
                      //                     //           ),
                      //                     //           Flexible(
                      //                     //             child: Container(
                      //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      //                     //               decoration: BoxDecoration(
                      //                     //                 borderRadius: BorderRadius.circular(7),
                      //                     //                 color: Constants.white,
                      //                     //               ),
                      //                     //               child: Column(
                      //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                     //                 children: [
                      //                     //                   Row(
                      //                     //                     children: [
                      //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                      //                     //                       10.width,
                      //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                      //                     //                     ],
                      //                     //                   ),
                      //                     //
                      //                     //                   Padding(
                      //                     //                     padding: const EdgeInsets.only(top: 2.0),
                      //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                      //                     //                   ),
                      //                     //                 ],
                      //                     //               ),
                      //                     //             ),
                      //                     //           ),
                      //                     //         ],
                      //                     //       );
                      //                     //     },),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //                 bottomSheet:Container(
                      //
                      //                   decoration: BoxDecoration(
                      //                       color: Color(0x33DCF0DD),
                      //
                      //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                      //                   ),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     crossAxisAlignment: CrossAxisAlignment.center,
                      //                     children: [
                      //
                      //                       10.width,
                      //                       Container(
                      //                         height: 35,
                      //                         width: 35,
                      //                         margin: const EdgeInsets.only(bottom: 5),
                      //                         padding: EdgeInsets.zero,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius: BorderRadius.circular(5),
                      //                             color: Constants.greyDark
                      //                         ),
                      //                         child: Center(child: Container(
                      //                           height: 35,width: 35,
                      //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                      //                             // border: Border.all(color: Constants.white,width: 4),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                      //                           ):  BoxDecoration(
                      //                               border: Border.all(color: Constants.white,width: 2),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      //                           ),
                      //                         )),
                      //                       ),
                      //
                      //                       Flexible(
                      //                         child: TextFormField(
                      //                           controller: messageController,
                      //                           keyboardType: TextInputType.text,
                      //                           // maxLines: ,
                      //                           onChanged: (value){
                      //                             setState(() {
                      //
                      //                             });
                      //                             modalState((){});
                      //                           },
                      //                           autofocus: false,
                      //                           focusNode: focusNode,
                      //                           // style: black14500,
                      //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                      //                           decoration: InputDecoration(
                      //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                             hintText: "Write your comments",
                      //                             hintStyle: greySubTitleItalicStyle,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       messageController.text.isEmpty?SizedBox():InkWell(
                      //                         onTap: (){
                      //                           // messageController.clear();
                      //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                      //                             if(value["status"] == "200"){
                      //                               var CommentRes =  CommentsDataList(
                      //                                 id: value["result"]["id"],
                      //                                 user:CommentsUser(
                      //                                     id: value["result"]["user"]["id"],
                      //                                     displayname:  value["result"]["user"]["displayname"],
                      //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                      //                                     username:  value["result"]["user"]["username"]
                      //                                 ),
                      //                                 offer: value["result"]["offer"],
                      //                                 comment: value["result"]["comment"],
                      //                                 createdAt: value["result"]["created_at"],
                      //                                 updatedAt: value["result"]["updated_at"],
                      //                               );
                      //                               modalState((){
                      //                                 CommentsList.add(CommentRes);
                      //                                 messageController.clear();
                      //                                 scrollToBottom();
                      //                               });
                      //                             }
                      //                           });
                      //                         },
                      //                         child: Container(
                      //                           margin: EdgeInsets.only(right: 10),
                      //                           height: 40,
                      //                           width: 40,
                      //                           decoration: BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               border: Border.all(color: Constants.greyLight,width: 1),
                      //                               color:Constants.primaryColor
                      //                           ),
                      //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 // Column(
                      //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                      //                 //   mainAxisSize: MainAxisSize.max,
                      //                 //   mainAxisAlignment: MainAxisAlignment.end,
                      //                 //   children: [
                      //                 //     Container(
                      //                 //       height: 50,
                      //                 //       decoration: BoxDecoration(
                      //                 //         color: Color(
                      //                 //             0x1ABCDFF8),
                      //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                      //                 //       ),
                      //                 //       child: Row(
                      //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 //         children: [
                      //                 //
                      //                 //           const SizedBox(width: 7,),
                      //                 //           isemojiShowing == false?
                      //                 //           InkWell(
                      //                 //               onTap: (){
                      //                 //                 // controller.focusNode.value.unfocus();
                      //                 //                 // controller.focusNode.value.canRequestFocus=false;
                      //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                      //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                      //                 //                 //   // controller.focusNode.value.requestFocus();
                      //                 //                 //   // controller.filepick.value = false;
                      //                 //                 //   // controller.showStickers.value = false;
                      //                 //                 //   // controller.showAttachmentButtons.value = false;
                      //                 //                 // },);
                      //                 //                 //
                      //                 //                 // controller.filepick.value = false;
                      //                 //                 // // if ( controller.emojiShowing.value != false) {
                      //                 //                 // //   FocusScope.of(context).unfocus();
                      //                 //                 // // }
                      //                 //               },
                      //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                      //                 //           InkWell(
                      //                 //             onTap: () {
                      //                 //               // controller.focusNode.value.requestFocus();
                      //                 //               // controller.emojiShowing.value = false;
                      //                 //               // controller.filepick.value = false;
                      //                 //               // controller.showStickers.value = false;
                      //                 //               // controller.showAttachmentButtons.value = false;
                      //                 //
                      //                 //             },
                      //                 //             child: const Padding(
                      //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //                 //               child: Icon(
                      //                 //                 Icons.keyboard,
                      //                 //                 color: Colors.black45,size: 22,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //           Flexible(
                      //                 //             child: TextFormField(
                      //                 //               controller: messageController,
                      //                 //               onChanged: (value){
                      //                 //
                      //                 //               },
                      //                 //               autofocus: false,
                      //                 //               focusNode: focusNode,
                      //                 //               // style: black14500,
                      //                 //               cursorColor: Colors.black,
                      //                 //               onTap: (){
                      //                 //                 isemojiShowing = false;
                      //                 //               },
                      //                 //               decoration: InputDecoration(
                      //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                 //                 hintText: "Write your comments",
                      //                 //                 hintStyle: grey14400,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //
                      //                 //         ],
                      //                 //       ),
                      //                 //     ),
                      //                 //     Offstage(
                      //                 //       offstage: isemojiShowing,
                      //                 //       child: SizedBox(
                      //                 //         height: 240,
                      //                 //         child: emg.EmojiPicker(
                      //                 //
                      //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                      //                 //             onEmojiSelected(emoji);
                      //                 //             messageChecker = emoji.toString();
                      //                 //           },
                      //                 //           onBackspacePressed: onBackspacePressed,
                      //                 //           config: emg.Config(
                      //                 //             columns: 9,
                      //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                      //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      //                 //             verticalSpacing: 0,
                      //                 //             horizontalSpacing: 0,
                      //                 //             gridPadding: EdgeInsets.zero,
                      //                 //             initCategory: emg.Category.RECENT,
                      //                 //             bgColor: const Color(0xFFF2F2F2),
                      //                 //             indicatorColor: Constants.primaryColor,
                      //                 //             iconColor: Colors.grey,
                      //                 //             iconColorSelected:  Constants.primaryColor,
                      //                 //             backspaceColor:  Constants.primaryColor,
                      //                 //             skinToneDialogBgColor: Colors.white,
                      //                 //             skinToneIndicatorColor: Colors.grey,
                      //                 //             enableSkinTones: true,
                      //                 //             // showRecentsTab: true,
                      //                 //             recentsLimit: 28,
                      //                 //             replaceEmojiOnLimitExceed: false,
                      //                 //             noRecents: const Text(
                      //                 //               'No Recent',
                      //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                      //                 //               textAlign: TextAlign.center,
                      //                 //             ),
                      //                 //             loadingIndicator: const SizedBox.shrink(),
                      //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                      //                 //             categoryIcons: const emg.CategoryIcons(),
                      //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                      //                 //             checkPlatformCompatibility: true,
                      //                 //           ),
                      //                 //         ),
                      //                 //       ),
                      //                 //     ),
                      //                 //   ],
                      //                 // ),
                      //               )
                      //           );
                      //         },);
                      //
                      //       },).then((value) {
                      //
                      //       });
                      //     },
                      //     child: Image.asset("assets/comment.png",height: 18,)),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 3.0),
                      //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                      // ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                        child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                      ),
                    ],
                  ),
                  // isCounterSellBuy == true ?
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical:0.0),
                  //   child: Text.rich(
                  //       maxLines: 1,
                  //       TextSpan(
                  //       text:"${data.offerCounters!.first.counter![0].tabactivity}  by  ",
                  //       style:greyHintStyle,
                  //       children: <InlineSpan>[
                  //         TextSpan(
                  //           text: data.offerCounters!.first.counter![0].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![0].fromCounter!.username.toString()}",
                  //           style:grey12500StyleE,
                  //         ),
                  //
                  //       ]
                  //   )),
                  // ) :
                  // SizedBox(),
                  //
                  // isCounterSellBuy == true ?
                  // data.offerCounters!.first.counter!.length <= 1 ?SizedBox():
                  // Text.rich(
                  //   maxLines: 1,
                  //     TextSpan(
                  //     text:"${data.offerCounters!.first.counter![1].tabactivity}  by  ",
                  //     style:greyHintStyle,
                  //     children: <InlineSpan>[
                  //       TextSpan(
                  //         text: data.offerCounters!.first.counter![1].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![1].fromCounter!.username.toString()}",
                  //         style:grey12500StyleE,
                  //       ),
                  //       TextSpan(
                  //         text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                  //         style:grey12500StyleE,
                  //       ),
                  //     ]
                  // ))
                  //     : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
      data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED" ?
      isConfirmingUser ? SizedBox():
      Positioned(
        top: 0,bottom: 0,left: 0,right: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            width: isMobile? width*0.5:tabWidth*0.5,
            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(8),
              color: Constants.closeOfferCard,
            ),
          ),
        ),
      ) : isAllItemDone1.contains(false)?SizedBox():
      isConfirmingUser ? SizedBox():
      Positioned(
        top: 0,bottom: 0,left: 0,right: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: isMobile? width*0.49:tabWidth*0.49,
            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(8),
              color: Constants.closeOfferCard,
            ),
          ),
        ),
      ),
      data.offerData!.offerstatus.toString().trim().toUpperCase() != "CLOSED" ? SizedBox(): data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId() || isCounterSellBuy?
      Positioned(
        top:2,right: 10,
        child: InkWell(
          onTap: (){
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                bool butttonLoader = false;
                return StatefulBuilder(builder: (context, ModalState) {
                  return Dialog(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      elevation: 16,
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        children: [
                          Image.asset("assets/delete.png",height: 50,width: 50,color: Colors.black,),
                          Padding(
                            padding: EdgeInsets.only(top:10,bottom: 10),
                            child: Text('DELETE OFFER!',style: BlackFieldStyleBold,textAlign: TextAlign.center),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text("ARE YOU SURE TO DELETE?",style: Black87HintStyle,textAlign: TextAlign.center),
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
                                    fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
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
                                    var body = {
                                      "offer_id": data.offerData!.id.toString()
                                    };
                                    DrawAuraAPi.CreateDataApi(body: body ,ApiEndPoint: "deleteOffer").then((value) {
                                      ModalState(() {
                                        butttonLoader= false;
                                      });
                                      Navigator.pop(context);
                                      if(value["status"] == 200){
                                        Constants.showToast(value["message"]);
                                        ModalState((){
                                          offerList.removeAt(index);
                                        });

                                      }else{
                                        Constants.showToast(value["message"]);
                                      }

                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.primaryColor1,
                                    fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                  child: butttonLoader == true ? SizedBox(height: 24,width: 24,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)): Text("Yes",style:WhiteButtonStyle,)),
                            ],
                          ),
                        ],
                      )
                  );
                },);
              },
            );
          },
          child: CircleAvatar(
              radius: 13,backgroundColor: Colors.grey.shade800,
              child: Image.asset("assets/delete.png",height: 18,color: Colors.white,)),
        ),
      ):SizedBox(),
      Positioned(
          bottom:0,right: 5,
          child: privetPublicLogoNew(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
      ),
    ],
  );

}


CommonVerticalCardTemplate(context,OfferDataModelResult  data, AsyncSnapshot<String> snapshot,bool isCounterSellBuy,List<OfferDataModelResult> offerList,int index){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return Stack(
    children: [
      Container(
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(8),
          border: Border.all(color: Constants.greyLight,width: 1),),
        width: isMobile? width*0.5:tabWidth*0.5,
        // height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                tapOnTemplate(context,data);
              },
              onLongPress: (){
                LongPressForDelete(context,data,offerList: offerList,index: index);
              },
              child: Stack(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                        DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                        "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                        snapshot.connectionState == ConnectionState.waiting?
                        DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                            :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.fill)), ),
                  data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                            ,))):
                  isCounterSellBuy == true ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text("COUNTER ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"?Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text( "COUNTER ${data.offerData!.buyORsell.toString() == "BUY"?"SELL":"BUY"}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                    top: 0,left: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                          color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                      ),
                      child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                    ),),
                  Positioned(
                    bottom: 0,right: 0,
                    child: Container(
                      width: isMobile? width*0.5:tabWidth*0.5,
                      decoration: BoxDecoration(
                          color: Colors.black45
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleUp,overflow: TextOverflow.ellipsis,),
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleDown,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),

                          Row(
                            children: [

                              Image.asset("assets/view.png",height: 10,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text("${data.offerData!.offerviewcount!.length}",style: WhiteHeadingStyle,),
                              2.width,
                              SizedBox(
                                  height: 15,width: 5,
                                  child: VerticalDivider(color: Colors.white,thickness: 1,)),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                  ,style: WhiteHeadingStyle,
                                ),
                              )
                            ],)
                        ],
                      ),
                    ),
                  ),
                  data.offerData!.offertemplate == true? Positioned(
                    top: 0,right: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                          color: Constants.templateBg
                      ),
                      child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
                    ),):SizedBox(),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      maxLines: 3,
                      text:   TextSpan(
                          style:BlackHintStyle,
                          children: [
                            TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                            TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} / ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                          ]
                      )),
                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.offerData!.like == 0 ?
                      data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()
                          ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      ):
                      data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                      Builder(
                        builder: (ctx) {
                          return ReactionButton<String>(
                            onReactionChanged: (String? value) {
                              var body = {
                                "offer_id": data.offerData!.id.toString(),
                                "user_id" : DataManager.getInstance().getuserId().toString()
                              };
                              DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                              if(value == "like"){
                                DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Liked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 1,
                                            offerLike: data.offerData!.offerLike!+1,
                                            offerDisLike: data.offerData!.offerDisLike,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }else{
                                DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Disliked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 2,
                                            offerLike: data.offerData!.offerLike,
                                            offerDisLike:data.offerData!.offerDisLike!+1,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }
                            },
                            reactions: flagsReactions,
                            initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                              value: null,
                              icon:  Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                                ),
                              ),
                            ): Reaction<String>(
                              value: 'like',
                              icon:Icon(
                                Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                              ),
                            ),
                            boxColor:Colors.amber.shade300 ,
                            boxRadius: 10,
                            boxElevation: 0,
                            boxDuration: const Duration(milliseconds: 200),
                            itemScaleDuration: const Duration(milliseconds: 100),
                          );
                        },
                      ): Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      )
                          :Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
                      ),

                      (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 2),
                        child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                        "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                      ),

                      Spacer(),
                      InkWell(
                          onTap:(){
                            var body = {
                              "offer_id": data.offerData!.id.toString(),
                              "user_id" : DataManager.getInstance().getuserId().toString()
                            };
                            DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                            DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                              if( value["message"].toString().trim() == "offer removed from favourite"){
                                Constants.showToast("${Url.UnMarkFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: false,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }else{
                                Constants.showToast("${Url.markFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: true,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }
                            });
                          },
                          child: data.offerData!.favourite == true ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 18,),
                          ):Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5),
                        child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                      ),
                      //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // InkWell(
                      //     onTap:(){
                      //       var body = {
                      //         "offer_id": data.offerData!.id.toString(),
                      //         "user_id" : DataManager.getInstance().getuserId().toString()
                      //       };
                      //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                      //       bool isCommentsLoading = true;
                      //       List<CommentsDataList> CommentsList = [];
                      //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                      //         CommentsList = value;
                      //         isCommentsLoading = false;
                      //       });
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                      //         context: context, builder: (context) {
                      //         return  StatefulBuilder(builder: (context, modalState) {
                      //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                      //             modalState((){});
                      //
                      //           },):null;
                      //           return Container(
                      //               height: MediaQuery.of(context).size.height*0.8,
                      //               width:isMobile?width:tabWidth,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                      //                 color:Color(0x33DCF0DD),
                      //               ),
                      //               child: Scaffold(
                      //                 backgroundColor: Colors.transparent,
                      //                 body: Column(
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Container(
                      //                         height: 3.5,
                      //                         margin: EdgeInsets.only(top: 13),
                      //                         width: 38,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(5),
                      //                           color: Colors.black54,
                      //                         )),
                      //                     20.height,
                      //                     Text("Comments",style:BlackSubTitleStyle,),
                      //                     10.height,
                      //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                      //                     2.height,
                      //                     // isCommentsLoading?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                      //                     //   child: LoadingWidget(),
                      //                     // )
                      //                     //     :
                      //                     //
                      //                     // CommentsList.isEmpty?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                      //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                      //                     // )
                      //                     //     : Expanded(
                      //                     //   child: ListView.builder(
                      //                     //     controller: scrollCommentsController,
                      //                     //     itemCount: CommentsList.length,
                      //                     //     padding: EdgeInsets.only(bottom: 100),
                      //                     //     itemBuilder: (context, i) {
                      //                     //       var CommentsData = CommentsList[i];
                      //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                      //                     //       final currentTime = DateTime.now();
                      //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                      //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                      //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                      //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                      //                     //       return Row(
                      //                     //         mainAxisAlignment: MainAxisAlignment.start,
                      //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //         children: [
                      //                     //           Container(
                      //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                      //                     //             height: 40,
                      //                     //             width: 40,
                      //                     //             decoration: BoxDecoration(
                      //                     //                 shape: BoxShape.circle,
                      //                     //                 image:
                      //                     //                 CommentsData.user!.profilePicture == null ||
                      //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                      //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                      //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                      //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                      //                     //             ),
                      //                     //           ),
                      //                     //           Flexible(
                      //                     //             child: Container(
                      //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      //                     //               decoration: BoxDecoration(
                      //                     //                 borderRadius: BorderRadius.circular(7),
                      //                     //                 color: Constants.white,
                      //                     //               ),
                      //                     //               child: Column(
                      //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                     //                 children: [
                      //                     //                   Row(
                      //                     //                     children: [
                      //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                      //                     //                       10.width,
                      //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                      //                     //                     ],
                      //                     //                   ),
                      //                     //
                      //                     //                   Padding(
                      //                     //                     padding: const EdgeInsets.only(top: 2.0),
                      //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                      //                     //                   ),
                      //                     //                 ],
                      //                     //               ),
                      //                     //             ),
                      //                     //           ),
                      //                     //         ],
                      //                     //       );
                      //                     //     },),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //                 bottomSheet:Container(
                      //
                      //                   decoration: BoxDecoration(
                      //                       color: Color(0x33DCF0DD),
                      //
                      //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                      //                   ),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     crossAxisAlignment: CrossAxisAlignment.center,
                      //                     children: [
                      //
                      //                       10.width,
                      //                       Container(
                      //                         height: 35,
                      //                         width: 35,
                      //                         margin: const EdgeInsets.only(bottom: 5),
                      //                         padding: EdgeInsets.zero,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius: BorderRadius.circular(5),
                      //                             color: Constants.greyDark
                      //                         ),
                      //                         child: Center(child: Container(
                      //                           height: 35,width: 35,
                      //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                      //                             // border: Border.all(color: Constants.white,width: 4),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                      //                           ):  BoxDecoration(
                      //                               border: Border.all(color: Constants.white,width: 2),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      //                           ),
                      //                         )),
                      //                       ),
                      //
                      //                       Flexible(
                      //                         child: TextFormField(
                      //                           controller: messageController,
                      //                           keyboardType: TextInputType.text,
                      //                           // maxLines: ,
                      //                           onChanged: (value){
                      //                             setState(() {
                      //
                      //                             });
                      //                             modalState((){});
                      //                           },
                      //                           autofocus: false,
                      //                           focusNode: focusNode,
                      //                           // style: black14500,
                      //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                      //                           decoration: InputDecoration(
                      //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                             hintText: "Write your comments",
                      //                             hintStyle: greySubTitleItalicStyle,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       messageController.text.isEmpty?SizedBox():InkWell(
                      //                         onTap: (){
                      //                           // messageController.clear();
                      //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                      //                             if(value["status"] == "200"){
                      //                               var CommentRes =  CommentsDataList(
                      //                                 id: value["result"]["id"],
                      //                                 user:CommentsUser(
                      //                                     id: value["result"]["user"]["id"],
                      //                                     displayname:  value["result"]["user"]["displayname"],
                      //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                      //                                     username:  value["result"]["user"]["username"]
                      //                                 ),
                      //                                 offer: value["result"]["offer"],
                      //                                 comment: value["result"]["comment"],
                      //                                 createdAt: value["result"]["created_at"],
                      //                                 updatedAt: value["result"]["updated_at"],
                      //                               );
                      //                               modalState((){
                      //                                 CommentsList.add(CommentRes);
                      //                                 messageController.clear();
                      //                                 scrollToBottom();
                      //                               });
                      //                             }
                      //                           });
                      //                         },
                      //                         child: Container(
                      //                           margin: EdgeInsets.only(right: 10),
                      //                           height: 40,
                      //                           width: 40,
                      //                           decoration: BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               border: Border.all(color: Constants.greyLight,width: 1),
                      //                               color:Constants.primaryColor
                      //                           ),
                      //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 // Column(
                      //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                      //                 //   mainAxisSize: MainAxisSize.max,
                      //                 //   mainAxisAlignment: MainAxisAlignment.end,
                      //                 //   children: [
                      //                 //     Container(
                      //                 //       height: 50,
                      //                 //       decoration: BoxDecoration(
                      //                 //         color: Color(
                      //                 //             0x1ABCDFF8),
                      //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                      //                 //       ),
                      //                 //       child: Row(
                      //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 //         children: [
                      //                 //
                      //                 //           const SizedBox(width: 7,),
                      //                 //           isemojiShowing == false?
                      //                 //           InkWell(
                      //                 //               onTap: (){
                      //                 //                 // controller.focusNode.value.unfocus();
                      //                 //                 // controller.focusNode.value.canRequestFocus=false;
                      //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                      //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                      //                 //                 //   // controller.focusNode.value.requestFocus();
                      //                 //                 //   // controller.filepick.value = false;
                      //                 //                 //   // controller.showStickers.value = false;
                      //                 //                 //   // controller.showAttachmentButtons.value = false;
                      //                 //                 // },);
                      //                 //                 //
                      //                 //                 // controller.filepick.value = false;
                      //                 //                 // // if ( controller.emojiShowing.value != false) {
                      //                 //                 // //   FocusScope.of(context).unfocus();
                      //                 //                 // // }
                      //                 //               },
                      //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                      //                 //           InkWell(
                      //                 //             onTap: () {
                      //                 //               // controller.focusNode.value.requestFocus();
                      //                 //               // controller.emojiShowing.value = false;
                      //                 //               // controller.filepick.value = false;
                      //                 //               // controller.showStickers.value = false;
                      //                 //               // controller.showAttachmentButtons.value = false;
                      //                 //
                      //                 //             },
                      //                 //             child: const Padding(
                      //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //                 //               child: Icon(
                      //                 //                 Icons.keyboard,
                      //                 //                 color: Colors.black45,size: 22,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //           Flexible(
                      //                 //             child: TextFormField(
                      //                 //               controller: messageController,
                      //                 //               onChanged: (value){
                      //                 //
                      //                 //               },
                      //                 //               autofocus: false,
                      //                 //               focusNode: focusNode,
                      //                 //               // style: black14500,
                      //                 //               cursorColor: Colors.black,
                      //                 //               onTap: (){
                      //                 //                 isemojiShowing = false;
                      //                 //               },
                      //                 //               decoration: InputDecoration(
                      //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                 //                 hintText: "Write your comments",
                      //                 //                 hintStyle: grey14400,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //
                      //                 //         ],
                      //                 //       ),
                      //                 //     ),
                      //                 //     Offstage(
                      //                 //       offstage: isemojiShowing,
                      //                 //       child: SizedBox(
                      //                 //         height: 240,
                      //                 //         child: emg.EmojiPicker(
                      //                 //
                      //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                      //                 //             onEmojiSelected(emoji);
                      //                 //             messageChecker = emoji.toString();
                      //                 //           },
                      //                 //           onBackspacePressed: onBackspacePressed,
                      //                 //           config: emg.Config(
                      //                 //             columns: 9,
                      //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                      //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      //                 //             verticalSpacing: 0,
                      //                 //             horizontalSpacing: 0,
                      //                 //             gridPadding: EdgeInsets.zero,
                      //                 //             initCategory: emg.Category.RECENT,
                      //                 //             bgColor: const Color(0xFFF2F2F2),
                      //                 //             indicatorColor: Constants.primaryColor,
                      //                 //             iconColor: Colors.grey,
                      //                 //             iconColorSelected:  Constants.primaryColor,
                      //                 //             backspaceColor:  Constants.primaryColor,
                      //                 //             skinToneDialogBgColor: Colors.white,
                      //                 //             skinToneIndicatorColor: Colors.grey,
                      //                 //             enableSkinTones: true,
                      //                 //             // showRecentsTab: true,
                      //                 //             recentsLimit: 28,
                      //                 //             replaceEmojiOnLimitExceed: false,
                      //                 //             noRecents: const Text(
                      //                 //               'No Recent',
                      //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                      //                 //               textAlign: TextAlign.center,
                      //                 //             ),
                      //                 //             loadingIndicator: const SizedBox.shrink(),
                      //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                      //                 //             categoryIcons: const emg.CategoryIcons(),
                      //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                      //                 //             checkPlatformCompatibility: true,
                      //                 //           ),
                      //                 //         ),
                      //                 //       ),
                      //                 //     ),
                      //                 //   ],
                      //                 // ),
                      //               )
                      //           );
                      //         },);
                      //
                      //       },).then((value) {
                      //
                      //       });
                      //     },
                      //     child: Image.asset("assets/comment.png",height: 18,)),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 3.0),
                      //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                      // ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                        child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                      ),

                    ],
                  ),
                  // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
                ],
              ),
            )
          ],
        ),
      ),
      Positioned(
          bottom:0,right: 5,
          child: privetPublicLogoNew(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
      ),
    ],
  );

}


 CommonVerticalForGridView(
    context,
     OfferDataModelResult  data,
    AsyncSnapshot<String> snapshot,
    bool isCounterSellBuy,
    List<OfferDataModelResult> offerList,
    int index,
    Callback onTap,
    bool isYourOffer,
     List<bool> isAllItemDone1,
     bool isConfirmingUser,
    ){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(8),
          border: Border.all(color: Constants.greyLight,width: 1),),
        width: isMobile? width*0.49:tabWidth*0.49,
        // height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              onLongPress: (){
                LongPressForDelete(context,data,offerList: offerList,index: index);
              },
              child: Stack(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                        DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                        "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                        snapshot.connectionState == ConnectionState.waiting?
                        DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                            :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.fill)), ),

                  isYourOffer ?
                  Positioned(
                      top: 0,
                      left: 0,
                      child: data.offerData!.buyORsell == "SELL" || data.offerData!.buyORsell == "BUY" ?
                      Container(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "SELL" ? Colors.red : Constants.primaryColor1),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell.toString()}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      )
                          : data.offerData!.buyORsell == "DELIVER_BUY" || data.offerData!.buyORsell == "DELIVER_SELL"
                          ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "DELIVER_SELL" ? Colors.red : Constants.primaryColor1),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell.toString()}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      )
                          : Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "COUNTER SELL" ? Constants.primaryColor1 : Colors.red),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell == "COUNTER SELL" ? "COUNTER BUY" : "COUNTER SELL"}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      ))
                      :

                  data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                            ,))):
                  isCounterSellBuy == true ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text("COUNTER ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            )
                      )
                  ):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( "COUNTER ${data.offerData!.buyORsell.toString() == "BUY"?"SELL":"BUY"}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                    top: 0,left: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                          color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                      ),
                      child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                    ),),
                  Positioned(
                    bottom: 0,right: 0,
                    child: Container(
                      width: isMobile? width*0.49:tabWidth*0.49,
                      decoration: BoxDecoration(
                          color: Colors.black45
                      ),
                      padding: EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            child: Stack(
                              children: [
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleUp,overflow: TextOverflow.ellipsis,),
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleDown,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),

                          Row(
                            children: [

                              Image.asset("assets/view.png",height: 10,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text("${data.offerData!.offerviewcount!.length}",style: WhiteHeadingStyle,),
                              2.width,
                              SizedBox(
                                  height: 15,width: 5,
                                  child: VerticalDivider(color: Colors.white,thickness: 1,)),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                  ,style: WhiteHeadingStyle,
                                ),
                              )
                            ],)
                        ],
                      ),
                    ),
                  ),
                  data.offerData!.offertemplate == true? Positioned(
                    top: 0,right: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                          color: Constants.templateBg
                      ),
                      child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
                    ),):SizedBox(),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      maxLines: 3,
                      text:   TextSpan(
                          style:BlackHintStyle,
                          children: [
                            TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                            TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} / ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                          ]
                      )),
                  const SizedBox(height: 3,),

                  // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
                  data.offerData!.offertemplate == true?SizedBox():
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:0.0),
                    child: Row(
                      children: [

                        Flexible(child: Text(data.offerData!.counterdUser!.isEmpty  || data.offerData!.counterdUser == null || data.offerData!.counterdUser == "null"? "${Url.NoResponded}":"${data.offerData!.counterdUser!.length} ${data.offerData!.counterdUser!.length >= 2? Url.peopleResponded:Url.personResponded}", style: greyHintStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 4,),
                        data.offerData!.counterdUser!.isEmpty?SizedBox():
                        Stack(
                          children: [
                            SizedBox(width: 55,),
                            ClipOval(
                              child: Image.network(
                                "${Url.IMAGE_URL}${data.offerData!.counterdUser![0].image}",
                                height: 22,
                                width: 22,
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                  return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,);
                                },),
                            ),
                            data.offerData!.counterdUser!.length >= 2?  Positioned(
                                left: 7,
                                top: 0,bottom: 0,
                                child: ClipOval(
                                  child: Image.network(
                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![1].image}",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.fill,);
                                    },),
                                )):SizedBox(),
                            data.offerData!.counterdUser!.length >= 3?  Positioned(
                                left: 15,
                                top: 0,bottom: 0,
                                child: ClipOval(
                                  child:
                                  Image.network(
                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![2].image}",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.fill,);
                                    },),
                                )):SizedBox(),
                            data.offerData!.counterdUser!.length >= 4?   Positioned(
                                left: 23,
                                top: 0,bottom: 0,
                                child: ClipOval(
                                  child:
                                  Image.network(
                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![3].image}",
                                    height: 22,
                                    width: 22,
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                        height: 22,
                                        width: 22,
                                        fit: BoxFit.fill,);
                                    },),
                                )):SizedBox(),
                            data.offerData!.counterdUser!.length >= 5?  Positioned(
                                left: 22,
                                top: 0,bottom: 0,
                                child: CircleAvatar(
                                    backgroundColor: Constants.lightGreen,
                                    child: Center(
                                      child: Text("+${ data.offerData!.counterdUser!.length-4}",style: BlackHintStyle,),
                                    )
                                )):SizedBox(),
                          ],
                        )

                      ],
                    ),
                  ):
                  isCounterSellBuy == true?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:0.0),
                    child: Text.rich(
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        TextSpan(
                        text:"${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "QUERY" ? "Queried by " : 
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "EXECUTE" ? "Executed by " :
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "SIGN-OFF" ? "Signed off by " : 
                        "${data.offerCounters!.last.counter!.last.tabactivity.toString().capitalize()}" + "ed by ")), 
                            style:greyHintStyle,
                            children: <InlineSpan>[
                              TextSpan(
                                text: data.offerCounters!.last.counter!.last.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"you": "${data.offerCounters!.last.counter!.last.fromCounter!.displayname.toString()}",
                                style:grey12500StyleE,
                              ),
                            ]
                        )
                    ),
                  ) :SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.offerData!.like == 0 ?
                      data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()
                          ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      ):
                      data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                      Builder(
                        builder: (ctx) {
                          return ReactionButton<String>(
                            onReactionChanged: (String? value) {
                              var body = {
                                "offer_id": data.offerData!.id.toString(),
                                "user_id" : DataManager.getInstance().getuserId().toString()
                              };
                              DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                              if(value == "like"){
                                DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Liked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 1,
                                            offerLike: data.offerData!.offerLike!+1,
                                            offerDisLike: data.offerData!.offerDisLike,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }else{
                                DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Disliked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 2,
                                            offerLike: data.offerData!.offerLike,
                                            offerDisLike:data.offerData!.offerDisLike!+1,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }
                            },
                            reactions: flagsReactions,
                            initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                              value: null,
                              icon:  Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                                ),
                              ),
                            ): Reaction<String>(
                              value: 'like',
                              icon:Icon(
                                Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                              ),
                            ),
                            boxColor:Colors.amber.shade300 ,
                            boxRadius: 10,
                            boxElevation: 0,
                            boxDuration: const Duration(milliseconds: 200),
                            itemScaleDuration: const Duration(milliseconds: 100),
                          );
                        },
                      ): Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      )
                          :Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
                      ),

                      (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 2),
                        child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                        "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                      ),

                      Spacer(),
                      InkWell(
                          onTap:(){
                            var body = {
                              "offer_id": data.offerData!.id.toString(),
                              "user_id" : DataManager.getInstance().getuserId().toString()
                            };
                            DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                            DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                              if( value["message"].toString().trim() == "offer removed from favourite"){
                                Constants.showToast("${Url.UnMarkFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: false,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }else{
                                Constants.showToast("${Url.markFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: true,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }
                            });
                          },
                          child: data.offerData!.favourite == true ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 18,),
                          ):Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5),
                        child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                      ),
                      //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // InkWell(
                      //     onTap:(){
                      //       var body = {
                      //         "offer_id": data.offerData!.id.toString(),
                      //         "user_id" : DataManager.getInstance().getuserId().toString()
                      //       };
                      //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                      //       bool isCommentsLoading = true;
                      //       List<CommentsDataList> CommentsList = [];
                      //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                      //         CommentsList = value;
                      //         isCommentsLoading = false;
                      //       });
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                      //         context: context, builder: (context) {
                      //         return  StatefulBuilder(builder: (context, modalState) {
                      //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                      //             modalState((){});
                      //
                      //           },):null;
                      //           return Container(
                      //               height: MediaQuery.of(context).size.height*0.8,
                      //               width:isMobile?width:tabWidth,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                      //                 color:Color(0x33DCF0DD),
                      //               ),
                      //               child: Scaffold(
                      //                 backgroundColor: Colors.transparent,
                      //                 body: Column(
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Container(
                      //                         height: 3.5,
                      //                         margin: EdgeInsets.only(top: 13),
                      //                         width: 38,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(5),
                      //                           color: Colors.black54,
                      //                         )),
                      //                     20.height,
                      //                     Text("Comments",style:BlackSubTitleStyle,),
                      //                     10.height,
                      //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                      //                     2.height,
                      //                     // isCommentsLoading?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                      //                     //   child: LoadingWidget(),
                      //                     // )
                      //                     //     :
                      //                     //
                      //                     // CommentsList.isEmpty?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                      //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                      //                     // )
                      //                     //     : Expanded(
                      //                     //   child: ListView.builder(
                      //                     //     controller: scrollCommentsController,
                      //                     //     itemCount: CommentsList.length,
                      //                     //     padding: EdgeInsets.only(bottom: 100),
                      //                     //     itemBuilder: (context, i) {
                      //                     //       var CommentsData = CommentsList[i];
                      //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                      //                     //       final currentTime = DateTime.now();
                      //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                      //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                      //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                      //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                      //                     //       return Row(
                      //                     //         mainAxisAlignment: MainAxisAlignment.start,
                      //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //         children: [
                      //                     //           Container(
                      //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                      //                     //             height: 40,
                      //                     //             width: 40,
                      //                     //             decoration: BoxDecoration(
                      //                     //                 shape: BoxShape.circle,
                      //                     //                 image:
                      //                     //                 CommentsData.user!.profilePicture == null ||
                      //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                      //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                      //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                      //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                      //                     //             ),
                      //                     //           ),
                      //                     //           Flexible(
                      //                     //             child: Container(
                      //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      //                     //               decoration: BoxDecoration(
                      //                     //                 borderRadius: BorderRadius.circular(7),
                      //                     //                 color: Constants.white,
                      //                     //               ),
                      //                     //               child: Column(
                      //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                     //                 children: [
                      //                     //                   Row(
                      //                     //                     children: [
                      //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                      //                     //                       10.width,
                      //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                      //                     //                     ],
                      //                     //                   ),
                      //                     //
                      //                     //                   Padding(
                      //                     //                     padding: const EdgeInsets.only(top: 2.0),
                      //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                      //                     //                   ),
                      //                     //                 ],
                      //                     //               ),
                      //                     //             ),
                      //                     //           ),
                      //                     //         ],
                      //                     //       );
                      //                     //     },),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //                 bottomSheet:Container(
                      //
                      //                   decoration: BoxDecoration(
                      //                       color: Color(0x33DCF0DD),
                      //
                      //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                      //                   ),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     crossAxisAlignment: CrossAxisAlignment.center,
                      //                     children: [
                      //
                      //                       10.width,
                      //                       Container(
                      //                         height: 35,
                      //                         width: 35,
                      //                         margin: const EdgeInsets.only(bottom: 5),
                      //                         padding: EdgeInsets.zero,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius: BorderRadius.circular(5),
                      //                             color: Constants.greyDark
                      //                         ),
                      //                         child: Center(child: Container(
                      //                           height: 35,width: 35,
                      //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                      //                             // border: Border.all(color: Constants.white,width: 4),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                      //                           ):  BoxDecoration(
                      //                               border: Border.all(color: Constants.white,width: 2),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      //                           ),
                      //                         )),
                      //                       ),
                      //
                      //                       Flexible(
                      //                         child: TextFormField(
                      //                           controller: messageController,
                      //                           keyboardType: TextInputType.text,
                      //                           // maxLines: ,
                      //                           onChanged: (value){
                      //                             setState(() {
                      //
                      //                             });
                      //                             modalState((){});
                      //                           },
                      //                           autofocus: false,
                      //                           focusNode: focusNode,
                      //                           // style: black14500,
                      //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                      //                           decoration: InputDecoration(
                      //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                             hintText: "Write your comments",
                      //                             hintStyle: greySubTitleItalicStyle,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       messageController.text.isEmpty?SizedBox():InkWell(
                      //                         onTap: (){
                      //                           // messageController.clear();
                      //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                      //                             if(value["status"] == "200"){
                      //                               var CommentRes =  CommentsDataList(
                      //                                 id: value["result"]["id"],
                      //                                 user:CommentsUser(
                      //                                     id: value["result"]["user"]["id"],
                      //                                     displayname:  value["result"]["user"]["displayname"],
                      //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                      //                                     username:  value["result"]["user"]["username"]
                      //                                 ),
                      //                                 offer: value["result"]["offer"],
                      //                                 comment: value["result"]["comment"],
                      //                                 createdAt: value["result"]["created_at"],
                      //                                 updatedAt: value["result"]["updated_at"],
                      //                               );
                      //                               modalState((){
                      //                                 CommentsList.add(CommentRes);
                      //                                 messageController.clear();
                      //                                 scrollToBottom();
                      //                               });
                      //                             }
                      //                           });
                      //                         },
                      //                         child: Container(
                      //                           margin: EdgeInsets.only(right: 10),
                      //                           height: 40,
                      //                           width: 40,
                      //                           decoration: BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               border: Border.all(color: Constants.greyLight,width: 1),
                      //                               color:Constants.primaryColor
                      //                           ),
                      //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 // Column(
                      //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                      //                 //   mainAxisSize: MainAxisSize.max,
                      //                 //   mainAxisAlignment: MainAxisAlignment.end,
                      //                 //   children: [
                      //                 //     Container(
                      //                 //       height: 50,
                      //                 //       decoration: BoxDecoration(
                      //                 //         color: Color(
                      //                 //             0x1ABCDFF8),
                      //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                      //                 //       ),
                      //                 //       child: Row(
                      //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 //         children: [
                      //                 //
                      //                 //           const SizedBox(width: 7,),
                      //                 //           isemojiShowing == false?
                      //                 //           InkWell(
                      //                 //               onTap: (){
                      //                 //                 // controller.focusNode.value.unfocus();
                      //                 //                 // controller.focusNode.value.canRequestFocus=false;
                      //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                      //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                      //                 //                 //   // controller.focusNode.value.requestFocus();
                      //                 //                 //   // controller.filepick.value = false;
                      //                 //                 //   // controller.showStickers.value = false;
                      //                 //                 //   // controller.showAttachmentButtons.value = false;
                      //                 //                 // },);
                      //                 //                 //
                      //                 //                 // controller.filepick.value = false;
                      //                 //                 // // if ( controller.emojiShowing.value != false) {
                      //                 //                 // //   FocusScope.of(context).unfocus();
                      //                 //                 // // }
                      //                 //               },
                      //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                      //                 //           InkWell(
                      //                 //             onTap: () {
                      //                 //               // controller.focusNode.value.requestFocus();
                      //                 //               // controller.emojiShowing.value = false;
                      //                 //               // controller.filepick.value = false;
                      //                 //               // controller.showStickers.value = false;
                      //                 //               // controller.showAttachmentButtons.value = false;
                      //                 //
                      //                 //             },
                      //                 //             child: const Padding(
                      //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //                 //               child: Icon(
                      //                 //                 Icons.keyboard,
                      //                 //                 color: Colors.black45,size: 22,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //           Flexible(
                      //                 //             child: TextFormField(
                      //                 //               controller: messageController,
                      //                 //               onChanged: (value){
                      //                 //
                      //                 //               },
                      //                 //               autofocus: false,
                      //                 //               focusNode: focusNode,
                      //                 //               // style: black14500,
                      //                 //               cursorColor: Colors.black,
                      //                 //               onTap: (){
                      //                 //                 isemojiShowing = false;
                      //                 //               },
                      //                 //               decoration: InputDecoration(
                      //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                 //                 hintText: "Write your comments",
                      //                 //                 hintStyle: grey14400,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //
                      //                 //         ],
                      //                 //       ),
                      //                 //     ),
                      //                 //     Offstage(
                      //                 //       offstage: isemojiShowing,
                      //                 //       child: SizedBox(
                      //                 //         height: 240,
                      //                 //         child: emg.EmojiPicker(
                      //                 //
                      //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                      //                 //             onEmojiSelected(emoji);
                      //                 //             messageChecker = emoji.toString();
                      //                 //           },
                      //                 //           onBackspacePressed: onBackspacePressed,
                      //                 //           config: emg.Config(
                      //                 //             columns: 9,
                      //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                      //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      //                 //             verticalSpacing: 0,
                      //                 //             horizontalSpacing: 0,
                      //                 //             gridPadding: EdgeInsets.zero,
                      //                 //             initCategory: emg.Category.RECENT,
                      //                 //             bgColor: const Color(0xFFF2F2F2),
                      //                 //             indicatorColor: Constants.primaryColor,
                      //                 //             iconColor: Colors.grey,
                      //                 //             iconColorSelected:  Constants.primaryColor,
                      //                 //             backspaceColor:  Constants.primaryColor,
                      //                 //             skinToneDialogBgColor: Colors.white,
                      //                 //             skinToneIndicatorColor: Colors.grey,
                      //                 //             enableSkinTones: true,
                      //                 //             // showRecentsTab: true,
                      //                 //             recentsLimit: 28,
                      //                 //             replaceEmojiOnLimitExceed: false,
                      //                 //             noRecents: const Text(
                      //                 //               'No Recent',
                      //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                      //                 //               textAlign: TextAlign.center,
                      //                 //             ),
                      //                 //             loadingIndicator: const SizedBox.shrink(),
                      //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                      //                 //             categoryIcons: const emg.CategoryIcons(),
                      //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                      //                 //             checkPlatformCompatibility: true,
                      //                 //           ),
                      //                 //         ),
                      //                 //       ),
                      //                 //     ),
                      //                 //   ],
                      //                 // ),
                      //               )
                      //           );
                      //         },);
                      //
                      //       },).then((value) {
                      //
                      //       });
                      //     },
                      //     child: Image.asset("assets/comment.png",height: 18,)),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 3.0),
                      //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                      // ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                        child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                      ),
                    ],
                  ),
                  // isCounterSellBuy == true ?
                  // data.offerCounters!.first.counter!.length <= 1?  Padding(
                  //   padding: const EdgeInsets.symmetric(vertical:3.0),
                  //   child: Text.rich(
                  //       maxLines: 1,
                  //       TextSpan(
                  //       text:"${data.offerCounters!.first.counter![0].tabactivity}  by  ",
                  //       style:greyHintStyle,
                  //       children: <InlineSpan>[
                  //         TextSpan(
                  //           text: data.offerCounters!.first.counter![0].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![0].fromCounter!.username.toString()}",
                  //           style:grey12500StyleE,
                  //         ),
                  //
                  //       ]
                  //   )),
                  // ):SizedBox() :
                  // SizedBox(),
                  // isCounterSellBuy == true ?
                  // data.offerCounters!.first.counter!.length <= 1 ?SizedBox():
                  // Text.rich(
                  //   maxLines: 1,
                  //     TextSpan(
                  //     text:"${data.offerCounters!.first.counter![1].tabactivity}  by  ",
                  //     style:greyHintStyle,
                  //     children: <InlineSpan>[
                  //       TextSpan(
                  //         text: data.offerCounters!.first.counter![1].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![1].fromCounter!.username.toString()}",
                  //         style:grey12500StyleE,
                  //       ),
                  //       TextSpan(
                  //         text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                  //         style:grey12500StyleE,
                  //       ),
                  //     ]
                  // ))
                  //     : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
      data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED" ?
      isConfirmingUser ? SizedBox():
      Positioned(
        top: 0,bottom: 0,left: 0,right: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: isMobile? width*0.49:tabWidth*0.49,
            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(8),
              color: Constants.closeOfferCard,
            ),
          ),
        ),
      ) :
      isAllItemDone1.contains(false)?SizedBox():
      isConfirmingUser ? SizedBox(): Positioned(
        top: 0,bottom: 0,left: 0,right: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: isMobile? width*0.49:tabWidth*0.49,
            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(8),
              color: Constants.closeOfferCard,
            ),
          ),
        ),
      ),


      data.offerData!.offerstatus.toString().trim().toUpperCase() != "CLOSED" ? SizedBox(): data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId() || isCounterSellBuy?
      Positioned(
        top:2,right: 10,
        child: InkWell(
          onTap: (){
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                bool butttonLoader = false;
                return StatefulBuilder(builder: (context, ModalState) {
                  return Dialog(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      elevation: 16,
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        children: [
                          Image.asset("assets/delete.png",height: 50,width: 50,color: Colors.black,),
                          Padding(
                            padding: EdgeInsets.only(top:10,bottom: 10),
                            child: Text('DELETE OFFER!',style: BlackFieldStyleBold,textAlign: TextAlign.center),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text("ARE YOU SURE TO DELETE?",style: Black87HintStyle,textAlign: TextAlign.center),
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
                                    fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
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
                                    var body = {
                                      "offer_id": data.offerData!.id.toString()
                                    };
                                    DrawAuraAPi.CreateDataApi(body: body ,ApiEndPoint: "deleteOffer").then((value) {
                                      ModalState(() {
                                        butttonLoader= false;
                                      });
                                      Navigator.pop(context);
                                      if(value["status"] == 200){
                                        Constants.showToast(value["message"]);
                                        ModalState((){
                                          offerList.removeAt(index);
                                        });

                                      }else{
                                        Constants.showToast(value["message"]);
                                      }

                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.primaryColor1,
                                    fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                  child: butttonLoader == true ? SizedBox(height: 24,width: 24,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)): Text("Yes",style:WhiteButtonStyle,)),
                            ],
                          ),
                        ],
                      )
                  );
                },);
              },
            );
          },
          child: CircleAvatar(
              radius: 13,backgroundColor: Colors.grey.shade800,
              child: Image.asset("assets/delete.png",height: 18,color: Colors.white,)),
        ),
      ):SizedBox(),
      Positioned(
          bottom:0,right: 0,
          child: privetPublicLogoNew(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
      ),
    ],
  );

}

 TemplateCardGridView(context,OfferDataModelResult  data,
     AsyncSnapshot<String> snapshot,
     bool isCounterSellBuy,
     List<OfferDataModelResult> offerList,
     int index
     )
 {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(8),
          border: Border.all(color: Constants.greyLight,width: 1),),
        width: isMobile? width*0.49:tabWidth*0.49,
        // height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                tapOnTemplate(context,data);
              },
              onLongPress: (){
                LongPressForDelete(context,data,offerList: offerList,index: index);
              },
              child: Stack(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                        DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                        "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                        snapshot.connectionState == ConnectionState.waiting?
                        DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                            :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.fill)), ),
                  data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                            ,))):
                  isCounterSellBuy == true ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text("COUNTER ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"?Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text( "COUNTER ${data.offerData!.buyORsell.toString() == "BUY"?"SELL":"BUY"}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                    top: 0,left: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                          color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                      ),
                      child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                    ),),
                  Positioned(
                    bottom: 0,right: 0,
                    child: Container(
                      width: isMobile? width*0.49:tabWidth*0.49,
                      decoration: BoxDecoration(
                          color: Colors.black45
                      ),
                      padding: EdgeInsets.only(left: 10,top: 3,bottom: 3,right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleUp,overflow: TextOverflow.ellipsis,),
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleDown,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),

                          Row(
                            children: [

                              Image.asset("assets/view.png",height: 10,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text("${data.offerData!.offerviewcount!.length}",style: WhiteHeadingStyle,),
                              2.width,
                              SizedBox(
                                  height: 15,width: 5,
                                  child: VerticalDivider(color: Colors.white,thickness: 1,)),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                  ,style: WhiteHeadingStyle,
                                ),
                              )
                            ],)
                        ],
                      ),
                    ),
                  ),
                  data.offerData!.offertemplate == true? Positioned(
                    top: 0,right: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                          color: Constants.templateBg
                      ),
                      child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
                    ),):SizedBox(),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      maxLines: 3,
                      text: TextSpan(
                          style:BlackHintStyle,
                          children: [
                            TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                            TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} / ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                          ]
                      )),
                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.offerData!.like == 0 ?
                      data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()
                          ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      ):
                      data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                      Builder(
                        builder: (ctx) {
                          return ReactionButton<String>(
                            onReactionChanged: (String? value) {
                              var body = {
                                "offer_id": data.offerData!.id.toString(),
                                "user_id" : DataManager.getInstance().getuserId().toString()
                              };
                              DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                              if(value == "like"){
                                DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Liked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 1,
                                            offerLike: data.offerData!.offerLike!+1,
                                            offerDisLike: data.offerData!.offerDisLike,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }else{
                                DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                  Constants.showToast("${value["message"]}");
                                  if( value["message"].toString().trim() == "Offer Disliked"){
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            favourite: data.offerData!.favourite,
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerfavoritecount: data.offerData!.offerfavoritecount,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            like: 2,
                                            offerLike: data.offerData!.offerLike,
                                            offerDisLike:data.offerData!.offerDisLike!+1,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              }
                            },
                            reactions: flagsReactions,
                            initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                              value: null,
                              icon:  Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                                ),
                              ),
                            ): Reaction<String>(
                              value: 'like',
                              icon:Icon(
                                Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                              ),
                            ),
                            boxColor:Colors.amber.shade300 ,
                            boxRadius: 10,
                            boxElevation: 0,
                            boxDuration: const Duration(milliseconds: 200),
                            itemScaleDuration: const Duration(milliseconds: 100),
                          );
                        },
                      ): Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                      )
                          :Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
                      ),

                      (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 2),
                        child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                        "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                      ),

                      Spacer(),
                      InkWell(
                          onTap:(){
                            var body = {
                              "offer_id": data.offerData!.id.toString(),
                              "user_id" : DataManager.getInstance().getuserId().toString()
                            };
                            DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                            DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                              if( value["message"].toString().trim() == "offer removed from favourite"){
                                Constants.showToast("${Url.UnMarkFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: false,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }else{
                                Constants.showToast("${Url.markFav}");
                                var data2 = OfferDataModelResult(
                                    offerCounters: data.offerCounters,
                                    offerData: MainOfferDetails(
                                        addres: data.offerData!.addres,
                                        buyORsell:  data.offerData!.buyORsell,
                                        category: data.offerData!.category,
                                        segment: data.offerData!.segment,
                                        subsegment:  data.offerData!.subsegment,
                                        computedRating: data.offerData!.computedRating,
                                        counterdUser: data.offerData!.counterdUser,
                                        createdAt: data.offerData!.createdAt,
                                        id: data.offerData!.id,
                                        modified: data.offerData!.modified,
                                        offerareas: data.offerData!.offerareas,
                                        offerBids: data.offerData!.offerBids,
                                        offerConditions: data.offerData!.offerConditions,
                                        offerconfirmed:  data.offerData!.offerconfirmed,
                                        offercopycount: data.offerData!.offercopycount,
                                        offerevent: data.offerData!.offerevent,
                                        offerexecuteend: data.offerData!.offerexecuteend,
                                        offerexecutestart: data.offerData!.offerexecutestart,
                                        offerItems: data.offerData!.offerItems,
                                        offerincepted: data.offerData!.offerincepted,
                                        offerinform: data.offerData!.offerinform,
                                        offerresponses:  data.offerData!.offerresponses,
                                        offerservicepercentage: data.offerData!.offerservicepercentage,
                                        offersignedoff:data.offerData!.offersignedoff,
                                        offerstatus:  data.offerData!.offerstatus,
                                        offertemplate: data.offerData!.offertemplate,
                                        offerviewcount: data.offerData!.offerviewcount,
                                        privacy: data.offerData!.privacy,
                                        subscribers:data.offerData!.subscribers,
                                        tabactivity: data.offerData!.tabactivity,
                                        userRating: data.offerData!.userRating,
                                        favourite: true,
                                        offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                                        like: data.offerData!.like,
                                        offerLike: data.offerData!.offerLike,
                                        offerDisLike: data.offerData!.offerDisLike,
                                        comments: data.offerData!.comments,
                                        ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                    )
                                );
                                offerList[index]= data2;
                              }
                            });
                          },
                          child: data.offerData!.favourite == true ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 18,),
                          ):Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5),
                        child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                      ),
                      //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // InkWell(
                      //     onTap:(){
                      //       var body = {
                      //         "offer_id": data.offerData!.id.toString(),
                      //         "user_id" : DataManager.getInstance().getuserId().toString()
                      //       };
                      //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                      //       bool isCommentsLoading = true;
                      //       List<CommentsDataList> CommentsList = [];
                      //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                      //         CommentsList = value;
                      //         isCommentsLoading = false;
                      //       });
                      //       showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                      //         context: context, builder: (context) {
                      //         return  StatefulBuilder(builder: (context, modalState) {
                      //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                      //             modalState((){});
                      //
                      //           },):null;
                      //           return Container(
                      //               height: MediaQuery.of(context).size.height*0.8,
                      //               width:isMobile?width:tabWidth,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                      //                 color:Color(0x33DCF0DD),
                      //               ),
                      //               child: Scaffold(
                      //                 backgroundColor: Colors.transparent,
                      //                 body: Column(
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Container(
                      //                         height: 3.5,
                      //                         margin: EdgeInsets.only(top: 13),
                      //                         width: 38,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(5),
                      //                           color: Colors.black54,
                      //                         )),
                      //                     20.height,
                      //                     Text("Comments",style:BlackSubTitleStyle,),
                      //                     10.height,
                      //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                      //                     2.height,
                      //                     // isCommentsLoading?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                      //                     //   child: LoadingWidget(),
                      //                     // )
                      //                     //     :
                      //                     //
                      //                     // CommentsList.isEmpty?
                      //                     // Padding(
                      //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                      //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                      //                     // )
                      //                     //     : Expanded(
                      //                     //   child: ListView.builder(
                      //                     //     controller: scrollCommentsController,
                      //                     //     itemCount: CommentsList.length,
                      //                     //     padding: EdgeInsets.only(bottom: 100),
                      //                     //     itemBuilder: (context, i) {
                      //                     //       var CommentsData = CommentsList[i];
                      //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                      //                     //       final currentTime = DateTime.now();
                      //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                      //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                      //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                      //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                      //                     //       return Row(
                      //                     //         mainAxisAlignment: MainAxisAlignment.start,
                      //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //         children: [
                      //                     //           Container(
                      //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                      //                     //             height: 40,
                      //                     //             width: 40,
                      //                     //             decoration: BoxDecoration(
                      //                     //                 shape: BoxShape.circle,
                      //                     //                 image:
                      //                     //                 CommentsData.user!.profilePicture == null ||
                      //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                      //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                      //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                      //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                      //                     //             ),
                      //                     //           ),
                      //                     //           Flexible(
                      //                     //             child: Container(
                      //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      //                     //               decoration: BoxDecoration(
                      //                     //                 borderRadius: BorderRadius.circular(7),
                      //                     //                 color: Constants.white,
                      //                     //               ),
                      //                     //               child: Column(
                      //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                     //                 children: [
                      //                     //                   Row(
                      //                     //                     children: [
                      //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                      //                     //                       10.width,
                      //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                      //                     //                     ],
                      //                     //                   ),
                      //                     //
                      //                     //                   Padding(
                      //                     //                     padding: const EdgeInsets.only(top: 2.0),
                      //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                      //                     //                   ),
                      //                     //                 ],
                      //                     //               ),
                      //                     //             ),
                      //                     //           ),
                      //                     //         ],
                      //                     //       );
                      //                     //     },),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //                 bottomSheet:Container(
                      //
                      //                   decoration: BoxDecoration(
                      //                       color: Color(0x33DCF0DD),
                      //
                      //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                      //                   ),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     crossAxisAlignment: CrossAxisAlignment.center,
                      //                     children: [
                      //
                      //                       10.width,
                      //                       Container(
                      //                         height: 35,
                      //                         width: 35,
                      //                         margin: const EdgeInsets.only(bottom: 5),
                      //                         padding: EdgeInsets.zero,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius: BorderRadius.circular(5),
                      //                             color: Constants.greyDark
                      //                         ),
                      //                         child: Center(child: Container(
                      //                           height: 35,width: 35,
                      //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                      //                             // border: Border.all(color: Constants.white,width: 4),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                      //                           ):  BoxDecoration(
                      //                               border: Border.all(color: Constants.white,width: 2),
                      //                               shape: BoxShape.circle,
                      //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                      //                           ),
                      //                         )),
                      //                       ),
                      //
                      //                       Flexible(
                      //                         child: TextFormField(
                      //                           controller: messageController,
                      //                           keyboardType: TextInputType.text,
                      //                           // maxLines: ,
                      //                           onChanged: (value){
                      //                             setState(() {
                      //
                      //                             });
                      //                             modalState((){});
                      //                           },
                      //                           autofocus: false,
                      //                           focusNode: focusNode,
                      //                           // style: black14500,
                      //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                      //                           decoration: InputDecoration(
                      //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                             hintText: "Write your comments",
                      //                             hintStyle: greySubTitleItalicStyle,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       messageController.text.isEmpty?SizedBox():InkWell(
                      //                         onTap: (){
                      //                           // messageController.clear();
                      //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                      //                             if(value["status"] == "200"){
                      //                               var CommentRes =  CommentsDataList(
                      //                                 id: value["result"]["id"],
                      //                                 user:CommentsUser(
                      //                                     id: value["result"]["user"]["id"],
                      //                                     displayname:  value["result"]["user"]["displayname"],
                      //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                      //                                     username:  value["result"]["user"]["username"]
                      //                                 ),
                      //                                 offer: value["result"]["offer"],
                      //                                 comment: value["result"]["comment"],
                      //                                 createdAt: value["result"]["created_at"],
                      //                                 updatedAt: value["result"]["updated_at"],
                      //                               );
                      //                               modalState((){
                      //                                 CommentsList.add(CommentRes);
                      //                                 messageController.clear();
                      //                                 scrollToBottom();
                      //                               });
                      //                             }
                      //                           });
                      //                         },
                      //                         child: Container(
                      //                           margin: EdgeInsets.only(right: 10),
                      //                           height: 40,
                      //                           width: 40,
                      //                           decoration: BoxDecoration(
                      //                               shape: BoxShape.circle,
                      //                               border: Border.all(color: Constants.greyLight,width: 1),
                      //                               color:Constants.primaryColor
                      //                           ),
                      //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 // Column(
                      //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                      //                 //   mainAxisSize: MainAxisSize.max,
                      //                 //   mainAxisAlignment: MainAxisAlignment.end,
                      //                 //   children: [
                      //                 //     Container(
                      //                 //       height: 50,
                      //                 //       decoration: BoxDecoration(
                      //                 //         color: Color(
                      //                 //             0x1ABCDFF8),
                      //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                      //                 //       ),
                      //                 //       child: Row(
                      //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 //         children: [
                      //                 //
                      //                 //           const SizedBox(width: 7,),
                      //                 //           isemojiShowing == false?
                      //                 //           InkWell(
                      //                 //               onTap: (){
                      //                 //                 // controller.focusNode.value.unfocus();
                      //                 //                 // controller.focusNode.value.canRequestFocus=false;
                      //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                      //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                      //                 //                 //   // controller.focusNode.value.requestFocus();
                      //                 //                 //   // controller.filepick.value = false;
                      //                 //                 //   // controller.showStickers.value = false;
                      //                 //                 //   // controller.showAttachmentButtons.value = false;
                      //                 //                 // },);
                      //                 //                 //
                      //                 //                 // controller.filepick.value = false;
                      //                 //                 // // if ( controller.emojiShowing.value != false) {
                      //                 //                 // //   FocusScope.of(context).unfocus();
                      //                 //                 // // }
                      //                 //               },
                      //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                      //                 //           InkWell(
                      //                 //             onTap: () {
                      //                 //               // controller.focusNode.value.requestFocus();
                      //                 //               // controller.emojiShowing.value = false;
                      //                 //               // controller.filepick.value = false;
                      //                 //               // controller.showStickers.value = false;
                      //                 //               // controller.showAttachmentButtons.value = false;
                      //                 //
                      //                 //             },
                      //                 //             child: const Padding(
                      //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //                 //               child: Icon(
                      //                 //                 Icons.keyboard,
                      //                 //                 color: Colors.black45,size: 22,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //           Flexible(
                      //                 //             child: TextFormField(
                      //                 //               controller: messageController,
                      //                 //               onChanged: (value){
                      //                 //
                      //                 //               },
                      //                 //               autofocus: false,
                      //                 //               focusNode: focusNode,
                      //                 //               // style: black14500,
                      //                 //               cursorColor: Colors.black,
                      //                 //               onTap: (){
                      //                 //                 isemojiShowing = false;
                      //                 //               },
                      //                 //               decoration: InputDecoration(
                      //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                      //                 //                 hintText: "Write your comments",
                      //                 //                 hintStyle: grey14400,
                      //                 //               ),
                      //                 //             ),
                      //                 //           ),
                      //                 //
                      //                 //         ],
                      //                 //       ),
                      //                 //     ),
                      //                 //     Offstage(
                      //                 //       offstage: isemojiShowing,
                      //                 //       child: SizedBox(
                      //                 //         height: 240,
                      //                 //         child: emg.EmojiPicker(
                      //                 //
                      //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                      //                 //             onEmojiSelected(emoji);
                      //                 //             messageChecker = emoji.toString();
                      //                 //           },
                      //                 //           onBackspacePressed: onBackspacePressed,
                      //                 //           config: emg.Config(
                      //                 //             columns: 9,
                      //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                      //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                      //                 //             verticalSpacing: 0,
                      //                 //             horizontalSpacing: 0,
                      //                 //             gridPadding: EdgeInsets.zero,
                      //                 //             initCategory: emg.Category.RECENT,
                      //                 //             bgColor: const Color(0xFFF2F2F2),
                      //                 //             indicatorColor: Constants.primaryColor,
                      //                 //             iconColor: Colors.grey,
                      //                 //             iconColorSelected:  Constants.primaryColor,
                      //                 //             backspaceColor:  Constants.primaryColor,
                      //                 //             skinToneDialogBgColor: Colors.white,
                      //                 //             skinToneIndicatorColor: Colors.grey,
                      //                 //             enableSkinTones: true,
                      //                 //             // showRecentsTab: true,
                      //                 //             recentsLimit: 28,
                      //                 //             replaceEmojiOnLimitExceed: false,
                      //                 //             noRecents: const Text(
                      //                 //               'No Recent',
                      //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                      //                 //               textAlign: TextAlign.center,
                      //                 //             ),
                      //                 //             loadingIndicator: const SizedBox.shrink(),
                      //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                      //                 //             categoryIcons: const emg.CategoryIcons(),
                      //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                      //                 //             checkPlatformCompatibility: true,
                      //                 //           ),
                      //                 //         ),
                      //                 //       ),
                      //                 //     ),
                      //                 //   ],
                      //                 // ),
                      //               )
                      //           );
                      //         },);
                      //
                      //       },).then((value) {
                      //
                      //       });
                      //     },
                      //     child: Image.asset("assets/comment.png",height: 18,)),
                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 3.0),
                      //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                      // ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                        child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                      ),

                    ],
                  ),
                  // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
                ],
              ),
            )
          ],
        ),
      ),
      Positioned(
          bottom:0,right: 0,
          child: privetPublicLogoNew(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
      ),
    ],
  );

}



CommonOfferCardListView(
    context,OfferDataModelResult  data,
    AsyncSnapshot<String> snapshot,
    bool isCounterSellBuy,
    List<OfferDataModelResult> offerList,
    int index,
    Callback onTap,
    bool isYourOffer,
     List<bool> isAllItemDone1,
    bool  isConfirmingUser
    ){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(

          borderRadius:  BorderRadius.circular(8),
          border: Border.all(color: Constants.greyLight,width: 1),),
        width: isMobile? width:tabWidth,
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        height: isMobile == false?tabHeight*0.40: height*0.20,
        child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              onLongPress: (){
                LongPressForDelete(context,data,offerList: offerList,index: index);
              },
              child: Stack(
                children: [
                  Container(
                    height: isMobile == false?tabHeight*0.40: height*0.20,
                    width: isMobile? width*0.42:tabWidth*0.42,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                        image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                        DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                        "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                        snapshot.connectionState == ConnectionState.waiting?
                        DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                            :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                        DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.fill)), ),

                  isYourOffer ?
                  Positioned(
                      top: 0,
                      left: 0,
                      child: data.offerData!.buyORsell == "SELL" || data.offerData!.buyORsell == "BUY" ?
                      Container(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "SELL" ? Colors.red : Constants.primaryColor1),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell.toString()}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      )
                          : data.offerData!.buyORsell == "DELIVER_BUY" || data.offerData!.buyORsell == "DELIVER_SELL"
                          ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "DELIVER_SELL" ? Colors.red : Constants.primaryColor1),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell.toString()}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      )
                          : Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell == "COUNTER SELL" ? Constants.primaryColor1 : Colors.red),
                        child: Center(
                            child: Text("${data.offerData!.buyORsell == "COUNTER SELL" ? "COUNTER BUY" : "COUNTER SELL"}",
                              style: WhiteHeadingStyle,
                              textAlign: TextAlign.center,
                            )),
                      ))
                      :

                  data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                            ,))):
                  isCounterSellBuy == true ?
                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                          ),
                          child: Center(child: Text("COUNTER ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                      top: 0,left: 0,
                      child:  Container(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell.toString() =="SELL"?Constants.primaryColor1: Constants.redColor
                          ),
                          child: Center(child: Text( "COUNTER ${data.offerData!.buyORsell.toString() == "BUY"?"SELL":"BUY"}",style: WhiteHeadingStyle,)
                            ,))):
                  Positioned(
                    top: 0,left: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                          color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                      ),
                      child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                    ),),


                  Positioned(
                    bottom: 0,right: 0,
                    child: Container(
                      width: isMobile? width*0.42:tabWidth*0.42,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleUp,overflow: TextOverflow.ellipsis,),
                                Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleDown,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),

                          Row(
                            children: [

                              Image.asset("assets/view.png",height: 10,color: Colors.white,),
                              const SizedBox(width: 5,),
                              Text("${data.offerData!.offerviewcount!.length}",style: WhiteHeadingStyle,),
                              2.width,
                              SizedBox(
                                  height: 15,width: 5,
                                  child: VerticalDivider(color: Colors.white,thickness: 1,)),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Text(
                                  OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                  ,style: WhiteHeadingStyle,
                                ),
                              )
                            ],)
                        ],
                      ),
                    ),
                  ),
                  data.offerData!.offertemplate == true? Positioned(
                    top: 0,right: 0,
                    child:  Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                      decoration:  BoxDecoration(

                          color: Constants.templateBg
                      ),
                      child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
                    ),):SizedBox(),

                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        maxLines: 3,
                        text:   TextSpan(
                            style:BlackHintStyle,
                            children: [
                              TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                              TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} / ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                            ]
                        )),
                    const SizedBox(height: 3,),

                    // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?
                    data.offerData!.offertemplate == true?SizedBox():
                    data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:0.0),
                      child: Row(
                        children: [

                          Flexible(child: Text(data.offerData!.counterdUser!.isEmpty  || data.offerData!.counterdUser == null || data.offerData!.counterdUser == "null"? "${Url.NoResponded}":"${data.offerData!.counterdUser!.length} ${data.offerData!.counterdUser!.length >= 2? Url.peopleResponded:Url.personResponded}", style: greyHintStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis)),
                          SizedBox(width: 4,),
                          data.offerData!.counterdUser!.isEmpty?SizedBox():
                          Stack(
                            children: [
                              SizedBox(width: 55,),
                              ClipOval(
                                child: Image.network(
                                  "${Url.IMAGE_URL}${data.offerData!.counterdUser![0].image}",
                                  height: 22,
                                  width: 22,
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                                    return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                      height: 22,
                                      width: 22,
                                      fit: BoxFit.fill,);
                                  },),
                              ),
                              data.offerData!.counterdUser!.length >= 2?  Positioned(
                                  left: 7,
                                  top: 0,bottom: 0,
                                  child: ClipOval(
                                    child: Image.network(
                                      "${Url.IMAGE_URL}${data.offerData!.counterdUser![1].image}",
                                      height: 22,
                                      width: 22,
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context, Object exception,
                                          StackTrace? stackTrace) {
                                        return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                          height: 22,
                                          width: 22,
                                          fit: BoxFit.fill,);
                                      },),
                                  )):SizedBox(),
                              data.offerData!.counterdUser!.length >= 3?  Positioned(
                                  left: 15,
                                  top: 0,bottom: 0,
                                  child: ClipOval(
                                    child:
                                    Image.network(
                                      "${Url.IMAGE_URL}${data.offerData!.counterdUser![2].image}",
                                      height: 22,
                                      width: 22,
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context, Object exception,
                                          StackTrace? stackTrace) {
                                        return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                          height: 22,
                                          width: 22,
                                          fit: BoxFit.fill,);
                                      },),
                                  )):SizedBox(),
                              data.offerData!.counterdUser!.length >= 4?   Positioned(
                                  left: 23,
                                  top: 0,bottom: 0,
                                  child: ClipOval(
                                    child:
                                    Image.network(
                                      "${Url.IMAGE_URL}${data.offerData!.counterdUser![3].image}",
                                      height: 22,
                                      width: 22,
                                      fit: BoxFit.fill,
                                      errorBuilder: (BuildContext context, Object exception,
                                          StackTrace? stackTrace) {
                                        return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                          height: 22,
                                          width: 22,
                                          fit: BoxFit.fill,);
                                      },),
                                  )):SizedBox(),
                              data.offerData!.counterdUser!.length >= 5?  Positioned(
                                  left: 22,
                                  top: 0,bottom: 0,
                                  child: CircleAvatar(
                                      backgroundColor: Constants.lightGreen,
                                      child: Center(
                                        child: Text("+${ data.offerData!.counterdUser!.length-4}",style: BlackHintStyle,),
                                      )
                                  )):SizedBox(),
                            ],
                          )

                        ],
                      ),
                    ):
                    isCounterSellBuy == true?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:0.0),
                      child: Text.rich(
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          TextSpan(
                        text:"${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "QUERY" ? "Queried by " : 
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "EXECUTE" ? "Executed by " :
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "SIGN-OFF" ? "Signed off by " : 
                        "${data.offerCounters!.last.counter!.last.tabactivity.toString().capitalize()}" + "ed by ")), 
                              style:greyHintStyle,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: data.offerCounters!.last.counter!.last.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"you": "${data.offerCounters!.last.counter!.last.fromCounter!.displayname.toString()}",
                                  style:grey12500StyleE,
                                ),

                              ]
                          )),
                    ) :SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data.offerData!.like == 0 ?
                        data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()
                            ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                        ):
                        data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                        Builder(
                          builder: (ctx) {
                            return ReactionButton<String>(
                              onReactionChanged: (String? value) {
                                var body = {
                                  "offer_id": data.offerData!.id.toString(),
                                  "user_id" : DataManager.getInstance().getuserId().toString()
                                };
                                DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                                if(value == "like"){
                                  DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                    Constants.showToast("${value["message"]}");
                                    if( value["message"].toString().trim() == "Offer Liked"){
                                      var data2 = OfferDataModelResult(
                                          offerCounters: data.offerCounters,
                                          offerData: MainOfferDetails(
                                              favourite: data.offerData!.favourite,
                                              addres: data.offerData!.addres,
                                              buyORsell:  data.offerData!.buyORsell,
                                              category: data.offerData!.category,
                                              segment: data.offerData!.segment,
                                              subsegment:  data.offerData!.subsegment,
                                              computedRating: data.offerData!.computedRating,
                                              counterdUser: data.offerData!.counterdUser,
                                              createdAt: data.offerData!.createdAt,
                                              id: data.offerData!.id,
                                              modified: data.offerData!.modified,
                                              offerareas: data.offerData!.offerareas,
                                              offerBids: data.offerData!.offerBids,
                                              offerConditions: data.offerData!.offerConditions,
                                              offerconfirmed:  data.offerData!.offerconfirmed,
                                              offercopycount: data.offerData!.offercopycount,
                                              offerevent: data.offerData!.offerevent,
                                              offerexecuteend: data.offerData!.offerexecuteend,
                                              offerexecutestart: data.offerData!.offerexecutestart,
                                              offerfavoritecount: data.offerData!.offerfavoritecount,
                                              offerItems: data.offerData!.offerItems,
                                              offerincepted: data.offerData!.offerincepted,
                                              offerinform: data.offerData!.offerinform,
                                              offerresponses:  data.offerData!.offerresponses,
                                              offerservicepercentage: data.offerData!.offerservicepercentage,
                                              offersignedoff:data.offerData!.offersignedoff,
                                              offerstatus:  data.offerData!.offerstatus,
                                              offertemplate: data.offerData!.offertemplate,
                                              offerviewcount: data.offerData!.offerviewcount,
                                              privacy: data.offerData!.privacy,
                                              subscribers:data.offerData!.subscribers,
                                              tabactivity: data.offerData!.tabactivity,
                                              userRating: data.offerData!.userRating,
                                              like: 1,
                                              offerLike: data.offerData!.offerLike!+1,
                                              offerDisLike: data.offerData!.offerDisLike,
                                              comments: data.offerData!.comments,
                                              ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                          )
                                      );
                                      offerList[index] = data2;
                                    }
                                  });
                                }else{
                                  DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                    Constants.showToast("${value["message"]}");
                                    if( value["message"].toString().trim() == "Offer Disliked"){
                                      var data2 = OfferDataModelResult(
                                          offerCounters: data.offerCounters,
                                          offerData: MainOfferDetails(
                                              favourite: data.offerData!.favourite,
                                              addres: data.offerData!.addres,
                                              buyORsell:  data.offerData!.buyORsell,
                                              category: data.offerData!.category,
                                              segment: data.offerData!.segment,
                                              subsegment:  data.offerData!.subsegment,
                                              computedRating: data.offerData!.computedRating,
                                              counterdUser: data.offerData!.counterdUser,
                                              createdAt: data.offerData!.createdAt,
                                              id: data.offerData!.id,
                                              modified: data.offerData!.modified,
                                              offerareas: data.offerData!.offerareas,
                                              offerBids: data.offerData!.offerBids,
                                              offerConditions: data.offerData!.offerConditions,
                                              offerconfirmed:  data.offerData!.offerconfirmed,
                                              offercopycount: data.offerData!.offercopycount,
                                              offerevent: data.offerData!.offerevent,
                                              offerexecuteend: data.offerData!.offerexecuteend,
                                              offerexecutestart: data.offerData!.offerexecutestart,
                                              offerfavoritecount: data.offerData!.offerfavoritecount,
                                              offerItems: data.offerData!.offerItems,
                                              offerincepted: data.offerData!.offerincepted,
                                              offerinform: data.offerData!.offerinform,
                                              offerresponses:  data.offerData!.offerresponses,
                                              offerservicepercentage: data.offerData!.offerservicepercentage,
                                              offersignedoff:data.offerData!.offersignedoff,
                                              offerstatus:  data.offerData!.offerstatus,
                                              offertemplate: data.offerData!.offertemplate,
                                              offerviewcount: data.offerData!.offerviewcount,
                                              privacy: data.offerData!.privacy,
                                              subscribers:data.offerData!.subscribers,
                                              tabactivity: data.offerData!.tabactivity,
                                              userRating: data.offerData!.userRating,
                                              like: 2,
                                              offerLike: data.offerData!.offerLike,
                                              offerDisLike:data.offerData!.offerDisLike!+1,
                                              comments: data.offerData!.comments,
                                              ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                          )
                                      );
                                      offerList[index]= data2;
                                    }
                                  });
                                }
                              },
                              reactions: flagsReactions,
                              initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                                value: null,
                                icon:  Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Icon(
                                    Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                                  ),
                                ),
                              ): Reaction<String>(
                                value: 'like',
                                icon:Icon(
                                  Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                                ),
                              ),
                              boxColor:Colors.amber.shade300 ,
                              boxRadius: 10,
                              boxElevation: 0,
                              boxDuration: const Duration(milliseconds: 200),
                              itemScaleDuration: const Duration(milliseconds: 100),
                            );
                          },
                        ): Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                        )
                            :Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
                        ),

                        (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,left: 2),
                          child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                          "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                        ),

                        Spacer(),
                        InkWell(
                            onTap:(){
                              var body = {
                                "offer_id": data.offerData!.id.toString(),
                                "user_id" : DataManager.getInstance().getuserId().toString()
                              };
                              DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                              DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                                if( value["message"].toString().trim() == "offer removed from favourite"){
                                  Constants.showToast("${Url.UnMarkFav}");
                                  var data2 = OfferDataModelResult(
                                      offerCounters: data.offerCounters,
                                      offerData: MainOfferDetails(
                                          addres: data.offerData!.addres,
                                          buyORsell:  data.offerData!.buyORsell,
                                          category: data.offerData!.category,
                                          segment: data.offerData!.segment,
                                          subsegment:  data.offerData!.subsegment,
                                          computedRating: data.offerData!.computedRating,
                                          counterdUser: data.offerData!.counterdUser,
                                          createdAt: data.offerData!.createdAt,
                                          id: data.offerData!.id,
                                          modified: data.offerData!.modified,
                                          offerareas: data.offerData!.offerareas,
                                          offerBids: data.offerData!.offerBids,
                                          offerConditions: data.offerData!.offerConditions,
                                          offerconfirmed:  data.offerData!.offerconfirmed,
                                          offercopycount: data.offerData!.offercopycount,
                                          offerevent: data.offerData!.offerevent,
                                          offerexecuteend: data.offerData!.offerexecuteend,
                                          offerexecutestart: data.offerData!.offerexecutestart,
                                          offerItems: data.offerData!.offerItems,
                                          offerincepted: data.offerData!.offerincepted,
                                          offerinform: data.offerData!.offerinform,
                                          offerresponses:  data.offerData!.offerresponses,
                                          offerservicepercentage: data.offerData!.offerservicepercentage,
                                          offersignedoff:data.offerData!.offersignedoff,
                                          offerstatus:  data.offerData!.offerstatus,
                                          offertemplate: data.offerData!.offertemplate,
                                          offerviewcount: data.offerData!.offerviewcount,
                                          privacy: data.offerData!.privacy,
                                          subscribers:data.offerData!.subscribers,
                                          tabactivity: data.offerData!.tabactivity,
                                          userRating: data.offerData!.userRating,
                                          favourite: false,
                                          offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                                          like: data.offerData!.like,
                                          offerLike: data.offerData!.offerLike,
                                          offerDisLike: data.offerData!.offerDisLike,
                                          comments: data.offerData!.comments,
                                          ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                      )
                                  );
                                  offerList[index]= data2;
                                }else{
                                  Constants.showToast("${Url.markFav}");
                                  var data2 = OfferDataModelResult(
                                      offerCounters: data.offerCounters,
                                      offerData: MainOfferDetails(
                                          addres: data.offerData!.addres,
                                          buyORsell:  data.offerData!.buyORsell,
                                          category: data.offerData!.category,
                                          segment: data.offerData!.segment,
                                          subsegment:  data.offerData!.subsegment,
                                          computedRating: data.offerData!.computedRating,
                                          counterdUser: data.offerData!.counterdUser,
                                          createdAt: data.offerData!.createdAt,
                                          id: data.offerData!.id,
                                          modified: data.offerData!.modified,
                                          offerareas: data.offerData!.offerareas,
                                          offerBids: data.offerData!.offerBids,
                                          offerConditions: data.offerData!.offerConditions,
                                          offerconfirmed:  data.offerData!.offerconfirmed,
                                          offercopycount: data.offerData!.offercopycount,
                                          offerevent: data.offerData!.offerevent,
                                          offerexecuteend: data.offerData!.offerexecuteend,
                                          offerexecutestart: data.offerData!.offerexecutestart,
                                          offerItems: data.offerData!.offerItems,
                                          offerincepted: data.offerData!.offerincepted,
                                          offerinform: data.offerData!.offerinform,
                                          offerresponses:  data.offerData!.offerresponses,
                                          offerservicepercentage: data.offerData!.offerservicepercentage,
                                          offersignedoff:data.offerData!.offersignedoff,
                                          offerstatus:  data.offerData!.offerstatus,
                                          offertemplate: data.offerData!.offertemplate,
                                          offerviewcount: data.offerData!.offerviewcount,
                                          privacy: data.offerData!.privacy,
                                          subscribers:data.offerData!.subscribers,
                                          tabactivity: data.offerData!.tabactivity,
                                          userRating: data.offerData!.userRating,
                                          favourite: true,
                                          offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                                          like: data.offerData!.like,
                                          offerLike: data.offerData!.offerLike,
                                          offerDisLike: data.offerData!.offerDisLike,
                                          comments: data.offerData!.comments,
                                          ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                      )
                                  );
                                  offerList[index]= data2;
                                }
                              });
                            },
                            child: data.offerData!.favourite == true ? Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 18,),
                            ):Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0,top: 5),
                          child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                        ),
                        //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                        // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                        // InkWell(
                        //     onTap:(){
                        //       var body = {
                        //         "offer_id": data.offerData!.id.toString(),
                        //         "user_id" : DataManager.getInstance().getuserId().toString()
                        //       };
                        //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                        //       bool isCommentsLoading = true;
                        //       List<CommentsDataList> CommentsList = [];
                        //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                        //         CommentsList = value;
                        //         isCommentsLoading = false;
                        //       });
                        //       showModalBottomSheet(
                        //         isScrollControlled: true,
                        //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                        //         context: context, builder: (context) {
                        //         return  StatefulBuilder(builder: (context, modalState) {
                        //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                        //             modalState((){});
                        //
                        //           },):null;
                        //           return Container(
                        //               height: MediaQuery.of(context).size.height*0.8,
                        //               width:isMobile?width:tabWidth,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                        //                 color:Color(0x33DCF0DD),
                        //               ),
                        //               child: Scaffold(
                        //                 backgroundColor: Colors.transparent,
                        //                 body: Column(
                        //                   mainAxisAlignment: MainAxisAlignment.start,
                        //                   crossAxisAlignment: CrossAxisAlignment.center,
                        //                   children: [
                        //                     Container(
                        //                         height: 3.5,
                        //                         margin: EdgeInsets.only(top: 13),
                        //                         width: 38,
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.circular(5),
                        //                           color: Colors.black54,
                        //                         )),
                        //                     20.height,
                        //                     Text("Comments",style:BlackSubTitleStyle,),
                        //                     10.height,
                        //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                        //                     2.height,
                        //                     // isCommentsLoading?
                        //                     // Padding(
                        //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                        //                     //   child: LoadingWidget(),
                        //                     // )
                        //                     //     :
                        //                     //
                        //                     // CommentsList.isEmpty?
                        //                     // Padding(
                        //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                        //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                        //                     // )
                        //                     //     : Expanded(
                        //                     //   child: ListView.builder(
                        //                     //     controller: scrollCommentsController,
                        //                     //     itemCount: CommentsList.length,
                        //                     //     padding: EdgeInsets.only(bottom: 100),
                        //                     //     itemBuilder: (context, i) {
                        //                     //       var CommentsData = CommentsList[i];
                        //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                        //                     //       final currentTime = DateTime.now();
                        //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                        //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                        //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                        //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                        //                     //       return Row(
                        //                     //         mainAxisAlignment: MainAxisAlignment.start,
                        //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                        //                     //         children: [
                        //                     //           Container(
                        //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                        //                     //             height: 40,
                        //                     //             width: 40,
                        //                     //             decoration: BoxDecoration(
                        //                     //                 shape: BoxShape.circle,
                        //                     //                 image:
                        //                     //                 CommentsData.user!.profilePicture == null ||
                        //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                        //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                        //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                        //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                        //                     //             ),
                        //                     //           ),
                        //                     //           Flexible(
                        //                     //             child: Container(
                        //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                        //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        //                     //               decoration: BoxDecoration(
                        //                     //                 borderRadius: BorderRadius.circular(7),
                        //                     //                 color: Constants.white,
                        //                     //               ),
                        //                     //               child: Column(
                        //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                        //                     //                 children: [
                        //                     //                   Row(
                        //                     //                     children: [
                        //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                        //                     //                       10.width,
                        //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                        //                     //                     ],
                        //                     //                   ),
                        //                     //
                        //                     //                   Padding(
                        //                     //                     padding: const EdgeInsets.only(top: 2.0),
                        //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                        //                     //                   ),
                        //                     //                 ],
                        //                     //               ),
                        //                     //             ),
                        //                     //           ),
                        //                     //         ],
                        //                     //       );
                        //                     //     },),
                        //                     // ),
                        //                   ],
                        //                 ),
                        //                 bottomSheet:Container(
                        //
                        //                   decoration: BoxDecoration(
                        //                       color: Color(0x33DCF0DD),
                        //
                        //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                        //                   ),
                        //                   child: Row(
                        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                     crossAxisAlignment: CrossAxisAlignment.center,
                        //                     children: [
                        //
                        //                       10.width,
                        //                       Container(
                        //                         height: 35,
                        //                         width: 35,
                        //                         margin: const EdgeInsets.only(bottom: 5),
                        //                         padding: EdgeInsets.zero,
                        //                         decoration: BoxDecoration(
                        //                             borderRadius: BorderRadius.circular(5),
                        //                             color: Constants.greyDark
                        //                         ),
                        //                         child: Center(child: Container(
                        //                           height: 35,width: 35,
                        //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                        //                             // border: Border.all(color: Constants.white,width: 4),
                        //                               shape: BoxShape.circle,
                        //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                        //                           ):  BoxDecoration(
                        //                               border: Border.all(color: Constants.white,width: 2),
                        //                               shape: BoxShape.circle,
                        //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                        //                           ),
                        //                         )),
                        //                       ),
                        //
                        //                       Flexible(
                        //                         child: TextFormField(
                        //                           controller: messageController,
                        //                           keyboardType: TextInputType.text,
                        //                           // maxLines: ,
                        //                           onChanged: (value){
                        //                             setState(() {
                        //
                        //                             });
                        //                             modalState((){});
                        //                           },
                        //                           autofocus: false,
                        //                           focusNode: focusNode,
                        //                           // style: black14500,
                        //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                        //                           decoration: InputDecoration(
                        //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                        //                             hintText: "Write your comments",
                        //                             hintStyle: greySubTitleItalicStyle,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       messageController.text.isEmpty?SizedBox():InkWell(
                        //                         onTap: (){
                        //                           // messageController.clear();
                        //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                        //                             if(value["status"] == "200"){
                        //                               var CommentRes =  CommentsDataList(
                        //                                 id: value["result"]["id"],
                        //                                 user:CommentsUser(
                        //                                     id: value["result"]["user"]["id"],
                        //                                     displayname:  value["result"]["user"]["displayname"],
                        //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                        //                                     username:  value["result"]["user"]["username"]
                        //                                 ),
                        //                                 offer: value["result"]["offer"],
                        //                                 comment: value["result"]["comment"],
                        //                                 createdAt: value["result"]["created_at"],
                        //                                 updatedAt: value["result"]["updated_at"],
                        //                               );
                        //                               modalState((){
                        //                                 CommentsList.add(CommentRes);
                        //                                 messageController.clear();
                        //                                 scrollToBottom();
                        //                               });
                        //                             }
                        //                           });
                        //                         },
                        //                         child: Container(
                        //                           margin: EdgeInsets.only(right: 10),
                        //                           height: 40,
                        //                           width: 40,
                        //                           decoration: BoxDecoration(
                        //                               shape: BoxShape.circle,
                        //                               border: Border.all(color: Constants.greyLight,width: 1),
                        //                               color:Constants.primaryColor
                        //                           ),
                        //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //                 // Column(
                        //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                        //                 //   mainAxisSize: MainAxisSize.max,
                        //                 //   mainAxisAlignment: MainAxisAlignment.end,
                        //                 //   children: [
                        //                 //     Container(
                        //                 //       height: 50,
                        //                 //       decoration: BoxDecoration(
                        //                 //         color: Color(
                        //                 //             0x1ABCDFF8),
                        //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                        //                 //       ),
                        //                 //       child: Row(
                        //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 //         children: [
                        //                 //
                        //                 //           const SizedBox(width: 7,),
                        //                 //           isemojiShowing == false?
                        //                 //           InkWell(
                        //                 //               onTap: (){
                        //                 //                 // controller.focusNode.value.unfocus();
                        //                 //                 // controller.focusNode.value.canRequestFocus=false;
                        //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                        //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                        //                 //                 //   // controller.focusNode.value.requestFocus();
                        //                 //                 //   // controller.filepick.value = false;
                        //                 //                 //   // controller.showStickers.value = false;
                        //                 //                 //   // controller.showAttachmentButtons.value = false;
                        //                 //                 // },);
                        //                 //                 //
                        //                 //                 // controller.filepick.value = false;
                        //                 //                 // // if ( controller.emojiShowing.value != false) {
                        //                 //                 // //   FocusScope.of(context).unfocus();
                        //                 //                 // // }
                        //                 //               },
                        //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                        //                 //           InkWell(
                        //                 //             onTap: () {
                        //                 //               // controller.focusNode.value.requestFocus();
                        //                 //               // controller.emojiShowing.value = false;
                        //                 //               // controller.filepick.value = false;
                        //                 //               // controller.showStickers.value = false;
                        //                 //               // controller.showAttachmentButtons.value = false;
                        //                 //
                        //                 //             },
                        //                 //             child: const Padding(
                        //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                        //                 //               child: Icon(
                        //                 //                 Icons.keyboard,
                        //                 //                 color: Colors.black45,size: 22,
                        //                 //               ),
                        //                 //             ),
                        //                 //           ),
                        //                 //           Flexible(
                        //                 //             child: TextFormField(
                        //                 //               controller: messageController,
                        //                 //               onChanged: (value){
                        //                 //
                        //                 //               },
                        //                 //               autofocus: false,
                        //                 //               focusNode: focusNode,
                        //                 //               // style: black14500,
                        //                 //               cursorColor: Colors.black,
                        //                 //               onTap: (){
                        //                 //                 isemojiShowing = false;
                        //                 //               },
                        //                 //               decoration: InputDecoration(
                        //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                        //                 //                 hintText: "Write your comments",
                        //                 //                 hintStyle: grey14400,
                        //                 //               ),
                        //                 //             ),
                        //                 //           ),
                        //                 //
                        //                 //         ],
                        //                 //       ),
                        //                 //     ),
                        //                 //     Offstage(
                        //                 //       offstage: isemojiShowing,
                        //                 //       child: SizedBox(
                        //                 //         height: 240,
                        //                 //         child: emg.EmojiPicker(
                        //                 //
                        //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                        //                 //             onEmojiSelected(emoji);
                        //                 //             messageChecker = emoji.toString();
                        //                 //           },
                        //                 //           onBackspacePressed: onBackspacePressed,
                        //                 //           config: emg.Config(
                        //                 //             columns: 9,
                        //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                        //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                        //                 //             verticalSpacing: 0,
                        //                 //             horizontalSpacing: 0,
                        //                 //             gridPadding: EdgeInsets.zero,
                        //                 //             initCategory: emg.Category.RECENT,
                        //                 //             bgColor: const Color(0xFFF2F2F2),
                        //                 //             indicatorColor: Constants.primaryColor,
                        //                 //             iconColor: Colors.grey,
                        //                 //             iconColorSelected:  Constants.primaryColor,
                        //                 //             backspaceColor:  Constants.primaryColor,
                        //                 //             skinToneDialogBgColor: Colors.white,
                        //                 //             skinToneIndicatorColor: Colors.grey,
                        //                 //             enableSkinTones: true,
                        //                 //             // showRecentsTab: true,
                        //                 //             recentsLimit: 28,
                        //                 //             replaceEmojiOnLimitExceed: false,
                        //                 //             noRecents: const Text(
                        //                 //               'No Recent',
                        //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                        //                 //               textAlign: TextAlign.center,
                        //                 //             ),
                        //                 //             loadingIndicator: const SizedBox.shrink(),
                        //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                        //                 //             categoryIcons: const emg.CategoryIcons(),
                        //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                        //                 //             checkPlatformCompatibility: true,
                        //                 //           ),
                        //                 //         ),
                        //                 //       ),
                        //                 //     ),
                        //                 //   ],
                        //                 // ),
                        //               )
                        //           );
                        //         },);
                        //
                        //       },).then((value) {
                        //
                        //       });
                        //     },
                        //     child: Image.asset("assets/comment.png",height: 18,)),
                        // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 3.0),
                        //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                        // ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                          child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                        ),
                      ],
                    ),
                    isCounterSellBuy == true ?
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:0.0),
                      child: Text.rich(
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          TextSpan(
                        text:"${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "QUERY" ? "Queried by " : 
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "EXECUTE" ? "Executed by " :
                        ("${data.offerCounters!.last.counter!.last.tabactivity.toString()}" == "SIGN-OFF" ? "Signed off by " : 
                        "${data.offerCounters!.last.counter!.last.tabactivity.toString().capitalize()}" + "ed by ")), 
                          style:greyHintStyle,
                          children: <InlineSpan>[
                            TextSpan(
                              text: data.offerCounters!.first.counter!.last.fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"you": "${data.offerCounters!.first.counter!.last.fromCounter!.displayname.toString()}",
                              style:grey12500StyleE,
                            ),

                          ]
                      )),
                    ) :
                    SizedBox(),

                    // isCounterSellBuy == true ?
                    // data.offerCounters!.first.counter!.length <= 1 ?SizedBox():
                    // Text.rich(
                    //   maxLines: 1,
                    //     TextSpan(
                    //     text:"${data.offerCounters!.first.counter![1].tabactivity}  by  ",
                    //     style:greyHintStyle,
                    //     children: <InlineSpan>[
                    //       TextSpan(
                    //         text: data.offerCounters!.first.counter![1].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![1].fromCounter!.username.toString()}",
                    //         style:grey12500StyleE,
                    //       ),
                    //       TextSpan(
                    //         text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                    //         style:grey12500StyleE,
                    //       ),
                    //     ]
                    // ))
                    //     : SizedBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED" ?
      isConfirmingUser ? SizedBox():
      Positioned(
        top: 0,bottom: 0,left: 0,right: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: isMobile? width:tabWidth,
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            height: isMobile == false?tabHeight*0.40: height*0.20,

            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(8),
              color: Constants.closeOfferCard,
            ),
          ),
        ),
      ) :isAllItemDone1.contains(false)?SizedBox():
      isConfirmingUser ? SizedBox():
      Positioned(
        top: 0,bottom: 0,left: 0,right: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: isMobile? width*0.49:tabWidth*0.49,
            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(8),
              color: Constants.closeOfferCard,
            ),
          ),
        ),
      ),
      data.offerData!.offerstatus.toString().trim().toUpperCase() != "CLOSED" ? SizedBox(): data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId() || isCounterSellBuy?
      Positioned(
        top:10,right: 15,
        child: InkWell(
          onTap: (){
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                bool butttonLoader = false;
                return StatefulBuilder(builder: (context, ModalState) {
                  return Dialog(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      elevation: 16,
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        children: [
                          Image.asset("assets/delete.png",height: 50,width: 50,color: Colors.black,),
                          Padding(
                            padding: EdgeInsets.only(top:10,bottom: 10),
                            child: Text('DELETE OFFER!',style: BlackFieldStyleBold,textAlign: TextAlign.center),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text("ARE YOU SURE TO DELETE?",style: Black87HintStyle,textAlign: TextAlign.center),
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
                                    fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
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
                                    var body = {
                                      "offer_id": data.offerData!.id.toString()
                                    };
                                    DrawAuraAPi.CreateDataApi(body: body ,ApiEndPoint: "deleteOffer").then((value) {
                                      ModalState(() {
                                        butttonLoader= false;
                                      });
                                      Navigator.pop(context);
                                      if(value["status"] == 200){
                                        Constants.showToast(value["message"]);
                                        ModalState((){
                                          offerList.removeAt(index);
                                        });

                                      }else{
                                        Constants.showToast(value["message"]);
                                      }

                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.primaryColor1,
                                    fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                  child: butttonLoader == true ? SizedBox(height: 24,width: 24,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)): Text("Yes",style:WhiteButtonStyle,)),
                            ],
                          ),
                        ],
                      )
                  );
                },);
              },
            );
          },
          child: CircleAvatar(
              radius: 13,backgroundColor: Colors.grey.shade800,
              child: Image.asset("assets/delete.png",height: 18,color: Colors.white,)),
        ),
      ):SizedBox(),
      Positioned(
          bottom:5,right: 10,
          child: privetPublicLogoNew(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
      ),
    ],
  );

}


CommonTemplateCardListView(
    context,OfferDataModelResult  data,
    AsyncSnapshot<String> snapshot,
    bool isCounterSellBuy,
    List<OfferDataModelResult> offerList,
    int index,
    Callback onTap,
    bool isYourOffer
    ){
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var tabWidth = ResponsiveHelper.TabModeWidth;
  var tabHeight = ResponsiveHelper.TabModeHeight;
  var isMobile= ResponsiveHelper.isMobile(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
    child: Stack(
      children: [
        Container(

          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(8),
            border: Border.all(color: Constants.greyLight,width: 1),),
          width: isMobile? width:tabWidth,
          height: isMobile == false?tabHeight*0.38: height*0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                onLongPress: (){
                  LongPressForDelete(context,data,offerList: offerList,index: index);
                },
                child: Stack(
                  children: [
                    Container(
                      width: isMobile? width*0.42:tabWidth*0.42,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                          image:data.offerData!.offerItems![0].itemMedia!.isEmpty?const
                          DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.cover):
                          "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                          snapshot.connectionState == ConnectionState.waiting?
                          DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                              :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                          DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems![0].itemMedia![0].file}"), fit: BoxFit.fill)), ),

                    isYourOffer ?
                    Positioned(
                        top: 0,
                        left: 0,
                        child: data.offerData!.buyORsell == "SELL" || data.offerData!.buyORsell == "BUY" ?
                        Container(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell == "SELL" ? Colors.red : Constants.primaryColor1),
                          child: Center(
                              child: Text("${data.offerData!.buyORsell.toString()}",
                                style: WhiteHeadingStyle,
                                textAlign: TextAlign.center,
                              )),
                        )
                            : data.offerData!.buyORsell == "DELIVER_BUY" || data.offerData!.buyORsell == "DELIVER_SELL"
                            ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell == "DELIVER_SELL" ? Colors.red : Constants.primaryColor1),
                          child: Center(
                              child: Text("${data.offerData!.buyORsell.toString()}",
                                style: WhiteHeadingStyle,
                                textAlign: TextAlign.center,
                              )),
                        )
                            : Container(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8)),
                              color: data.offerData!.buyORsell == "COUNTER SELL" ? Constants.primaryColor1 : Colors.red),
                          child: Center(
                              child: Text("${data.offerData!.buyORsell == "COUNTER SELL" ? "COUNTER BUY" : "COUNTER SELL"}",
                                style: WhiteHeadingStyle,
                                textAlign: TextAlign.center,
                              )),
                        ))
                        :

                    data.offerData!.buyORsell.toString() =="DELIVER_SELL" || data.offerData!.buyORsell.toString() =="DELIVER_BUY" ?
                    data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                    Positioned(
                        top: 0,left: 0,
                        child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"? Constants.redColor:Constants.primaryColor1
                            ),
                            child: Center(child: Text(" ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                              ,))):
                    Positioned(
                        top: 0,left: 0,
                        child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                color: data.offerData!.buyORsell.toString() =="DELIVER_SELL"?Constants.primaryColor1: Constants.redColor
                            ),
                            child: Center(child: Text( " ${data.offerData!.buyORsell.toString() == "DELIVER_SELL"?"DELIVER_BUY":"DELIVER_SELL"}",style: WhiteHeadingStyle,)
                              ,))):
                    isCounterSellBuy == true ?
                    data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?
                    Positioned(
                        top: 0,left: 0,
                        child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                            ),
                            child: Center(child: Text("COUNTER ${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                              ,))):
                    Positioned(
                        top: 0,left: 0,
                        child:  Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                color: data.offerData!.buyORsell.toString() =="SELL"?Constants.primaryColor1: Constants.redColor
                            ),
                            child: Center(child: Text( "COUNTER ${data.offerData!.buyORsell.toString() == "BUY"?"SELL":"BUY"}",style: WhiteHeadingStyle,)
                              ,))):
                    Positioned(
                      top: 0,left: 0,
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                        decoration:  BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                            color: data.offerData!.buyORsell.toString() =="SELL"? Constants.redColor:Constants.primaryColor1
                        ),
                        child: Center(child: Text( "${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)),
                      ),),


                    Positioned(
                      bottom: 0,right: 0,
                      child: Container(
                        width: isMobile? width*0.42:tabWidth*0.42,

                        decoration: BoxDecoration(
                            color: Colors.black45,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Stack(
                                children: [
                                  Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleUp,overflow: TextOverflow.ellipsis,),
                                  Text(data.offerData!.subscribers!.displayname.toString() == "null" ?"":"${data.offerData!.subscribers!.displayname.toString()}",style: CardUserNameStyleDown,overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),

                            Row(
                              children: [

                                Image.asset("assets/view.png",height: 10,color: Colors.white,),
                                const SizedBox(width: 5,),
                                Text("${data.offerData!.offerviewcount!.length}",style: WhiteHeadingStyle,),
                                2.width,
                                SizedBox(
                                    height: 15,width: 5,
                                    child: VerticalDivider(color: Colors.white,thickness: 1,)),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 4.0),
                                //   child: Image.asset("assets/time.png",height: 12,color: Colors.white,),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                    ,style: WhiteHeadingStyle,
                                  ),
                                )
                              ],)
                          ],
                        ),
                      ),
                    ),
                    data.offerData!.offertemplate == true? Positioned(
                      top: 0,right: 0,
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        decoration:  BoxDecoration(

                            color: Constants.templateBg
                        ),
                        child: Center(child: Text("TEMPLATE",style: WhiteHeadingStyle,)),
                      ),):SizedBox(),

                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          maxLines: 3,
                          text:   TextSpan(
                              style:BlackHintStyle,
                              children: [
                                TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackCardTitle),
                                TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} / ${data.offerData!.offerItems!.first.unit!.name.toString()}",style:BlackSubCardTitle,),
                              ]
                          )),
                      const SizedBox(height: 3,),

                      // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim()?SizedBox():   isCounterSellBuy == false?

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.offerData!.like == 0 ?
                          data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()
                              ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                          ):
                          data.offerData!.offerviewcount!.contains(num.parse(DataManager.getInstance().getuserId().toString()))?
                          Builder(
                            builder: (ctx) {
                              return ReactionButton<String>(
                                onReactionChanged: (String? value) {
                                  var body = {
                                    "offer_id": data.offerData!.id.toString(),
                                    "user_id" : DataManager.getInstance().getuserId().toString()
                                  };
                                  DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                                  if(value == "like"){
                                    DrawAuraAPi.likeUnlikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                      Constants.showToast("${value["message"]}");
                                      if( value["message"].toString().trim() == "Offer Liked"){
                                        var data2 = OfferDataModelResult(
                                            offerCounters: data.offerCounters,
                                            offerData: MainOfferDetails(
                                                favourite: data.offerData!.favourite,
                                                addres: data.offerData!.addres,
                                                buyORsell:  data.offerData!.buyORsell,
                                                category: data.offerData!.category,
                                                segment: data.offerData!.segment,
                                                subsegment:  data.offerData!.subsegment,
                                                computedRating: data.offerData!.computedRating,
                                                counterdUser: data.offerData!.counterdUser,
                                                createdAt: data.offerData!.createdAt,
                                                id: data.offerData!.id,
                                                modified: data.offerData!.modified,
                                                offerareas: data.offerData!.offerareas,
                                                offerBids: data.offerData!.offerBids,
                                                offerConditions: data.offerData!.offerConditions,
                                                offerconfirmed:  data.offerData!.offerconfirmed,
                                                offercopycount: data.offerData!.offercopycount,
                                                offerevent: data.offerData!.offerevent,
                                                offerexecuteend: data.offerData!.offerexecuteend,
                                                offerexecutestart: data.offerData!.offerexecutestart,
                                                offerfavoritecount: data.offerData!.offerfavoritecount,
                                                offerItems: data.offerData!.offerItems,
                                                offerincepted: data.offerData!.offerincepted,
                                                offerinform: data.offerData!.offerinform,
                                                offerresponses:  data.offerData!.offerresponses,
                                                offerservicepercentage: data.offerData!.offerservicepercentage,
                                                offersignedoff:data.offerData!.offersignedoff,
                                                offerstatus:  data.offerData!.offerstatus,
                                                offertemplate: data.offerData!.offertemplate,
                                                offerviewcount: data.offerData!.offerviewcount,
                                                privacy: data.offerData!.privacy,
                                                subscribers:data.offerData!.subscribers,
                                                tabactivity: data.offerData!.tabactivity,
                                                userRating: data.offerData!.userRating,
                                                like: 1,
                                                offerLike: data.offerData!.offerLike!+1,
                                                offerDisLike: data.offerData!.offerDisLike,
                                                comments: data.offerData!.comments,
                                                ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                            )
                                        );
                                        offerList[index]= data2;
                                      }
                                    });
                                  }else{
                                    DrawAuraAPi.disLikeOffer(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {

                                      Constants.showToast("${value["message"]}");
                                      if( value["message"].toString().trim() == "Offer Disliked"){
                                        var data2 = OfferDataModelResult(
                                            offerCounters: data.offerCounters,
                                            offerData: MainOfferDetails(
                                                favourite: data.offerData!.favourite,
                                                addres: data.offerData!.addres,
                                                buyORsell:  data.offerData!.buyORsell,
                                                category: data.offerData!.category,
                                                segment: data.offerData!.segment,
                                                subsegment:  data.offerData!.subsegment,
                                                computedRating: data.offerData!.computedRating,
                                                counterdUser: data.offerData!.counterdUser,
                                                createdAt: data.offerData!.createdAt,
                                                id: data.offerData!.id,
                                                modified: data.offerData!.modified,
                                                offerareas: data.offerData!.offerareas,
                                                offerBids: data.offerData!.offerBids,
                                                offerConditions: data.offerData!.offerConditions,
                                                offerconfirmed:  data.offerData!.offerconfirmed,
                                                offercopycount: data.offerData!.offercopycount,
                                                offerevent: data.offerData!.offerevent,
                                                offerexecuteend: data.offerData!.offerexecuteend,
                                                offerexecutestart: data.offerData!.offerexecutestart,
                                                offerfavoritecount: data.offerData!.offerfavoritecount,
                                                offerItems: data.offerData!.offerItems,
                                                offerincepted: data.offerData!.offerincepted,
                                                offerinform: data.offerData!.offerinform,
                                                offerresponses:  data.offerData!.offerresponses,
                                                offerservicepercentage: data.offerData!.offerservicepercentage,
                                                offersignedoff:data.offerData!.offersignedoff,
                                                offerstatus:  data.offerData!.offerstatus,
                                                offertemplate: data.offerData!.offertemplate,
                                                offerviewcount: data.offerData!.offerviewcount,
                                                privacy: data.offerData!.privacy,
                                                subscribers:data.offerData!.subscribers,
                                                tabactivity: data.offerData!.tabactivity,
                                                userRating: data.offerData!.userRating,
                                                like: 2,
                                                offerLike: data.offerData!.offerLike,
                                                offerDisLike:data.offerData!.offerDisLike!+1,
                                                comments: data.offerData!.comments,
                                                ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                            )
                                        );
                                        offerList[index]= data2;
                                      }
                                    });
                                  }
                                },
                                reactions: flagsReactions,
                                initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                                  value: null,
                                  icon:  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.thumb_up_outlined,color: Colors.black87,size: 18,
                                    ),
                                  ),
                                ): Reaction<String>(
                                  value: 'like',
                                  icon:Icon(
                                    Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18,
                                  ),
                                ),
                                boxColor:Colors.amber.shade300 ,
                                boxRadius: 10,
                                boxElevation: 0,
                                boxDuration: const Duration(milliseconds: 200),
                                itemScaleDuration: const Duration(milliseconds: 100),
                              );
                            },
                          ): Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.thumb_up_outlined,color: Colors.black87,size: 16,),
                          )
                              :Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 16),
                          ),

                          (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0,left: 2),
                            child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                            "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                          ),

                          Spacer(),
                          InkWell(
                              onTap:(){
                                var body = {
                                  "offer_id": data.offerData!.id.toString(),
                                  "user_id" : DataManager.getInstance().getuserId().toString()
                                };
                                DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                                DrawAuraAPi.AddRemoveFavorite(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString()).then((value) {
                                  if( value["message"].toString().trim() == "offer removed from favourite"){
                                    Constants.showToast("${Url.UnMarkFav}");
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            favourite: false,
                                            offerfavoritecount: data.offerData!.offerfavoritecount!-1,
                                            like: data.offerData!.like,
                                            offerLike: data.offerData!.offerLike,
                                            offerDisLike: data.offerData!.offerDisLike,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }else{
                                    Constants.showToast("${Url.markFav}");
                                    var data2 = OfferDataModelResult(
                                        offerCounters: data.offerCounters,
                                        offerData: MainOfferDetails(
                                            addres: data.offerData!.addres,
                                            buyORsell:  data.offerData!.buyORsell,
                                            category: data.offerData!.category,
                                            segment: data.offerData!.segment,
                                            subsegment:  data.offerData!.subsegment,
                                            computedRating: data.offerData!.computedRating,
                                            counterdUser: data.offerData!.counterdUser,
                                            createdAt: data.offerData!.createdAt,
                                            id: data.offerData!.id,
                                            modified: data.offerData!.modified,
                                            offerareas: data.offerData!.offerareas,
                                            offerBids: data.offerData!.offerBids,
                                            offerConditions: data.offerData!.offerConditions,
                                            offerconfirmed:  data.offerData!.offerconfirmed,
                                            offercopycount: data.offerData!.offercopycount,
                                            offerevent: data.offerData!.offerevent,
                                            offerexecuteend: data.offerData!.offerexecuteend,
                                            offerexecutestart: data.offerData!.offerexecutestart,
                                            offerItems: data.offerData!.offerItems,
                                            offerincepted: data.offerData!.offerincepted,
                                            offerinform: data.offerData!.offerinform,
                                            offerresponses:  data.offerData!.offerresponses,
                                            offerservicepercentage: data.offerData!.offerservicepercentage,
                                            offersignedoff:data.offerData!.offersignedoff,
                                            offerstatus:  data.offerData!.offerstatus,
                                            offertemplate: data.offerData!.offertemplate,
                                            offerviewcount: data.offerData!.offerviewcount,
                                            privacy: data.offerData!.privacy,
                                            subscribers:data.offerData!.subscribers,
                                            tabactivity: data.offerData!.tabactivity,
                                            userRating: data.offerData!.userRating,
                                            favourite: true,
                                            offerfavoritecount: data.offerData!.offerfavoritecount!+1,
                                            like: data.offerData!.like,
                                            offerLike: data.offerData!.offerLike,
                                            offerDisLike: data.offerData!.offerDisLike,
                                            comments: data.offerData!.comments,
                                            ConfirmingSubscriber: data.offerData!.ConfirmingSubscriber!
                                        )
                                    );
                                    offerList[index]= data2;
                                  }
                                });
                              },
                              child: data.offerData!.favourite == true ? Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 18,),
                              ):Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 18),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,top: 5),
                            child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                          ),
                          //   data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                          // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                          // InkWell(
                          //     onTap:(){
                          //       var body = {
                          //         "offer_id": data.offerData!.id.toString(),
                          //         "user_id" : DataManager.getInstance().getuserId().toString()
                          //       };
                          //       DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                          //       bool isCommentsLoading = true;
                          //       List<CommentsDataList> CommentsList = [];
                          //       DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                          //         CommentsList = value;
                          //         isCommentsLoading = false;
                          //       });
                          //       showModalBottomSheet(
                          //         isScrollControlled: true,
                          //         shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                          //         context: context, builder: (context) {
                          //         return  StatefulBuilder(builder: (context, modalState) {
                          //           isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                          //             modalState((){});
                          //
                          //           },):null;
                          //           return Container(
                          //               height: MediaQuery.of(context).size.height*0.8,
                          //               width:isMobile?width:tabWidth,
                          //               decoration: BoxDecoration(
                          //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                          //                 color:Color(0x33DCF0DD),
                          //               ),
                          //               child: Scaffold(
                          //                 backgroundColor: Colors.transparent,
                          //                 body: Column(
                          //                   mainAxisAlignment: MainAxisAlignment.start,
                          //                   crossAxisAlignment: CrossAxisAlignment.center,
                          //                   children: [
                          //                     Container(
                          //                         height: 3.5,
                          //                         margin: EdgeInsets.only(top: 13),
                          //                         width: 38,
                          //                         decoration: BoxDecoration(
                          //                           borderRadius: BorderRadius.circular(5),
                          //                           color: Colors.black54,
                          //                         )),
                          //                     20.height,
                          //                     Text("Comments",style:BlackSubTitleStyle,),
                          //                     10.height,
                          //                     Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                          //                     2.height,
                          //                     // isCommentsLoading?
                          //                     // Padding(
                          //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                          //                     //   child: LoadingWidget(),
                          //                     // )
                          //                     //     :
                          //                     //
                          //                     // CommentsList.isEmpty?
                          //                     // Padding(
                          //                     //   padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                          //                     //   child: Image(image: AssetImage("assets/NoData.png"),fit: BoxFit.fill,width: 85,height: 85,),
                          //                     // )
                          //                     //     : Expanded(
                          //                     //   child: ListView.builder(
                          //                     //     controller: scrollCommentsController,
                          //                     //     itemCount: CommentsList.length,
                          //                     //     padding: EdgeInsets.only(bottom: 100),
                          //                     //     itemBuilder: (context, i) {
                          //                     //       var CommentsData = CommentsList[i];
                          //                     //       final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                          //                     //       final currentTime = DateTime.now();
                          //                     //       final diff_dy = currentTime.difference(startTime).inDays;
                          //                     //       final diff_mi = currentTime.difference(startTime).inMinutes;
                          //                     //       final diff_s = currentTime.difference(startTime).inSeconds;
                          //                     //       final diff_hr = currentTime.difference(startTime).inHours;
                          //                     //       return Row(
                          //                     //         mainAxisAlignment: MainAxisAlignment.start,
                          //                     //         crossAxisAlignment: CrossAxisAlignment.start,
                          //                     //         children: [
                          //                     //           Container(
                          //                     //             margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                          //                     //             height: 40,
                          //                     //             width: 40,
                          //                     //             decoration: BoxDecoration(
                          //                     //                 shape: BoxShape.circle,
                          //                     //                 image:
                          //                     //                 CommentsData.user!.profilePicture == null ||
                          //                     //                     CommentsData.user!.profilePicture.toString() == "null" ||
                          //                     //                     CommentsData.user!.profilePicture.toString()  == "" ?
                          //                     //                 DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                          //                     //                 DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                          //                     //             ),
                          //                     //           ),
                          //                     //           Flexible(
                          //                     //             child: Container(
                          //                     //               padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                          //                     //               margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          //                     //               decoration: BoxDecoration(
                          //                     //                 borderRadius: BorderRadius.circular(7),
                          //                     //                 color: Constants.white,
                          //                     //               ),
                          //                     //               child: Column(
                          //                     //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                     //                 mainAxisAlignment: MainAxisAlignment.start,
                          //                     //                 children: [
                          //                     //                   Row(
                          //                     //                     children: [
                          //                     //                       Text("${CommentsData.user!.username}",style: BlackSubTitleStyle,),
                          //                     //                       10.width,
                          //                     //                       Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                          //                     //                     ],
                          //                     //                   ),
                          //                     //
                          //                     //                   Padding(
                          //                     //                     padding: const EdgeInsets.only(top: 2.0),
                          //                     //                     child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                          //                     //                   ),
                          //                     //                 ],
                          //                     //               ),
                          //                     //             ),
                          //                     //           ),
                          //                     //         ],
                          //                     //       );
                          //                     //     },),
                          //                     // ),
                          //                   ],
                          //                 ),
                          //                 bottomSheet:Container(
                          //
                          //                   decoration: BoxDecoration(
                          //                       color: Color(0x33DCF0DD),
                          //
                          //                       border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                          //                   ),
                          //                   child: Row(
                          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                     crossAxisAlignment: CrossAxisAlignment.center,
                          //                     children: [
                          //
                          //                       10.width,
                          //                       Container(
                          //                         height: 35,
                          //                         width: 35,
                          //                         margin: const EdgeInsets.only(bottom: 5),
                          //                         padding: EdgeInsets.zero,
                          //                         decoration: BoxDecoration(
                          //                             borderRadius: BorderRadius.circular(5),
                          //                             color: Constants.greyDark
                          //                         ),
                          //                         child: Center(child: Container(
                          //                           height: 35,width: 35,
                          //                           decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                          //                             // border: Border.all(color: Constants.white,width: 4),
                          //                               shape: BoxShape.circle,
                          //                               image: DecorationImage(image: AssetImage("assets/home.png"),)
                          //                           ):  BoxDecoration(
                          //                               border: Border.all(color: Constants.white,width: 2),
                          //                               shape: BoxShape.circle,
                          //                               image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                          //                           ),
                          //                         )),
                          //                       ),
                          //
                          //                       Flexible(
                          //                         child: TextFormField(
                          //                           controller: messageController,
                          //                           keyboardType: TextInputType.text,
                          //                           // maxLines: ,
                          //                           onChanged: (value){
                          //                             setState(() {
                          //
                          //                             });
                          //                             modalState((){});
                          //                           },
                          //                           autofocus: false,
                          //                           focusNode: focusNode,
                          //                           // style: black14500,
                          //                           cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                          //                           decoration: InputDecoration(
                          //                             contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                          //                             border: const OutlineInputBorder(borderSide: BorderSide.none),
                          //                             hintText: "Write your comments",
                          //                             hintStyle: greySubTitleItalicStyle,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                       messageController.text.isEmpty?SizedBox():InkWell(
                          //                         onTap: (){
                          //                           // messageController.clear();
                          //                           DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: messageController.text).then((value) {
                          //                             if(value["status"] == "200"){
                          //                               var CommentRes =  CommentsDataList(
                          //                                 id: value["result"]["id"],
                          //                                 user:CommentsUser(
                          //                                     id: value["result"]["user"]["id"],
                          //                                     displayname:  value["result"]["user"]["displayname"],
                          //                                     profilePicture:  value["result"]["user"]["profile_picture"],
                          //                                     username:  value["result"]["user"]["username"]
                          //                                 ),
                          //                                 offer: value["result"]["offer"],
                          //                                 comment: value["result"]["comment"],
                          //                                 createdAt: value["result"]["created_at"],
                          //                                 updatedAt: value["result"]["updated_at"],
                          //                               );
                          //                               modalState((){
                          //                                 CommentsList.add(CommentRes);
                          //                                 messageController.clear();
                          //                                 scrollToBottom();
                          //                               });
                          //                             }
                          //                           });
                          //                         },
                          //                         child: Container(
                          //                           margin: EdgeInsets.only(right: 10),
                          //                           height: 40,
                          //                           width: 40,
                          //                           decoration: BoxDecoration(
                          //                               shape: BoxShape.circle,
                          //                               border: Border.all(color: Constants.greyLight,width: 1),
                          //                               color:Constants.primaryColor
                          //                           ),
                          //                           child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 // Column(
                          //                 //   crossAxisAlignment: CrossAxisAlignment.center,
                          //                 //   mainAxisSize: MainAxisSize.max,
                          //                 //   mainAxisAlignment: MainAxisAlignment.end,
                          //                 //   children: [
                          //                 //     Container(
                          //                 //       height: 50,
                          //                 //       decoration: BoxDecoration(
                          //                 //         color: Color(
                          //                 //             0x1ABCDFF8),
                          //                 //         border: Border(top: BorderSide(color: Constants.greyLight))
                          //                 //       ),
                          //                 //       child: Row(
                          //                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                 //         children: [
                          //                 //
                          //                 //           const SizedBox(width: 7,),
                          //                 //           isemojiShowing == false?
                          //                 //           InkWell(
                          //                 //               onTap: (){
                          //                 //                 // controller.focusNode.value.unfocus();
                          //                 //                 // controller.focusNode.value.canRequestFocus=false;
                          //                 //                 // Future.delayed(Duration(milliseconds: 100),() {
                          //                 //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                          //                 //                 //   // controller.focusNode.value.requestFocus();
                          //                 //                 //   // controller.filepick.value = false;
                          //                 //                 //   // controller.showStickers.value = false;
                          //                 //                 //   // controller.showAttachmentButtons.value = false;
                          //                 //                 // },);
                          //                 //                 //
                          //                 //                 // controller.filepick.value = false;
                          //                 //                 // // if ( controller.emojiShowing.value != false) {
                          //                 //                 // //   FocusScope.of(context).unfocus();
                          //                 //                 // // }
                          //                 //               },
                          //                 //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                          //                 //           InkWell(
                          //                 //             onTap: () {
                          //                 //               // controller.focusNode.value.requestFocus();
                          //                 //               // controller.emojiShowing.value = false;
                          //                 //               // controller.filepick.value = false;
                          //                 //               // controller.showStickers.value = false;
                          //                 //               // controller.showAttachmentButtons.value = false;
                          //                 //
                          //                 //             },
                          //                 //             child: const Padding(
                          //                 //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                          //                 //               child: Icon(
                          //                 //                 Icons.keyboard,
                          //                 //                 color: Colors.black45,size: 22,
                          //                 //               ),
                          //                 //             ),
                          //                 //           ),
                          //                 //           Flexible(
                          //                 //             child: TextFormField(
                          //                 //               controller: messageController,
                          //                 //               onChanged: (value){
                          //                 //
                          //                 //               },
                          //                 //               autofocus: false,
                          //                 //               focusNode: focusNode,
                          //                 //               // style: black14500,
                          //                 //               cursorColor: Colors.black,
                          //                 //               onTap: (){
                          //                 //                 isemojiShowing = false;
                          //                 //               },
                          //                 //               decoration: InputDecoration(
                          //                 //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                          //                 //                 hintText: "Write your comments",
                          //                 //                 hintStyle: grey14400,
                          //                 //               ),
                          //                 //             ),
                          //                 //           ),
                          //                 //
                          //                 //         ],
                          //                 //       ),
                          //                 //     ),
                          //                 //     Offstage(
                          //                 //       offstage: isemojiShowing,
                          //                 //       child: SizedBox(
                          //                 //         height: 240,
                          //                 //         child: emg.EmojiPicker(
                          //                 //
                          //                 //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                          //                 //             onEmojiSelected(emoji);
                          //                 //             messageChecker = emoji.toString();
                          //                 //           },
                          //                 //           onBackspacePressed: onBackspacePressed,
                          //                 //           config: emg.Config(
                          //                 //             columns: 9,
                          //                 //             // Issue: https://github.com/flutter/flutter/issues/28894
                          //                 //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                          //                 //             verticalSpacing: 0,
                          //                 //             horizontalSpacing: 0,
                          //                 //             gridPadding: EdgeInsets.zero,
                          //                 //             initCategory: emg.Category.RECENT,
                          //                 //             bgColor: const Color(0xFFF2F2F2),
                          //                 //             indicatorColor: Constants.primaryColor,
                          //                 //             iconColor: Colors.grey,
                          //                 //             iconColorSelected:  Constants.primaryColor,
                          //                 //             backspaceColor:  Constants.primaryColor,
                          //                 //             skinToneDialogBgColor: Colors.white,
                          //                 //             skinToneIndicatorColor: Colors.grey,
                          //                 //             enableSkinTones: true,
                          //                 //             // showRecentsTab: true,
                          //                 //             recentsLimit: 28,
                          //                 //             replaceEmojiOnLimitExceed: false,
                          //                 //             noRecents: const Text(
                          //                 //               'No Recent',
                          //                 //               style: TextStyle(fontSize: 20, color: Colors.black26),
                          //                 //               textAlign: TextAlign.center,
                          //                 //             ),
                          //                 //             loadingIndicator: const SizedBox.shrink(),
                          //                 //             tabIndicatorAnimDuration: kTabScrollDuration,
                          //                 //             categoryIcons: const emg.CategoryIcons(),
                          //                 //             buttonMode: emg.ButtonMode.MATERIAL,
                          //                 //             checkPlatformCompatibility: true,
                          //                 //           ),
                          //                 //         ),
                          //                 //       ),
                          //                 //     ),
                          //                 //   ],
                          //                 // ),
                          //               )
                          //           );
                          //         },);
                          //
                          //       },).then((value) {
                          //
                          //       });
                          //     },
                          //     child: Image.asset("assets/comment.png",height: 18,)),
                          // data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 3.0),
                          //   child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                          // ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Image.asset("assets/note.png",height: 15,color:Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0,top: 5,right: 20),
                            child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED" ?
        Positioned(
          top: 0,bottom: 0,left: 0,right: 0,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: isMobile? width:tabWidth,
              height: isMobile == false?tabHeight*0.38: height*0.18,
              decoration:  BoxDecoration(
                borderRadius:  BorderRadius.circular(8),
                color: Constants.closeOfferCard,
              ),
            ),
          ),
        ) :SizedBox(),
        data.offerData!.offerstatus.toString().trim().toUpperCase() != "CLOSED" ?
        SizedBox(): data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId() || isCounterSellBuy?
        Positioned(
          top:5,right: 5,
          child: InkWell(
            onTap: (){
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  bool butttonLoader = false;
                  return StatefulBuilder(builder: (context, ModalState) {
                    return Dialog(
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 16,
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          children: [
                            Image.asset("assets/delete.png",height: 50,width: 50,color: Colors.black,),
                            Padding(
                              padding: EdgeInsets.only(top:10,bottom: 10),
                              child: Text('DELETE OFFER!',style: BlackFieldStyleBold,textAlign: TextAlign.center),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text("ARE YOU SURE TO DELETE?",style: Black87HintStyle,textAlign: TextAlign.center),
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
                                      fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
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
                                      var body = {
                                        "offer_id": data.offerData!.id.toString()
                                      };
                                      DrawAuraAPi.CreateDataApi(body: body ,ApiEndPoint: "deleteOffer").then((value) {
                                        ModalState(() {
                                          butttonLoader= false;
                                        });
                                        Navigator.pop(context);
                                        if(value["status"] == 200){
                                          Constants.showToast(value["message"]);
                                          ModalState((){
                                            offerList.removeAt(index);
                                          });

                                        }else{
                                          Constants.showToast(value["message"]);
                                        }

                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Constants.primaryColor1,
                                      fixedSize: Size(MediaQuery.of(context).size.width*0.3, 35),
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)),
                                    ),
                                    child: butttonLoader == true ? SizedBox(height: 24,width: 24,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.5,)): Text("Yes",style:WhiteButtonStyle,)),
                              ],
                            ),
                          ],
                        )
                    );
                  },);
                },
              );
            },
            child: CircleAvatar(
                radius: 13,backgroundColor: Colors.grey.shade800,
                child: Image.asset("assets/delete.png",height: 18,color: Colors.white,)),
          ),
        ):SizedBox(),
        Positioned(
            bottom:0,right: 0,
            child: privetPublicLogoNew(isPrivet: data.offerData!.privacy.toString().toUpperCase() == "PRIVATE"?true:false)
        ),
      ],
    ),
  );

}