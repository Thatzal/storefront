
import 'package:flutter/material.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:get/get.dart';
import 'package:socialapps/constant/loading.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/screens/widgets/CommonOfferCardBuilderAndTap.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/screens/widgets/commonCards.dart';
import '../../common/style.dart';
import 'package:socialapps/common/ResponsiveBuilder.dart';
import '../../controller/SearchPageController.dart';


class TrendingOffer extends StatelessWidget {
  const TrendingOffer({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var tabWidth = ResponsiveHelper.TabModeWidth;
    var height = MediaQuery.of(context).size.height;
    var tabHeight = ResponsiveHelper.TabModeHeight;
    var isMobile = ResponsiveHelper.isMobile(context);
    return GetX<SearchPageController>(
        init: SearchPageController(),
        initState: (value) async {
          Future.delayed(Duration.zero,() {
            value.controller!.isLoadTrendingOffer.value = false;
            value.controller!.GetAllTrendingOffer();
            value.controller!.scrollCommentsController = ScrollController();
          },);
        },
        // dispose: (value){
        //   value.controller!.scrollCommentsController.dispose();
        // },
        builder: (controller) {
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
                      title: const Text("Trending Offers",style:AppBarTitle,),
                      elevation: 0,
                    ),
                    body: controller.isLoadTrendingOffer.value == false ?
                    Center(
                      child: LoadingWidget(),
                    ) : controller.TrendingOfferList.isEmpty?
                    Center(
                      child: NotAvailableText("Not found!")
                    ) :   RefreshIndicator(
                      onRefresh: () async{
                       await controller.GetAllTrendingOffer();
                        return Future.value();
                      },
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.TrendingOfferList.length,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: isMobile ? 2 / 2.5 : 2 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data =controller.TrendingOfferList[index];
                            bool isConfirmingUser = false;
                            for (var i = 0; i < data.offerData!.ConfirmingSubscriber!.length; i++) {
                              if (data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()) {
                                isConfirmingUser = true;
                                break;
                              } else {
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
                                  return CommonVerticalForGridView(context,data,snapshot,
                                      isCounterSellBuy,
                                      controller.TrendingOfferList,index, (){tapOnOffer(context,data, isCounterSellBuy, isConfirmingUser,isAllItemDone1).then((value) {
                                        controller.GetAllTrendingOffer();
                                      });}, false,isAllItemDone1
                                      ,isConfirmingUser
                                  );
                                });
                          }),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: AlwaysScrollableScrollPhysics (),
                      //   itemCount: controller.TrendingOfferList.length,
                      //
                      //   itemBuilder: (context, index) {
                      //     var data = controller.TrendingOfferList[index];
                      //
                      //     bool isConfirmingUser = false;
                      //     for(var i = 0 ; i<data.offerData!.ConfirmingSubscriber!.length; i++){
                      //       if(data.offerData!.ConfirmingSubscriber![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                      //         isConfirmingUser = true;
                      //         break ;
                      //       }else{
                      //         isConfirmingUser = false;
                      //       }
                      //     }
                      //
                      //     bool  isCounterSellBuy = false ;
                      //     for(var i = 0 ; i<data.offerData!.counterdUser!.length; i++){
                      //       if(data.offerData!.counterdUser![i].id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
                      //         isCounterSellBuy = true;
                      //         break ;
                      //       }else{
                      //         isCounterSellBuy = false;
                      //       }
                      //     }
                      //     return FutureBuilder(
                      //         future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
                      //         builder: (BuildContext
                      //         context, AsyncSnapshot<String>snapshot) {
                      //           return CommonOfferCardListView(context,data,snapshot,
                      //             isCounterSellBuy,
                      //             controller.TrendingOfferList,index,
                      //                 (){tapOnOffer(context,data,isCounterSellBuy, isConfirmingUser);}, false,
                      //           );
                      //         });
                      //   },
                      // ),
                    )
                )),
          );
        }
    );
  }
}
