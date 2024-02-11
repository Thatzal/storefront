import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/getSubrciberDetailsModel.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController with GetSingleTickerProviderStateMixin{


  final List<Tab> myTabs = <Tab>[
    Tab(text: "My Offers"),
    Tab(text: "Templates"),
    Tab(text: "Favourites"),
  ].obs;

  late final tabController;

  @override
  void onInit() {

    super.onInit();
    print("OnInit");
    tabController = TabController(vsync: this, length: myTabs.length);

  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }


/// Comment on Offer

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





  final filter = ['New', 'Answer', 'Query', 'Sign-Off'].obs;

  final selectedItems = [].obs;
  final SelectedFilter = "NEW".obs;


  /// New Home Page APIs
  final  SubscriberDetails = getSubscriberDetailsResult().obs;
  final isGetSubscriberDetails = false.obs;

  final selectedUserValue = GetUserAccountResult().obs;
  final getUserAccountList = <GetUserAccountResult>[].obs;
  final isGetSubscriberAccounts = false.obs;

  final  getMyOffersList = <OfferDataModelResult>[].obs;
  final getMyOffersListFilter = <OfferDataModelResult>[].obs;
  final getMyCounterOffersList = <OfferDataModelResult>[].obs;

  final isGetSubscriberOffer = false.obs;
  final isGetSubscriberCounterOffer = false.obs;

  final getFavoriteOfferList = <OfferDataModelResult>[].obs;
  final getTemplateOfferList = <OfferDataModelResult>[].obs;

  final isGetSubscriberTemplates = false.obs;
  final isGetSubscriberFavOffer = false.obs;

  final IsuploadingProfileImage = false.obs;
  final IsuploadingCoverImage = false.obs;
  final butttonLoader = false.obs;
  final accountSwitchLoader = false.obs;

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final token = ''.obs;
  final backPageImage = "".obs;
  final followersCount = "".obs;
  final followingCount = "".obs;
  final placeOrperson = "".obs;
  final username = "".obs;
  final  userProfileImage  = "".obs;

  final listGrid = false.obs;

  getUserDetails() async {
    // isLoadRecommendedOffer(true);
    var BodyParam = {
     "id":DataManager.getInstance().getuserId().toString()
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getSubscriberDetails).then((value) {

      if(value != null ){
        SubscriberDetails.value = getSubscriberDetailsResult.fromJson(value["result"]);

        username.value = SubscriberDetails.value.username == null ? "" : SubscriberDetails.value.username.toString();
        placeOrperson.value = SubscriberDetails.value.placeORperson == null ? "" : SubscriberDetails.value.placeORperson.toString();
        followersCount.value = SubscriberDetails.value.followers == null ? "0" : SubscriberDetails.value.followers.toString();
        followingCount.value = SubscriberDetails.value.following == null ? "0" : SubscriberDetails.value.following.toString();
        userProfileImage.value = SubscriberDetails.value.profilePicture == null ? "" : SubscriberDetails.value.profilePicture.toString();
        backPageImage.value = SubscriberDetails.value.pagePicture == null ? "" : SubscriberDetails.value.pagePicture.toString();



      }else{
        SubscriberDetails.value = getSubscriberDetailsResult();
      }
    });
    isGetSubscriberDetails(true);
  }
  getUserAccounts() async {
    var BodyParam = {
      "phonenumber":"${DataManager.getInstance().getphonedata().toString()}"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getUserAccounts).then((value) {
      if(value != null ){
        getUserAccountList.value = List.from(value["result"]).map<GetUserAccountResult>((item) => GetUserAccountResult.fromJson(item)).toList();
        for (var i = 0; i < getUserAccountList.length; i++) {
          if (getUserAccountList[i].id.toString().trim() ==
              DataManager.getInstance().getuserId().toString()) {
            selectedUserValue.value = getUserAccountList[i];
            break;
          }
        }
      }else{
        getUserAccountList.value = [];
      }
    });
    isGetSubscriberAccounts(true);
  }

  getUserOffer() async {
    var BodyParam = {
      "id":"${DataManager.getInstance().getuserId().toString()}"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getSubscriberOffers).then((offerData) {

      if(offerData != null ){
        getMyOffersList.value = List.from(offerData["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        getMyOffersList.value = [];
      }
      isGetSubscriberOffer(true);
    });

    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getSubscriberCounteredOffers).then((value) {
      print("Counter MainOfferData");
      print(value);
      if(value != null ){
        getMyCounterOffersList.value =  List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
        getMyOffersList.addAll(getMyCounterOffersList);
      }
    });
    isGetSubscriberCounterOffer(true);
  }

  getUserTemplateOffer() async {
    var BodyParam = {
      "id":"${DataManager.getInstance().getuserId().toString()}"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getSubscriberTemplate).then((value) {
      if(value != null ){
        getTemplateOfferList.value = List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        getTemplateOfferList.value =  [];
      }
      isGetSubscriberTemplates(true);
    });
  }
  getUserFavOffer() async {
    var BodyParam = {
      "id":"${DataManager.getInstance().getuserId().toString()}"
    };
    await ThatZalApis.fromDataPost(BodyParam:BodyParam,Endpoint: ApiUrls.getSubscriberFavouriteOffers).then((value) {
      if(value != null ){
        getFavoriteOfferList.value = List.from(value["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
      }else{
        getFavoriteOfferList.value =  [];
      }
      isGetSubscriberFavOffer(true);
    });
  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

}