import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/CommentsModel.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/RecentSearchModel.dart';
import 'package:socialapps/model/TrandingSearchModel.dart';
import 'package:socialapps/model/TrendingPersonModel.dart';

import '../Apis/CommonApis.dart';

class SearchPageController extends  GetxController {

  /// DashBoard Search
  final TrendingOfferList = <OfferDataModelResult>[].obs;
  final RecommendedOfferList = <OfferDataModelResult> [].obs;
  final RecentSearchList = <RecentSearchData> [].obs;
  final TrendingSearchDataList = <TrendingSearchData>[].obs;
  final TrendingPlacePeopleDataList = <TrendingPersonData>[].obs;
  final TemplateList = <OfferDataModelResult>[].obs;
  final getFavoriteOfferList = <OfferDataModelResult>[].obs;
  final getMyOffersList = <OfferDataModelResult>[].obs;
  final getMyCountersOffersList = <OfferDataModelResult>[].obs;
  final getMyConfirmedOffersList = <OfferDataModelResult>[].obs;
  final getRecentViewOfferList = <OfferDataModelResult>[].obs;
  final enableNotification = false.obs;

  // @override
  // void initState() {
  //   super.initState();
  //   getChoice();
  //   Timer(Duration(milliseconds: 500), () async {
  //     try {
  //       if (Platform.isAndroid) {
  //         await Permission.notification.isDenied.then((permission) async {
  //           if (permission) {
  //
  //             Notification_permission_dialog(context).then((Notify) async {
  //               if(mounted){
  //                 setState(() async {
  //                   enableNotification = await Permission.notification.isGranted;
  //                 });
  //               }
  //             });
  //           } else {
  //             if(mounted){
  //               setState(() {
  //                 enableNotification = true;
  //               });
  //             }
  //           }
  //         });
  //       } else {
  //         var permissionNotificationStatus = await Permission.notification.status;
  //
  //         if (!permissionNotificationStatus.isGranted) {
  //           Notification_permission_dialog(context).then((Notify) async {
  //             if(mounted){
  //               setState(() async {
  //                 enableNotification = await Permission.notification.isGranted;
  //               });
  //             }
  //           });
  //         } else {
  //           if(mounted){
  //             setState(() {
  //               enableNotification = true;
  //             });
  //           }
  //         }
  //
  //       }
  //     } catch (e) {
  //       print('error in catch init state ${e}');
  //     }
  //   });
  //   loadApi();
  //
  //   scrollCommentsController = ScrollController();
  // }

  // @override
  // void dispose() {
  //   scrollCommentsController.dispose();
  //   super.dispose();
  // }
  
  // bool isApiLoad = false;

  final butttonLoader = false.obs;
  final NavigateLoader = false.obs;
  final isLoadTrendingOffer = false.obs;
  final isLoadRecommendedOffer = false.obs;
  final isLoadRTrendingPlacedOffer = false.obs;
  final isLoadRRecentSearch = false.obs;
  final isLoadRTrendingSearch = false.obs;
  final getFavLoader = false.obs;
  final getMyOfferLoader = false.obs;
  final getMyCountersOfferLoader = false.obs;
  final getRecentViewOfferLoader = false.obs;

  // List<bool> isCounterSellBuyList = [];

  getRecommendedOffer() async {
    // isLoadRecommendedOffer(true);
    var BodyParam = {
      "user_id": DataManager.getInstance().getuserId().toString(),
      "limit" : "10"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getRecommendedOffer).then((value) {
      if(value != null ){
        RecommendedOfferList.value =  List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        RecommendedOfferList.value = [];
      }
    });
    isLoadRecommendedOffer(true);
  }
  getTreadingOffer() async {
    // isLoadRecommendedOffer(true);
    var BodyParam = {
      "user_id": DataManager.getInstance().getuserId().toString(),
      "limit" : "10"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getTrendingOffer).then((value) {
      if(value != null ){
        TrendingOfferList.value.clear();
        TrendingOfferList.value =  List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        TrendingOfferList.value = [];
      }
    });
    isLoadTrendingOffer(true);
  }
  getTemplates() async {
    // isLoadRecommendedOffer(true);
    var BodyParam = {
      "user_id": DataManager.getInstance().getuserId().toString(),
      "limit" : "10"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getTemplatesList).then((value) {
      if(value != null ){
        TemplateList.value =  List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        TemplateList.value = [];
      }
    });
    isLoadTrendingOffer(true);
  }
  getTrendingPerson() async {
    // isLoadRecommendedOffer(true);
    var BodyParam = {
      "limit" : "10",
      "user_id" :DataManager.getInstance().getuserId().toString()
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getTrendingPerson).then((value) {
      if(value != null ){
        TrendingPlacePeopleDataList.value =  List.from(value["result"]).map<TrendingPersonData>((item) => TrendingPersonData.fromJson(item)).toList();
      }else{
        TrendingPlacePeopleDataList.value = [];
      }
    });
    isLoadRTrendingPlacedOffer(true);
  }
  getRecentViewOffer() async {
    // isLoadRecommendedOffer(true);
    var BodyParam = {
      "user_id": DataManager.getInstance().getuserId().toString()
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getRecentViewOffer).then((value) {
      if(value != null ){
        getRecentViewOfferList.value =  List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        getRecentViewOfferList.value = [];
      }
    });
    getRecentViewOfferLoader(true);
  }
  TrendingSearch() async {
    var BodyParam = {
      "limit" : "0"
    };
    await  ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getTrendingSearches).then((value) {
      if(value != null ){
        TrendingSearchDataList.value =  List.from(value["result"]).map<TrendingSearchData>((item) => TrendingSearchData.fromJson(item)).toList();
      }else{
        TrendingSearchDataList.value = [];
      }
    });
    isLoadRTrendingSearch(true);
  }
  RecentSearch() async{
    var RBodyParam = {
      "user_id" :  DataManager.getInstance().getuserId().toString(),
      "limit" : "0"
    };

    await ThatZalApis.fromDataPost(BodyParam:RBodyParam,Endpoint: ApiUrls.getRecentSearches).then((value) {
      if(value != null ){
        List <RecentSearchData> TempList =  List.from(value["result"]).map<RecentSearchData>((item) => RecentSearchData.fromJson(item)).toList();
        RecentSearchList.value =  TempList.reversed.toList();
      }else{
        RecentSearchList.value = [];
      }
    });
    isLoadRRecentSearch(true);
  }
  final SearchOfferController = TextEditingController().obs;



  getChoice() async {
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();

    var saveChoice = sharedpreferences.getString("OfferChoice")??"";

    selectedChoiceList = saveChoice == "" ?[]: saveChoice.toString().contains(",") ? saveChoice.toString().split(','):["${saveChoice.toString()}"];
    selectedChoiceList.contains("YOUR FAVOURITES") ? DrawAuraAPi.getSubscriberFavouriteOfferApi(SubcriberId: DataManager.getInstance().getuserId().toString()).then((SubscriberFavouriteOfferRes) {
      if(SubscriberFavouriteOfferRes["status"] == "200") {
        OfferDataModel ? FavoriteOfferDetails;
        FavoriteOfferDetails = OfferDataModel.fromJson(SubscriberFavouriteOfferRes);
        getFavoriteOfferList.value = FavoriteOfferDetails.result!;
        getFavLoader(true);
      }
    }):null;

    selectedChoiceList.contains("YOUR OPEN OFFERS") || selectedChoiceList.contains("YOUR CONFIRMED OFFERS") ? DrawAuraAPi.getSubscriberOfferApi(SubcriberId:DataManager.getInstance().getuserId().toString()).then((SubscriberOfferRes) {
      if (SubscriberOfferRes["status"] == "200") {
        OfferDataModel? SubscriberOfferDetails;
        SubscriberOfferDetails = OfferDataModel.fromJson(SubscriberOfferRes);
        getMyOffersList.value = SubscriberOfferDetails.result!;
        getMyOfferLoader(true);
      }
    }
    ):null;

    selectedChoiceList.contains("YOUR COUNTERS") || selectedChoiceList.contains("YOUR CONFIRMED OFFERS") ?DrawAuraAPi.getSubscriberCounterOfferApi(SubcriberId: DataManager.getInstance().getuserId().toString()).then((SubscriberCounterOfferRes) {
      if (SubscriberCounterOfferRes["status"] == "200") {
        OfferDataModel ?SubscriberCouterOfferDetails;
        SubscriberCouterOfferDetails = OfferDataModel.fromJson(SubscriberCounterOfferRes);
        getMyCountersOffersList.value = SubscriberCouterOfferDetails.result!;
        getMyCountersOfferLoader(true);
      }
    }):null;

  }

  List <String> selectedChoiceList = [];
 

  /// all trending offers

   GetAllTrendingOffer() async {
    var BodyParam = {
      "user_id": DataManager.getInstance().getuserId().toString(),
      "limit" : "0"
     };
     await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getTrendingOffer).then((value) {
        if(value != null ){
          TrendingOfferList.value =  List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
        }else{
          TrendingOfferList.value = [];
        }
     });
     isLoadTrendingOffer(true);
  }

  late ScrollController scrollCommentsController;
  final messageController = TextEditingController().obs;
  final focusNode = FocusNode().obs;

  void scrollToBottom() {
    final bottomOffset = scrollCommentsController.position.maxScrollExtent;
    scrollCommentsController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
  
  
  /// Feed List Screen
  final feedListScrollController = ScrollController().obs;
  final isLoadFeedList = false.obs;
  final FeedList = <OfferDataModelResult>[].obs;
  final currentPage = 1.obs;
  final pageSize = 3.obs;
  final totalLength = 0.obs;
  final isPaginate = false.obs;


  getFeedList() async {
    currentPage.value = 1;
    String ApiUrl = "${ApiUrls.getFeedListV2}?page=${currentPage}&page_size=${pageSize}&user_id=${DataManager.getInstance().getuserId().toString()}";
    await ThatZalApis.getOfferData(Endpoint: ApiUrl).then((value) {
      if(value != null ){
        FeedList.clear();
        totalLength.value = int.parse(value["result"]["count"].toString());
        FeedList.value = List.from(value["result"]["results"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
      }
    });
    isLoadFeedList(true);
  }

  addFeedData() async {
    print("AddPAginationaCall");
    print(totalLength.value);
    feedListScrollController.value.addListener(() async {
      if (totalLength.value > FeedList.length) {
        if (feedListScrollController.value.position.maxScrollExtent == feedListScrollController.value.position.pixels) {
          isPaginate.value = true;
          currentPage.value++;
          String ApiUrl = "${ApiUrls.getFeedListV2}?page=${currentPage}&page_size=${pageSize}&user_id=${DataManager.getInstance().getuserId().toString()}";
          await ThatZalApis.getOfferData(Endpoint: ApiUrl).then((value) {
             if(value != null){

               if (value['result']["results"].isNotEmpty) {
                 // List <OfferDataModelResult> FeedListTemp = [];
                 // FeedListTemp = List.from(value["result"]["results"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
                 // FeedList.addAll(FeedListTemp);
                 FeedList.addAll(List.from(value["result"]["results"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList());
                 isPaginate.value = false;
                 update();
               } else {
                 isPaginate.value = false;
               }
             }
          });
        }
      }
    });
  }
}