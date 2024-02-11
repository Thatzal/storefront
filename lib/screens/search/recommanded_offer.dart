import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:intl/intl.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:get/get.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/model/CommentsModel.dart';
import 'package:socialapps/model/OfferDataModel.dart';

import 'package:http/http.dart' as http;
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/screens/widgets/commonCards.dart';
import '../../common/style.dart';
import '../../controller/DataManager.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
class RecommendedOffer extends StatefulWidget {

   RecommendedOffer({Key? key}) : super(key: key);

  @override
  State<RecommendedOffer> createState() => _RecommendedOfferState();
}

class _RecommendedOfferState extends State<RecommendedOffer> {

  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late ScrollController scrollCommentsController;

  void scrollToBottom() {
    final bottomOffset = scrollCommentsController.position.maxScrollExtent;
    scrollCommentsController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
     load();
    scrollCommentsController = ScrollController();
  }

  bool butttonLoader = false;
  @override
  void dispose() {
    scrollCommentsController.dispose();
    super.dispose();
  }
  List<OfferDataModelResult> RecommendedOfferList = [];
  bool isLoadRecommendedOffer = false;
  load(){
    DrawAuraAPi.getRecommendedOffer(limit: 0.toString()).then((RecommendedOfferRes) {
      if(RecommendedOfferRes.isNotEmpty){
        Future.delayed(Duration.zero,() {
          if (mounted) {
            setState(() {
              RecommendedOfferList = RecommendedOfferRes;
              isLoadRecommendedOffer = true;
            });
          }
        },);
      }else{
        if (mounted) {
          setState(() {
            isLoadRecommendedOffer = true;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
      body: responsiveContainer(context,
          ResponsiveHelper.isMobile(context)? Constants.newBackground : Constants.tabBackGroundColor,
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading:InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back,color: Colors.black,)),
                title: const Text("Recommended Offers",style:AppBarTitle,),
                elevation: 0,
              ),
              body:isLoadRecommendedOffer == false?Center(child: LoadingWidget(),):    RecommendedOfferList.isEmpty?
              Center(
                child:NotAvailableText("Not found!")
              ): RefreshIndicator(
                onRefresh: () async{
                  await load();
                  return Future.value();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: RecommendedOfferList.length,
                  itemBuilder: (context, index) {
                    var data = RecommendedOfferList[index];
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
                    List <bool>isAllItemDone1 = [] ;
                    for(var p = 0 ; p < data.offerData!.offerItems!.length ; p++){
                      if( data.offerData!.offerItems![p].quantity.toString().trim() == "0"){
                        print("");
                        isAllItemDone1.add(true);
                      }else{
                        isAllItemDone1.add(false);
                      }
                    }
                    return FutureBuilder(
                        future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                        builder: (BuildContext
                        context, AsyncSnapshot<String>snapshot) {
                          return CommonOfferCardListView(context,data,snapshot,
                            isCounterSellBuy,
                            RecommendedOfferList,index,
                                (){tapOnOffer(context,data,isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                  load();
                                });}, false,isAllItemDone1,isConfirmingUser
                          );
                        });
                  },
                ),
              )
          )),
    );
  }
  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
}
