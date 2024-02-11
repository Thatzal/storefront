
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/common/style.dart';
import 'package:socialapps/constant/constatnt.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/controller/SearchPageController.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/PrefillOfferDataModel.dart';
import 'package:socialapps/model/filtterOfferDetailsModel.dart';
import 'package:socialapps/model/serviceAreaModel.dart';
import 'package:socialapps/screens/Dashboard/home/home_detail_screen.dart';
import 'package:socialapps/screens/OfferCounterPage.dart';
import 'package:socialapps/screens/updateOfferPage.dart';
import 'package:socialapps/screens/lastCounterScreen.dart';
import 'package:socialapps/screens/newOfferPage.dart';
import 'package:socialapps/screens/widgets/ImageGalleryByUrl.dart';
import 'package:socialapps/screens/widgets/commonCards.dart';



Widget DashBoardOfferBuilder({required List<OfferDataModelResult> offerList,required bool isYourOffer,required String Type ,required SearchPageController controller}) {
  final cards = <Widget>[];
  Widget FeautredCards;
  for(int index=0;index <offerList.length;index++){

    var data = offerList[index];

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
    cards.add(
        FutureBuilder(
         future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return CommonVerticalCard(context,data,snapshot,isCounterSellBuy,offerList,index,
              (){
                tapOnOffer(context,data,isCounterSellBuy,isConfirmingUser,isAllItemDone1).then((value) {
                   if(Type == "Fav"){
                     controller.getChoice();
                  }else if(Type == "Open"){
                     controller.getChoice();
                   }else if(Type == "Counter"){
                     controller.getChoice();
                   }else if(Type == "Trending"){
                     controller.getTreadingOffer();
                   }else if(Type == "Recommended"){
                     controller.getRecommendedOffer();
                   }else if(Type == "Recent"){
                     controller.getRecentViewOffer();
                   }
                });
              },isYourOffer,isAllItemDone1,isConfirmingUser

        );
      },
    ));
  }
  FeautredCards = Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards
            ),
          ),
        ),
      ],
    ),
  );
  return FeautredCards;
}

Widget DashBoardConfirmedOfferBuilder({ required List<OfferDataModelResult> getMyOffersList , required List<OfferDataModelResult> getMyCounterOffersList,required bool isYourOffer}) {
  final cards = <Widget>[];
  Widget FeautredCards;

  bool butttonLoader = false;
  List<OfferDataModelResult> BothOffer = [];
  BothOffer = getMyOffersList;
  BothOffer.addAll(getMyCounterOffersList);

  for(int index=0;index <BothOffer.length;index++){

    var data = BothOffer[index];

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

    cards.add(
        FutureBuilder(
          future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
           if(isConfirmingUser){
             return CommonVerticalCard(context,data,snapshot,isCounterSellBuy,BothOffer,index,
                     (){tapOnOffer(context,data,isCounterSellBuy,isConfirmingUser,isAllItemDone1);},isYourOffer,isAllItemDone1,
                 isConfirmingUser
             );
           }else{
             return SizedBox();
           }
          },
        ));
  }
  FeautredCards = Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards
            ),
          ),
        ),
      ],
    ),
  );
  return FeautredCards;
}


Widget DashBoardOfferTemplateBuilder({required List<OfferDataModelResult> offerList}) {
  final cards = <Widget>[];
  Widget FeautredCards;
  for(int index=0;index <offerList.length;index++){

    var data = offerList[index];

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
    cards.add(FutureBuilder(
      future: ThumImage(data.offerData!.offerItems!.first.itemMedia!.first.file),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return CommonVerticalCardTemplate(context,data,snapshot,isCounterSellBuy,offerList,index
        );
      },
    ));
  }
  FeautredCards = Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards
            ),
          ),
        ),
      ],
    ),
  );
  return FeautredCards;
}

Future<dynamic> tapOnOffer(context,OfferDataModelResult data,isCounterSellBuy,isConfirmingUser,List<bool> isAllItemDone1) async{
  var bodyVisit = {
    "offer": data.offerData!.id.toString(),
    "user" : DataManager.getInstance().getuserId().toString()
  };
  await DrawAuraAPi.CreateDataApi(body: bodyVisit,ApiEndPoint: "visitOnOffer").then((value) {});
  var body = {
    "offer_id": data.offerData!.id.toString(),
    "user_id" : DataManager.getInstance().getuserId().toString()
  };
  await DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount").then((value) {});
  if(isAllItemDone1.contains(false)){
    if(data.offerData!.offertemplate == true ){
      PreFillDetailsNavigateNewOffer(context,data);
    }else if(  data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED")
    {
      if(isConfirmingUser || data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
        if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
          if(data.offerData!.counterdUser!.isEmpty){
            PreFillDetailsNavigateNewOffer(context,data);
          }else{
            await Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()));
          }
        }
        else{
          if(isCounterSellBuy == true){
            if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
              Constants.showToast("You abused in this offer");
            }else{
              await Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),));
            }
          }

        }
      }

      else{
        PreFillDetailsNavigateNewOffer(context,data);
      }
    }
    else{
      if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
        if(data.offerData!.counterdUser!.isNotEmpty){
          await Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()))!.then((value) {
            // refreshTrendingRecommended();
          });
        } else {
          await Get.to(()=>UpdateOfferScreen(OfferData: data,))!.then((value) {
            // refreshTrendingRecommended();
          });
        }
      }
      else{
        if(isCounterSellBuy == true){
          if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
            Constants.showToast("You abused in this offer");
          }else{
            await  Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),))!.then((value) {
              //  refreshTrendingRecommended();
            });
          }
        } else{
          await Get.to(() => CreateOfferCounterScreen(OfferData: data))!.then((value) {
            // refreshTrendingRecommended();
          });
        }
      }
    }
  }else{
    if(isConfirmingUser){
      if(data.offerData!.offertemplate == true ){
        PreFillDetailsNavigateNewOffer(context,data);
      }else if(  data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED")
      {
        if(isConfirmingUser || data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
          if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
            if(data.offerData!.counterdUser!.isEmpty){
              PreFillDetailsNavigateNewOffer(context,data);
            }else{
              await Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()));
            }
          }
          else{
            if(isCounterSellBuy == true){
              if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
                Constants.showToast("You abused in this offer");
              }else{
                await   Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),))!.then((value) {
                  // refreshTrendingRecommended();
                });
              }
            }

          }
        }

        else{
          PreFillDetailsNavigateNewOffer(context,data);
        }
      }
      else{
        if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
          if(data.offerData!.counterdUser!.isNotEmpty){
            await Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()))!.then((value) {
              // refreshTrendingRecommended();
            });
          } else {
            await Get.to(()=>UpdateOfferScreen(OfferData: data,))!.then((value) {
              // refreshTrendingRecommended();
            });
          }
        }
        else{
          if(isCounterSellBuy == true){
            if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
              Constants.showToast("You abused in this offer");
            }else{
              await    Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),))!.then((value) {
                //  refreshTrendingRecommended();
              });
            }
          } else{
            await Get.to(() => CreateOfferCounterScreen(OfferData: data))!.then((value) {
              // refreshTrendingRecommended();
            });
          }
        }
      }
    }else{
      if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
        if(data.offerData!.counterdUser!.isEmpty){
          PreFillDetailsNavigateNewOffer(context,data);
        }else{
        await Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()));
        }
      }else{
          PreFillDetailsNavigateNewOffer(context,data);
      }
    }
  }
  return ;
}



// Future tapOnOffer(context,OfferDataModelResult data,isCounterSellBuy,isConfirmingUser,List<bool> isAllItemDone1) async{
//
//   var bodyVisit = {
//     "offer": data.offerData!.id.toString(),
//     "user" : DataManager.getInstance().getuserId().toString()
//   };
//   DrawAuraAPi.CreateDataApi(body: bodyVisit,ApiEndPoint: "visitOnOffer").then((value) {});
//   var body = {
//     "offer_id": data.offerData!.id.toString(),
//     "user_id" : DataManager.getInstance().getuserId().toString()
//   };
//   DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount").then((value) {});
//   if(isAllItemDone1.contains(false)){
//     if(data.offerData!.offertemplate == true ){
//       PreFillDetailsNavigateNewOffer(context,data);
//     }else if(  data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED")
//     {
//       if(isConfirmingUser || data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//         if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//           if(data.offerData!.counterdUser!.isEmpty){
//             PreFillDetailsNavigateNewOffer(context,data);
//           }else{
//             Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()));
//           }
//         }
//         else{
//           if(isCounterSellBuy == true){
//             if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
//               Constants.showToast("Your are abused for these offer");
//             }else{
//               Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),));
//             }
//           }
//
//         }
//       }
//
//       else{
//         PreFillDetailsNavigateNewOffer(context,data);
//       }
//     }
//     else{
//       if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//         if(data.offerData!.counterdUser!.isNotEmpty){
//           Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()))!.then((value) {
//             // refreshTrendingRecommended();
//           });
//         } else {
//           Get.to(()=>UpdateOfferScreen(OfferData: data,))!.then((value) {
//             // refreshTrendingRecommended();
//           });
//         }
//       }
//       else{
//         if(isCounterSellBuy == true){
//           if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
//             Constants.showToast("Your are abused for these offer");
//           }else{
//             Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),))!.then((value) {
//               //  refreshTrendingRecommended();
//             });
//           }
//         } else{
//           Get.to(() => CreateOfferCounterScreen(OfferData: data))!.then((value) {
//             // refreshTrendingRecommended();
//           });
//         }
//       }
//     }
//   }else{
//     if(isConfirmingUser){
//       if(data.offerData!.offertemplate == true ){
//         PreFillDetailsNavigateNewOffer(context,data);
//       }else if(  data.offerData!.offerstatus.toString().trim().toUpperCase() == "CLOSED")
//       {
//         if(isConfirmingUser || data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//           if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//             if(data.offerData!.counterdUser!.isEmpty){
//               PreFillDetailsNavigateNewOffer(context,data);
//             }else{
//               Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()));
//             }
//           }
//           else{
//             if(isCounterSellBuy == true){
//               if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
//                 Constants.showToast("Your are abused for these offer");
//               }else{
//                 Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),))!.then((value) {
//                   // refreshTrendingRecommended();
//                 });
//               }
//             }
//
//           }
//         }
//
//         else{
//           PreFillDetailsNavigateNewOffer(context,data);
//         }
//       }
//       else{
//         if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//           if(data.offerData!.counterdUser!.isNotEmpty){
//             Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()))!.then((value) {
//               // refreshTrendingRecommended();
//             });
//           } else {
//             Get.to(()=>UpdateOfferScreen(OfferData: data,))!.then((value) {
//               // refreshTrendingRecommended();
//             });
//           }
//         }
//         else{
//           if(isCounterSellBuy == true){
//             if(data.offerData!.abusedUser!.contains(num.parse(DataManager.getInstance().getuserId().toString()))){
//               Constants.showToast("Your are abused for these offer");
//             }else{
//               Get.to(()=>lastCounterScreen(OferId:data.offerData!.id.toString() ,to_Couter_Id:  data.offerData!.subscribers!.id.toString(),))!.then((value) {
//                 //  refreshTrendingRecommended();
//               });
//             }
//           } else{
//             Get.to(() => CreateOfferCounterScreen(OfferData: data))!.then((value) {
//               // refreshTrendingRecommended();
//             });
//           }
//         }
//       }
//     }else{
//       if(data.offerData!.subscribers!.id.toString().trim() == DataManager.getInstance().getuserId().toString().trim()){
//         if(data.offerData!.counterdUser!.isEmpty){
//           PreFillDetailsNavigateNewOffer(context,data);
//         }else{
//           Get.to(() => HomeDetailScreen(offerId: data.offerData!.id.toString()));
//         }
//       }else{
//         PreFillDetailsNavigateNewOffer(context,data);
//       }
//     }
//   }
// }




void tapOnTemplate(context,OfferDataModelResult data)async{
  var body = {
    "offer_id": data.offerData!.id.toString(),
    "user_id" : DataManager.getInstance().getuserId().toString()
  };
  DrawAuraAPi.CreateDataApi(body: body,ApiEndPoint: "updateOfferViewCount").then((value) {
    if( value["is_update"] == true){
    }
  });
  PreFillDetailsNavigateNewOffer(context,data);
}

void LongPressForDelete(context,data,{required List<OfferDataModelResult> offerList,index}) async{
  if(data.offerData!.subscribers!.id.toString() == DataManager.getInstance().getuserId().toString() && data.offerData!.offertemplate == true){
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
                    child: Text('DELETE OFFER TEMPLATE!',style: BlackFieldStyleBold,textAlign: TextAlign.center),
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
  }
}


void PreFillDetailsNavigateNewOffer(context,OfferDataModelResult data){
  final fromPeriodDate = data.offerData!.offerConditions!.fromperiod== null ?"":data.offerData!.offerConditions!.fromperiod.toString();
  final fromPeriodTime = data.offerData!.offerConditions!.fromperiodtime==null?"":data.offerData!.offerConditions!.fromperiodtime.toString();
  final toPeriodDate = data.offerData!.offerConditions!.toperiod == null ?"": data.offerData!.offerConditions!.toperiod.toString();
  final toPeriodTime = data.offerData!.offerConditions!.toperiodtime == null?"": data.offerData!.offerConditions!.toperiodtime.toString();
  List serviceTemp = jsonDecode("${data.offerData!.offerareas!.toString()}");
  List<ServiceAreaModel> serviceAreaList = serviceTemp.map((e) => ServiceAreaModel.fromJson(e)).toList();
  List<PrefillOfferBids>  FillBids = [];
  List<PrefillOfferItems>  FillItmsList = [];
  data.offerData!.offerBids!.forEach((element) {
    print(data.offerData!.offerBids![0].id);
    FillBids.add(
        PrefillOfferBids(
            id: element.id.toString(),
            comments:   element.comment.toString()
        ));
  });
  for(var j  = 0 ; j<data.offerData!.offerItems!.length;j++) {
    final ImageData = [];

    for(var k = 0 ; k< data.offerData!.offerItems![j].itemMedia!.length ; k++){
      ImageData.add({
        "id": "${data.offerData!.offerItems![j].itemMedia![k].id}",
        "file":"${data.offerData!.offerItems![j].itemMedia![k].file}",
        "name": "${data.offerData!.offerItems![j].itemMedia![k].name}",
      });
    }
    //   final imgBase64Str = data.offerData!.offerItems![j].itemMedia!.isEmpty?"": "${await networkImageToBase64('${Url.IMAGE_URL}${data.offerData!.offerItems![j].itemMedia![0].media}')}";
    final fromPeriodDate = data.offerData!.offerItems![j].offerItemConditions!.fromperiod== null ?"":data.offerData!.offerItems![j].offerItemConditions!.fromperiod.toString();
    final fromPeriodTime = data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime==null?"":data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime.toString();
    final toPeriodDate = data.offerData!.offerItems![j].offerItemConditions!.toperiod == null ?"": data.offerData!.offerItems![j].offerItemConditions!.toperiod.toString();
    final toPeriodTime = data.offerData!.offerItems![j].offerItemConditions!.toperiodtime == null?"": data.offerData!.offerItems![j].offerItemConditions!.toperiodtime.toString();
    FillItmsList.add(
        PrefillOfferItems(
            id: data.offerData!.offerItems![j].id,
            name: "${data.offerData!.offerItems![j].name.toString()}" ,
            addon:data.offerData!.offerItems![j].addon,
            desc: "${data.offerData!.offerItems![j].desc.toString()}",
            itemMedia: ImageData,
            offerItemConditions: PrefillOfferItemConditions(

              fromperiod: data.offerData!.offerItems![j].offerItemConditions!.fromperiod,
              toperiod: data.offerData!.offerItems![j].offerItemConditions!.toperiod,
              toperiodtime:data.offerData!.offerItems![j].offerItemConditions!.toperiodtime ,
              fromperiodtime: data.offerData!.offerItems![j].offerItemConditions!.fromperiodtime,
              id:  data.offerData!.offerItems![j].offerItemConditions!.id,
              priority: data.offerData!.offerItems![j].offerItemConditions!.priority == null ? "": data.offerData!.offerItems![j].offerItemConditions!.priority.toString(),
              periodicity:data.offerData!.offerItems![j].offerItemConditions!.periodicity == null ? "": data.offerData!.offerItems![j].offerItemConditions!.periodicity.toString(),
              duration:  data.offerData!.offerItems![j].offerItemConditions!.duration==null?"": data.offerData!.offerItems![j].offerItemConditions!.duration.toString(),
              fromlocation: data.offerData!.offerItems![j].offerItemConditions!.fromlocation == null ?"": data.offerData!.offerItems![j].offerItemConditions!.fromlocation.toString(),
              tolocation:data.offerData!.offerItems![j].offerItemConditions!.tolocation == null ?"": data.offerData!.offerItems![j].offerItemConditions!.tolocation.toString(),
              atlocation: data.offerData!.offerItems![j].offerItemConditions!.atlocation == null ?"": data.offerData!.offerItems![j].offerItemConditions!.atlocation.toString(),
              expiry:data.offerData!.offerItems![j].offerItemConditions!.expiry==null?"": data.offerData!.offerItems![j].offerItemConditions!.expiry.toString(),
              servicepersons: data.offerData!.offerItems![j].offerItemConditions!.servicepersons,
              timePeriod:  "${fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime}",
            ),
            price: data.offerData!.offerItems![j].price,
            unit:  PrefillUnit(
                id: data.offerData!.offerItems![j].unit!.id,
                name: data.offerData!.offerItems![j].unit!.name),
            quantity: data.offerData!.offerItems![j].quantity,
            required: data.offerData!.offerItems![j].required,
            toggleState: data.offerData!.offerItems![j].toggleState,
            advancePrice:  data.offerData!.offerItems![j].advancePrice,
            maintenancePrice: data.offerData!.offerItems![j].maintenancePrice,
            advanceUnit:FillAdvanceUnit(id: data.offerData!.offerItems![j].advanceUnit!.id,name: data.offerData!.offerItems![j].advanceUnit!.name),
            maintenanceUnit: FillMaintenanceUnit(id: data.offerData!.offerItems![j].maintenanceUnit!.id,name: data.offerData!.offerItems![j].maintenanceUnit!.name)
        ));
  }
  var preFillDetails = PrefillOfferDataModel(
    offerId:  data.offerData!.id.toString(),
      addres: data.offerData!.addres.toString(),
      buyORsell:   data.offerData!.buyORsell.toString(),
      category: FillCategory(
        id:  data.offerData!.category!.id,
        name: data.offerData!.category!.name,
      ),
      segment: FillSegment(
        name: data.offerData!.segment!.name,
        id:data.offerData!.segment!.id,
        category:data.offerData!.segment!.category,
      ),
      subsegment: FillSubsegment(
        id:     data.offerData!.subsegment!.id,
        name: data.offerData!.subsegment!.name,
        segment:data.offerData!.subsegment!.segment,
      ),
      offerConditions: PrefillOfferConditions(
        id: data.offerData!.offerConditions!.id.toString(),
        fromPeriod: data.offerData!.offerConditions!.fromperiod,
        toPeriod: data.offerData!.offerConditions!.toperiod,
        fromPeriodTime: data.offerData!.offerConditions!.fromperiodtime,
        toPeriodTime: data.offerData!.offerConditions!.toperiodtime,
        priority:data.offerData!.offerConditions!.priority.toString().trim(),
        periodicity: data.offerData!.offerConditions!.periodicity.toString().trim(),
        duration: data.offerData!.offerConditions!.duration,
        fromlocation:data.offerData!.offerConditions!.fromlocation,
        tolocation: data.offerData!.offerConditions!.tolocation,
        atlocation: data.offerData!.offerConditions!.atlocation,
        expiry: data.offerData!.offerConditions!.expiry,
        servicepersons:  data.offerData!.offerConditions!.servicepersons,
        timePeriod:fromPeriodTime=="" && fromPeriodDate=="" && toPeriodDate=="" && toPeriodTime==""?"": toPeriodDate != "" && toPeriodTime != ""?"From "+ fromPeriodDate+" " +  fromPeriodTime +" To " + toPeriodDate +" "+toPeriodTime :"From "+ fromPeriodDate+" " +  fromPeriodTime,
      ),
      tabactivity: "New",
      offerareas:  serviceAreaList,
      offerBids: FillBids,
      offerItems: FillItmsList,
      privacy: data.offerData!.privacy.toString()
  );
  Navigator.push(context, MaterialPageRoute(builder: (context) => NewOfferCreateScreen(Address: "",AddressTitle: "",From: "Fill",PrefillOfferData:preFillDetails ,Type:data.offerData!.offertemplate == true? "Template" :"" ,OfferId: data.offerData!.id.toString(),SubId: data.offerData!.subscribers!.id.toString()),));

}


// class TapOnOfferNew{
//
// }




