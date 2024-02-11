
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/SearchPageController.dart';
import 'package:socialapps/model/CommentsModel.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/screens/Reaction/reactionList.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'package:get/get.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/screens/widgets/OfferCradCommonFunction.dart';
import 'package:socialapps/screens/widgets/SimmerLoadingBuilder.dart';
import '../../common/style.dart';



class feed_screen extends StatelessWidget {
  const feed_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    return GetX<SearchPageController>(
        init: SearchPageController(),
        initState: (value) async {
          value.controller!.getFeedList();
          value.controller!.addFeedData();


        },
        // dispose: (value){
        //    value.controller!.scrollCommentsController.dispose();
        // },
        builder: (controller) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Color(0xFFF5F5F5),
              automaticallyImplyLeading: false,
              titleSpacing: 40,
              title: const Text("Feeds", style: AppBarTitle),
              actions: [
                InkWell(onTap: () {
                  Get.to(()=> NewOfferCreateScreen(AddressTitle: "",Address: "",From: "New",PrefillOfferData: PrefillOfferDataModel(),Type: "",OfferId: "",SubId: ""));},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 15),
                    decoration:  BoxDecoration(shape: BoxShape.circle, color:Constants.primaryColor1,
                      boxShadow: [
                        BoxShadow(
                          color:Constants.primaryColor20,
                          blurRadius: 1.5,
                          spreadRadius: 2,
                          offset: Offset(
                            0,
                            3,
                          ),
                        )
                      ],
                    ),
                    child: Center(child: Image.asset("assets/edit.png",height: 22,width: 22,color: Constants.white),),
                  ),)
              ],
            ),
            body:controller.isLoadFeedList.value==false? Center(child: ShimmerFeedList(context)):controller.FeedList.isEmpty?  Center(
              child:     NotAvailableText("Not found!")
            ):RefreshIndicator(
              onRefresh: () async {
                await controller.getFeedList();
                await controller.addFeedData();
                return Future.value();
              },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.FeedList.length,
                    controller: controller.feedListScrollController.value,
                    itemBuilder: (context, index) {
                      var data = controller.FeedList[index];

                      String NextImage = "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png";
                      if(data.offerData!.offerItems!.length == 1){
                        if(data.offerData!.offerItems!.first.itemMedia!.length == 1){
                          NextImage = "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png";
                        }else{
                          if(data.offerData!.offerItems!.first.itemMedia!.length == 2 ){
                            NextImage = data.offerData!.offerItems!.first.itemMedia![1].file.toString();
                          }else{
                            NextImage = "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png";
                          }
                        }
                      }else if(data.offerData!.offerItems!.length == 2){
                        if(data.offerData!.offerItems!.first.itemMedia!.length == 2 ){
                          NextImage = data.offerData!.offerItems!.first.itemMedia![1].file.toString();
                        }else if(data.offerData!.offerItems![1].itemMedia!.isNotEmpty ){
                          NextImage = data.offerData!.offerItems![1].itemMedia![0].file.toString();
                        }else{
                          NextImage = "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png";
                        }
                      }else if(data.offerData!.offerItems!.length == 3){

                        if(data.offerData!.offerItems!.first.itemMedia!.length == 2 ){
                          NextImage = data.offerData!.offerItems!.first.itemMedia![1].file.toString();
                        }else if(data.offerData!.offerItems![1].itemMedia!.isNotEmpty ){
                          NextImage = data.offerData!.offerItems![1].itemMedia![0].file.toString();
                        }else if(data.offerData!.offerItems![2].itemMedia!.isNotEmpty ){
                          NextImage = data.offerData!.offerItems![2].itemMedia![0].file.toString();
                        }else{
                          NextImage="https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png";
                        }
                      }else{
                        NextImage = "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png";
                      }

                      bool isFollow = false;
                      bool isFollowYou = false;
                      for(var i = 0 ; i<data.offerData!.subscribers!.followers!.length; i++){
                        if(data.offerData!.subscribers!.followers![i].toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                          isFollowYou = true;
                          break ;
                        }else{
                          isFollowYou = false;
                        }
                      }
                      bool isConfirmingUser = false;
                      for(var i = 0 ; i<data.offerData!.ConfirmingSubscriber!.length; i++){
                        if(data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                          isConfirmingUser = true;
                          break ;
                        }else{
                          isConfirmingUser = false;
                        }
                      }

                      bool  isCounterSellBuy = false ;
                      for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                        if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                          isCounterSellBuy = true;
                          break ;
                        }else{
                          isCounterSellBuy = false;
                        }
                      }
                      List allMediaUrls = [];
                      for (var r= 0 ; r<data.offerData!.offerItems!.length ; r++){
                        for (var g = 0 ; g <data.offerData!.offerItems![r].itemMedia!.length ; g++){
                          allMediaUrls.add(data.offerData!.offerItems![r].itemMedia![g].file.toString());
                        }
                      }
                      List <bool>isAllItemDone1 = [] ;
                      for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                        if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                          print("");
                          isAllItemDone1.add(true);
                        }else{
                          isAllItemDone1.add(false);
                        }
                      }
                      return StatefulBuilder(builder: (context, setModalState) {
                        return FutureBuilder<String>(
                            future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                print(snapshot.data);
                              return InkWell(
                                onTap: () async{
                                  tapOnOffer(context,data,isCounterSellBuy,isConfirmingUser,isAllItemDone1).then((value) {
                                    controller.getFeedList();
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      // height: ResponsiveHelper.isMobile(context)?height*0.4:height*0.50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurStyle: BlurStyle.outer,
                                              blurRadius: 2
                                          )
                                        ],
                                        border: Border.all(color: Colors.grey,width: 0.2,

                                        ), ),
                                      width: ResponsiveHelper.isMobile(context)?width:tabWidth,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Column(
                                            children: [
                                              Stack(
                                                  children:[
                                                    Container(
                                                      width: ResponsiveHelper.isMobile(context)?width * 0.40:tabWidth*0.40,
                                                      height:  ResponsiveHelper.isMobile(context)?height * 0.18:tabHeight*0.30,
                                                      decoration: data.offerData!.offerItems!.first.itemMedia == null || data.offerData!.offerItems!.first.itemMedia!.isEmpty ?
                                                      BoxDecoration(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                                          image:
                                                          DecorationImage( image: NetworkImage("https://i0.wp.com/seds.org/wp-content/uploads/2020/03/placeholder.png?fit=1200%2C800&ssl=1"), fit: BoxFit.fill,
                                                          )):
                                                      BoxDecoration(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                                          image: "${data.offerData!.offerItems!.first.itemMedia!.first.file.toString().substring(data.offerData!.offerItems!.first.itemMedia!.first.file.toString().lastIndexOf('.'))}" == ".mp4"?
                                                          snapshot.connectionState == ConnectionState.waiting?
                                                          DecorationImage(image: AssetImage("assets/loading.gif"),fit: BoxFit.fill)
                                                              :DecorationImage(image: FileImage(File("${snapshot.data}")),fit: BoxFit.fill):
                                                          DecorationImage( image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems!.first.itemMedia!.first.file}"), fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    Positioned(
                                                        top: 0,left: 0,
                                                        child:  Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                            decoration:  BoxDecoration(
                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                                                                color: data.offerData!.buyORsell.toString() =="SELL"?Constants.redColor:Constants.primaryColor1
                                                            ),
                                                            child: Center(child: Text("${data.offerData!.buyORsell.toString()}",style: WhiteHeadingStyle,)
                                                              ,))),

                                                    data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?SizedBox():
                                                    isFollowYou == false?
                                                    Positioned(
                                                      right: 5,
                                                      top:5,
                                                      child: InkWell(
                                                        onTap: (){
                                                          DrawAuraAPi.FollowUser(follower_id:  data.offerData!.subscribers!.id.toString(),following_id: DataManager.getInstance().getuserId().toString().trim() ).then((value) {
                                                            if(value["status"] == "200"){
                                                              Constants.showToast("${Url.OnFollow} ${data.offerData!.subscribers!.displayname.toString()}");
                                                              setModalState(() {
                                                                isFollowYou = true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children:  [
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    color:Constants.primaryColor1
                                                                ),
                                                                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                                child: Text( "Follow", style:isFollow == true? WhiteSubTitleStyle: WhiteSubTitleStyle, textAlign: TextAlign.center,)),
                                                          ],
                                                        ),
                                                      ),

                                                    ):SizedBox(),
                                                  ]
                                              ),
                                              Stack(
                                                  children:[
                                                    // data.offerData!.offerItems!.first.itemMedia!.length >= 2
                                                    //     ?Container(
                                                    //   width: ResponsiveHelper.isMobile(context)?width * 0.40:tabWidth*0.40,
                                                    //   height:  ResponsiveHelper.isMobile(context)?height * 0.18:tabHeight*0.30,
                                                    //   decoration:  data.offerData!.offerItems!.first.itemMedia == null || data.offerData!.offerItems!.first.itemMedia!.isEmpty || data.offerData!.offerItems!.first.itemMedia!.length == 1  ?
                                                    //   BoxDecoration(
                                                    //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                                                    //       image:
                                                    //       DecorationImage( image: NetworkImage("https://i0.wp.com/seds.org/wp-content/uploads/2020/03/placeholder.png?fit=1200%2C800&ssl=1"), fit: BoxFit.fill,
                                                    //       )):
                                                    //   BoxDecoration(
                                                    //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                                                    //       image: "${data.offerData!.offerItems!.first.itemMedia![1].file.toString().substring(data.offerData!.offerItems!.first.itemMedia![1].file.toString().lastIndexOf('.'))}" == ".mp4"?
                                                    //       DecorationImage(image: FileImage(File("assets/mp4placeholder.png")),fit: BoxFit.fill):
                                                    //       DecorationImage( image: NetworkImage("${Url.IMAGE_URL}${data.offerData!.offerItems!.first.itemMedia![1].file}"), fit: BoxFit.fill,
                                                    //       )),
                                                    // ):

                                                    Container(
                                                      width: ResponsiveHelper.isMobile(context)?width * 0.40:tabWidth*0.40,
                                                      height:  ResponsiveHelper.isMobile(context)?height * 0.199:tabHeight*0.35,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                                                          image:  DecorationImage(image:NetworkImage("$NextImage"), fit: BoxFit.fill)),
                                                    ),
                                                  ]
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 5,),
                                                  SizedBox(

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children:  [
                                                        Text(  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ? "You": "${data.offerData!.subscribers!.displayname.toString()}",style:BlackSubTitleStyle,),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text("posted this ${
                                                      OfferCreateTime("${data.offerData!.createdAt.toString()}")} ago",style: BlackSubTitleItalicStyle,),
                                                  const SizedBox(height: 5,),
                                                  Container(
                                                    padding: const EdgeInsets.all(10),
                                                    // height: MediaQuery.of(context).size.height*0.2,
                                                    width:  ResponsiveHelper.isMobile(context)?width*0.5:tabWidth*0.5,
                                                    decoration: const BoxDecoration(

                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:  Color(0xFFCECCCC),
                                                        ),
                                                        BoxShadow(
                                                          color: Colors.white70,
                                                          spreadRadius: 10.0,
                                                          blurRadius: 20.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children:  [
                                                        RichText(
                                                            maxLines: 5,
                                                            text:   TextSpan(
                                                            style: TextStyle(
                                                                fontSize: 9,
                                                                height: 1.3,
                                                                color: Colors.black
                                                            ),
                                                            children: [
                                                              TextSpan(text: "${data.offerData!.category!.name.toString()}",style: BlackTitleStyle),
                                                              TextSpan(text: " ${data.offerData!.segment!.name.toString()} ${data.offerData!.subsegment!.name.toString()}, ${data.offerData!.subscribers!.displayname.toString()} ${data.offerData!.offerItems!.first.name.toString()} ${data.offerData!.offerItems!.first.price.toString()} per ${data.offerData!.offerItems!.first.unit!.name.toString()}",style: editTextStyle,),
                                                            ]
                                                        )),
                                                        5.height,
                                                        Text("${data.offerData!.offerConditions!.periodicity} , ${data.offerData!.addres},",style: BlackDescStyleBold,overflow: TextOverflow.ellipsis,maxLines: 5,),
                                                        const SizedBox(height: 5,),
                                                        Container(
                                                            width: ResponsiveHelper.isMobile(context)?width*0.5:tabWidth*0.5,
                                                            padding: const EdgeInsets.only(right: 3,left: 3,top:3,bottom: 3),
                                                            decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    offset: Offset(0, 4),
                                                                    spreadRadius: 5,
                                                                    blurRadius: 5,
                                                                    blurStyle: BlurStyle.solid,
                                                                    color: Colors.grey.shade300
                                                                )
                                                              ],
                                                              borderRadius: BorderRadius.all(Radius.circular(3)),
                                                              color: Color(0xFFFFFFFFF),
                                                            ),
                                                            child:RichText(

                                                              text: TextSpan(text: 'Status : ',style:PrimaryColor12400Style,
                                                                children:[
                                                                  TextSpan(text: '${data.offerData!.offerstatus}, ',style: editTextStyle),
                                                                  const TextSpan(text: 'Response :',style: PrimaryColor12400Style),
                                                                  TextSpan(text: ' ${data.offerData!.offerresponses}',style: editTextStyle),
                                                                  const TextSpan(text: '\nExpiry :',style: PrimaryColor12400Style),
                                                                  TextSpan(text:data.offerData!.offerConditions!.expiry == null ? "  -": ' ${data.offerData!.offerConditions!.expiry}',style: editTextStyle)
                                                                ]),

                                                            )
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  5.height,
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      5.width,
                                                      data.offerData!.like == 0 ?  Builder(
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
                                                                    controller.FeedList[index]= data2;
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
                                                                    controller.FeedList[index]= data2;
                                                                  }
                                                                  // ? TrendingOfferList[index].offerData!.like = true:data.offerData!.like = false;

                                                                });
                                                              }
                                                            },
                                                            reactions: flagsReactions,
                                                            initialReaction:data.offerData!.like == 0 ?  Reaction<String>(
                                                              value: null,
                                                              icon:  Icon(
                                                                Icons.thumb_up_outlined,color: Colors.black87,size: 18,
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
                                                      ):Icon(Icons.thumb_up_alt_rounded,color: Constants.primaryColor1,size: 18),
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
                                                                controller.FeedList[index]= data2;
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
                                                                controller.FeedList[index]= data2;
                                                              }


                                                            });
                                                          },
                                                          child: data.offerData!.favourite == true ? Padding(
                                                            padding: const EdgeInsets.only(bottom: 5.0),
                                                            child: Icon(Icons.favorite,color: Constants.primaryColor1,size: 20,),
                                                          ):Padding(
                                                            padding: const EdgeInsets.only(bottom: 5.0),
                                                            child: Icon(Icons.favorite_border_outlined,color:Constants.greyDark,size: 20),
                                                          )
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3.0),
                                                        child: Text("${data.offerData!.offerfavoritecount.toString()}",style: greyFieldStyle,),
                                                      ),
                                                      data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():  Spacer(),
                                                      data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                                                      InkWell(
                                                          onTap:(){
                                                            var body = {
                                                              "offer_id": data.offerData!.id.toString(),
                                                              "user_id" : DataManager.getInstance().getuserId().toString()
                                                            };
                                                            DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount");
                                                            bool isCommentsLoading = true;
                                                            List<CommentsDataList> CommentsList = [];
                                                            DrawAuraAPi().getOfferCommentsList(offer_id: data.offerData!.id.toString()).then((value) {
                                                              CommentsList = value;
                                                              isCommentsLoading = false;
                                                            });
                                                            showModalBottomSheet(
                                                              isScrollControlled: true,
                                                              constraints: BoxConstraints(maxWidth: ResponsiveHelper.isMobile(context)?width:tabWidth),
                                                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)) ),
                                                              context: context, builder: (context) {
                                                              return  StatefulBuilder(builder: (context, modalState) {
                                                                isCommentsLoading == true?  Future.delayed(Duration(milliseconds: 500),() {
                                                                  modalState((){});

                                                                },):null;
                                                                return Container(
                                                                    height: MediaQuery.of(context).size.height*0.8,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                                                      color:Color(0x33DCF0DD),
                                                                    ),
                                                                    child: Scaffold(
                                                                      backgroundColor: Colors.transparent,
                                                                      body: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                              height: 3.5,
                                                                              margin: EdgeInsets.only(top: 13),
                                                                              width: 38,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                                color: Colors.black54,
                                                                              )),
                                                                          20.height,
                                                                          Text("Comments",style:BlackSubTitleStyle,),
                                                                          10.height,
                                                                          Divider(color: Colors.black,height: 2.5,thickness: 1.2),
                                                                          2.height,
                                                                          isCommentsLoading?
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                                                                            child: LoadingWidget(),
                                                                          )
                                                                              :

                                                                          CommentsList.isEmpty?
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                                                                            child:      NotAvailableText("No commends available!")
                                                                          )
                                                                              : Expanded(
                                                                            child: ListView.builder(
                                                                              controller: controller.scrollCommentsController,
                                                                              itemCount: CommentsList.length,
                                                                              padding: EdgeInsets.only(bottom: 100),
                                                                              itemBuilder: (context, i) {
                                                                                var CommentsData = CommentsList[i];
                                                                                final startTime =DateFormat('dd-MM-yyyy HH:mm').parse('${CommentsData.createdAt.toString()}');
                                                                                final currentTime = DateTime.now();
                                                                                final diff_dy = currentTime.difference(startTime).inDays;
                                                                                final diff_mi = currentTime.difference(startTime).inMinutes;
                                                                                final diff_s = currentTime.difference(startTime).inSeconds;
                                                                                final diff_hr = currentTime.difference(startTime).inHours;
                                                                                return Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(left: 15,right: 0,top: 5),
                                                                                      height: 40,
                                                                                      width: 40,
                                                                                      decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          image:
                                                                                          CommentsData.user!.profilePicture == null ||
                                                                                              CommentsData.user!.profilePicture.toString() == "null" ||
                                                                                              CommentsData.user!.profilePicture.toString()  == "" ?
                                                                                          DecorationImage(image:   AssetImage("assets/home.png"),fit: BoxFit.fill):
                                                                                          DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${CommentsData.user!.profilePicture}"),fit: BoxFit.fill)
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      child: Container(
                                                                                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                                                                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(7),
                                                                                          color: Constants.white,
                                                                                        ),
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              children: [
                                                                                                Text("${CommentsData.user!.displayname}",style: BlackSubTitleStyle,overflow: TextOverflow.ellipsis,),
                                                                                                10.width,
                                                                                                Text(diff_s <= 60 ?"$diff_s""s":diff_mi <= 60 ?"$diff_mi"'m':diff_hr <= 24 ?"$diff_hr"'h':"$diff_dy"'d',style: greyDescItalicStyle,)
                                                                                              ],
                                                                                            ),

                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(top: 2.0),
                                                                                              child: Text('''${CommentsData.comment}''',style: Black87DescStyle,),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      bottomSheet:Container(

                                                                        decoration: BoxDecoration(
                                                                            color: Color(0x33DCF0DD),

                                                                            border: Border(top: BorderSide(color: Constants.greyLight,width: 1.5))
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            10.width,
                                                                            Container(
                                                                              height: 35,
                                                                              width: 35,
                                                                              margin: const EdgeInsets.only(bottom: 5),
                                                                              padding: EdgeInsets.zero,
                                                                              decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  color: Constants.greyDark
                                                                              ),
                                                                              child: Center(child: Container(
                                                                                height: 35,width: 35,
                                                                                decoration: DataManager.getInstance().getuserImage() == "null" ||  DataManager.getInstance().getuserImage() == null ||DataManager.getInstance().getuserImage()=="" ? BoxDecoration(
                                                                                  // border: Border.all(color: Constants.white,width: 4),
                                                                                    shape: BoxShape.circle,
                                                                                    image: DecorationImage(image: AssetImage("assets/home.png"),)
                                                                                ):  BoxDecoration(
                                                                                    border: Border.all(color: Constants.white,width: 2),
                                                                                    shape: BoxShape.circle,
                                                                                    image: DecorationImage(image: NetworkImage("${Url.IMAGE_URL}${DataManager.getInstance().getuserImage()}"),fit: BoxFit.fill)
                                                                                ),
                                                                              )),
                                                                            ),

                                                                            Flexible(
                                                                              child: TextFormField(
                                                                                controller: controller.messageController.value,
                                                                                keyboardType: TextInputType.text,
                                                                                // maxLines: ,
                                                                                onChanged: (value){
                                                                                  modalState((){});
                                                                                },
                                                                                autofocus: false,
                                                                                focusNode: controller.focusNode.value,
                                                                                // style: black14500,
                                                                                cursorColor: Colors.black,textAlignVertical: TextAlignVertical.center,
                                                                                decoration: InputDecoration(
                                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                                                                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  hintText: "Write your comments",
                                                                                  hintStyle: greySubTitleItalicStyle,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            controller.messageController.value.text.isEmpty?SizedBox():InkWell(
                                                                              onTap: (){
                                                                                // messageController.clear();
                                                                                DrawAuraAPi.CreateOfferComments(offer_id: data.offerData!.id.toString(),user_id: DataManager.getInstance().getuserId().toString(),Comments: controller.messageController.value.text).then((value) {
                                                                                  if(value["status"] == "200"){
                                                                                    var CommentRes =  CommentsDataList(
                                                                                      id: value["result"]["id"],
                                                                                      user:CommentsUser(
                                                                                          id: value["result"]["user"]["id"],
                                                                                          displayname:  value["result"]["user"]["displayname"],
                                                                                          profilePicture:  value["result"]["user"]["profile_picture"],
                                                                                          username:  value["result"]["user"]["username"]
                                                                                      ),
                                                                                      offer: value["result"]["offer"],
                                                                                      comment: value["result"]["comment"],
                                                                                      createdAt: value["result"]["created_at"],
                                                                                      updatedAt: value["result"]["updated_at"],
                                                                                    );
                                                                                    modalState((){
                                                                                      CommentsList.add(CommentRes);
                                                                                      controller.messageController.value.clear();
                                                                                      controller.scrollToBottom();
                                                                                    });
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(right: 10),
                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    border: Border.all(color: Constants.greyLight,width: 1),
                                                                                    color:Constants.primaryColor1
                                                                                ),
                                                                                child: Center(child:Icon(Icons.send,color: Colors.white,size: 24,)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // Column(
                                                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                                                      //   mainAxisSize: MainAxisSize.max,
                                                                      //   mainAxisAlignment: MainAxisAlignment.end,
                                                                      //   children: [
                                                                      //     Container(
                                                                      //       height: 50,
                                                                      //       decoration: BoxDecoration(
                                                                      //         color: Color(
                                                                      //             0x1ABCDFF8),
                                                                      //         border: Border(top: BorderSide(color: Constants.greyLight))
                                                                      //       ),
                                                                      //       child: Row(
                                                                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      //         children: [
                                                                      //
                                                                      //           const SizedBox(width: 7,),
                                                                      //           isemojiShowing == false?
                                                                      //           InkWell(
                                                                      //               onTap: (){
                                                                      //                 // controller.focusNode.value.unfocus();
                                                                      //                 // controller.focusNode.value.canRequestFocus=false;
                                                                      //                 // Future.delayed(Duration(milliseconds: 100),() {
                                                                      //                 //   controller.emojiShowing.value = !controller.emojiShowing.value;
                                                                      //                 //   // controller.focusNode.value.requestFocus();
                                                                      //                 //   // controller.filepick.value = false;
                                                                      //                 //   // controller.showStickers.value = false;
                                                                      //                 //   // controller.showAttachmentButtons.value = false;
                                                                      //                 // },);
                                                                      //                 //
                                                                      //                 // controller.filepick.value = false;
                                                                      //                 // // if ( controller.emojiShowing.value != false) {
                                                                      //                 // //   FocusScope.of(context).unfocus();
                                                                      //                 // // }
                                                                      //               },
                                                                      //               child: const Icon(Icons.tag_faces_outlined,size: 24,color: Colors.amber,)):
                                                                      //           InkWell(
                                                                      //             onTap: () {
                                                                      //               // controller.focusNode.value.requestFocus();
                                                                      //               // controller.emojiShowing.value = false;
                                                                      //               // controller.filepick.value = false;
                                                                      //               // controller.showStickers.value = false;
                                                                      //               // controller.showAttachmentButtons.value = false;
                                                                      //
                                                                      //             },
                                                                      //             child: const Padding(
                                                                      //               padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                                      //               child: Icon(
                                                                      //                 Icons.keyboard,
                                                                      //                 color: Colors.black45,size: 22,
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //           Flexible(
                                                                      //             child: TextFormField(
                                                                      //               controller: messageController,
                                                                      //               onChanged: (value){
                                                                      //
                                                                      //               },
                                                                      //               autofocus: false,
                                                                      //               focusNode: focusNode,
                                                                      //               // style: black14500,
                                                                      //               cursorColor: Colors.black,
                                                                      //               onTap: (){
                                                                      //                 isemojiShowing = false;
                                                                      //               },
                                                                      //               decoration: InputDecoration(
                                                                      //                 border: const OutlineInputBorder(borderSide: BorderSide.none),
                                                                      //                 hintText: "Write your comments",
                                                                      //                 hintStyle: grey14400,
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //
                                                                      //         ],
                                                                      //       ),
                                                                      //     ),
                                                                      //     Offstage(
                                                                      //       offstage: isemojiShowing,
                                                                      //       child: SizedBox(
                                                                      //         height: 240,
                                                                      //         child: emg.EmojiPicker(
                                                                      //
                                                                      //           onEmojiSelected: (emg.Category ?category, emg.Emoji emoji) {
                                                                      //             onEmojiSelected(emoji);
                                                                      //             messageChecker = emoji.toString();
                                                                      //           },
                                                                      //           onBackspacePressed: onBackspacePressed,
                                                                      //           config: emg.Config(
                                                                      //             columns: 9,
                                                                      //             // Issue: https://github.com/flutter/flutter/issues/28894
                                                                      //             emojiSizeMax: 24 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
                                                                      //             verticalSpacing: 0,
                                                                      //             horizontalSpacing: 0,
                                                                      //             gridPadding: EdgeInsets.zero,
                                                                      //             initCategory: emg.Category.RECENT,
                                                                      //             bgColor: const Color(0xFFF2F2F2),
                                                                      //             indicatorColor: Constants.primaryColor,
                                                                      //             iconColor: Colors.grey,
                                                                      //             iconColorSelected:  Constants.primaryColor,
                                                                      //             backspaceColor:  Constants.primaryColor,
                                                                      //             skinToneDialogBgColor: Colors.white,
                                                                      //             skinToneIndicatorColor: Colors.grey,
                                                                      //             enableSkinTones: true,
                                                                      //             // showRecentsTab: true,
                                                                      //             recentsLimit: 28,
                                                                      //             replaceEmojiOnLimitExceed: false,
                                                                      //             noRecents: const Text(
                                                                      //               'No Recent',
                                                                      //               style: TextStyle(fontSize: 20, color: Colors.black26),
                                                                      //               textAlign: TextAlign.center,
                                                                      //             ),
                                                                      //             loadingIndicator: const SizedBox.shrink(),
                                                                      //             tabIndicatorAnimDuration: kTabScrollDuration,
                                                                      //             categoryIcons: const emg.CategoryIcons(),
                                                                      //             buttonMode: emg.ButtonMode.MATERIAL,
                                                                      //             checkPlatformCompatibility: true,
                                                                      //           ),
                                                                      //         ),
                                                                      //       ),
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                    )
                                                                );
                                                              },);

                                                            },).then((value) {
                                                            });
                                                          },
                                                          child: Image.asset("assets/comment.png",height: 18,)),
                                                      data.offerData!.subscribers!.id.toString().trim() != DataManager.getInstance().getuserId().toString().trim() && isCounterSellBuy == false?SizedBox():
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3.0),
                                                        child: Text("${data.offerData!.comments.toString().split(".").first}",style: greyFieldStyle,),
                                                      ),
                                                      Spacer(),
                                                      Image.asset("assets/note.png",height: 15,color:Colors.grey),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3.0),
                                                        child: Text("${data.offerData!.offercopycount.toString()}",style: greyFieldStyle,),
                                                      ),
                                                      // Spacer(),
                                                      // Image.asset("assets/time.png",height: 15,color: Constants.primaryColor1,),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.only(left: 3.0),
                                                      //   child: Text(
                                                      //     OfferCreateTime("${data.offerData!.createdAt.toString()}")
                                                      //     ,style: BlackDescStyle,
                                                      //   ),
                                                      // ),
                                                      10.width,
                                                    ],
                                                  ),
                                                  (data.offerData!.offerLike! + data.offerData!.offerDisLike!) == 0 ? SizedBox():
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:0,left: 0),
                                                    child: Text(((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100) <0 ? "00":
                                                    "${((data.offerData!.offerLike! / ( data.offerData!.offerLike! + data.offerData!.offerDisLike!))*100).toStringAsFixed(0)}%(${data.offerData!.offerLike! + data.offerData!.offerDisLike! })",style: primary10500,),
                                                  ),
                                                  data.offerData!.offertemplate == true?SizedBox():
                                                  data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()?
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:0.0),
                                                    child: Row(
                                                      children: [
                                                        Flexible(child: Text(data.offerData!.counterdUser!.isEmpty  || data.offerData!.counterdUser == null || data.offerData!.counterdUser == "null"? "${Url.NoResponded}":"${data.offerData!.counterdUser!.length} ${data.offerData!.counterdUser!.length >= 2? Url.peopleResponded:Url.personResponded}", style: greyHintStyle,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,)),
                                                        SizedBox(width: 4,),
                                                        data.offerData!.counterdUser!.isEmpty?SizedBox():
                                                        Stack(
                                                          children: [
                                                            SizedBox(width: 65,),
                                                            ClipOval(
                                                              child: Image.network(
                                                                "${Url.IMAGE_URL}${data.offerData!.counterdUser![0].image}",
                                                                height: 24,
                                                                width: 24,
                                                                fit: BoxFit.fill,
                                                                errorBuilder: (BuildContext context, Object exception,
                                                                    StackTrace? stackTrace) {
                                                                  return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                                                    height: 24,
                                                                    width: 24,
                                                                    fit: BoxFit.fill,);
                                                                },),
                                                            ),
                                                            data.offerData!.counterdUser!.length >= 2?  Positioned(
                                                                left: 7,
                                                                top: 0,bottom: 0,
                                                                child: ClipOval(
                                                                  child: Image.network(
                                                                    "${Url.IMAGE_URL}${data.offerData!.counterdUser![1].image}",
                                                                    height: 24,
                                                                    width: 24,
                                                                    fit: BoxFit.fill,
                                                                    errorBuilder: (BuildContext context, Object exception,
                                                                        StackTrace? stackTrace) {
                                                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                                                        height: 24,
                                                                        width: 24,
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
                                                                    height: 24,
                                                                    width: 24,
                                                                    fit: BoxFit.fill,
                                                                    errorBuilder: (BuildContext context, Object exception,
                                                                        StackTrace? stackTrace) {
                                                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                                                        height: 24,
                                                                        width: 24,
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
                                                                    height: 24,
                                                                    width: 24,
                                                                    fit: BoxFit.fill,
                                                                    errorBuilder: (BuildContext context, Object exception,
                                                                        StackTrace? stackTrace) {
                                                                      return  Image.network("https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                                                                        height: 24,
                                                                        width: 24,
                                                                        fit: BoxFit.fill,);
                                                                    },),
                                                                )):SizedBox(),
                                                            data.offerData!.counterdUser!.length >= 5?  Positioned(
                                                                left: 22,
                                                                top: 0,bottom: 0,
                                                                child: CircleAvatar(
                                                                    backgroundColor: Constants.lightGreen,
                                                                    child: Center(
                                                                      child: Text("+${ data.offerData!.counterdUser!.length-4}",style: editTextStyle,),
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
                                                            text:"${data.offerCounters!.last.counter![0].tabactivity}  by  ",
                                                            style:greyHintStyle,
                                                            children: <InlineSpan>[
                                                              TextSpan(
                                                                text: data.offerCounters!.last.counter![0].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.last.counter![0].fromCounter!.displayname.toString()}",
                                                                style:grey12500StyleE,
                                                              ),

                                                            ]
                                                        )),
                                                  ) :SizedBox(),

                                                  // :SizedBox(),
                                                  // isCounterSellBuy == true ?
                                                  // Padding(
                                                  //   padding: const EdgeInsets.symmetric(vertical:3.0),
                                                  //   child: Text.rich(TextSpan(
                                                  //       text:"${data.offerCounters!.first.counter![0].tabactivity}  by  ",
                                                  //       style:greyDescItalicStyle,
                                                  //       children: <InlineSpan>[
                                                  //         TextSpan(
                                                  //           text: data.offerCounters!.first.counter![0].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![0].fromCounter!.username.toString()}",
                                                  //           style:GreySubTitleStyle,
                                                  //         ),
                                                  //         // TextSpan(
                                                  //         //   text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                                                  //         //   style:TextStyle(fontSize: 14,fontFamily: "Open Sans Hebrew",fontWeight: FontWeight.w900,fontStyle: FontStyle.italic,color: Colors.grey),
                                                  //         // ),
                                                  //       ]
                                                  //   )),
                                                  // ) :
                                                  // SizedBox(),
                                                  // isCounterSellBuy == true ?
                                                  // data.offerCounters!.first.counter!.length <= 1 ?SizedBox():    Text.rich(TextSpan(
                                                  //     text:"${data.offerCounters!.first.counter![1].tabactivity}  by  ",
                                                  //     style:greyDescItalicStyle,
                                                  //     children: <InlineSpan>[
                                                  //       TextSpan(
                                                  //         text: data.offerCounters!.first.counter![1].fromCounter!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim() ?"You": "${data.offerCounters!.first.counter![1].fromCounter!.username.toString()}",
                                                  //         style:GreySubTitleStyle,
                                                  //       ),
                                                  //       TextSpan(
                                                  //         text:data.offerCounters!.first.counter!.length <= 2?"": " -->${data.offerCounters!.first.counter!.length-2} More",
                                                  //         style:GreySubTitleStyle,
                                                  //       ),
                                                  //     ]
                                                  // ))
                                                  //     : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    data.offerData!.offertemplate == true?  Positioned(
                                        top: 5,right: 10,
                                        child:  Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                            decoration:  BoxDecoration(
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                                              color:Constants.templateBg,
                                            ),
                                            child: Center(child: Text("Ts",style: WhiteHeadingStyle,)
                                              ,))):SizedBox(),
                                  ],
                                ),
                              );
                            }

                        );
                      },);
                    },
                  ),
                ),
                controller.isPaginate.value == true
                    ? paginateLoader()
                    : SizedBox()
              ],
            ),
            )
          );
        });
  }
}

