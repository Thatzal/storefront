import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:http/http.dart' as http;
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/CommentsModel.dart';
import 'package:socialapps/model/GetFeedScreenModal.dart';
import 'package:socialapps/model/GetFollowersListModel.dart';
import 'package:socialapps/model/GetFollowingListModal.dart';
import 'package:socialapps/model/GetNotificationsModal.dart';
import 'package:socialapps/model/GetSegmentListModal.dart';
import 'package:socialapps/model/GetSubscribePlanListModal.dart';
import 'package:socialapps/model/OfferDataModel.dart';
import 'package:socialapps/model/ServicePersonListModel.dart';
import 'package:socialapps/model/TrendingPersonModel.dart';
import 'package:socialapps/model/UnitListModel.dart';
import 'package:socialapps/model/classificationListModel.dart';
import 'package:socialapps/model/filtterOfferDetailsModel.dart';
import 'package:socialapps/model/getOfferCounteredOffersModel.dart';

import '../constant/constatnt.dart';
import '../controller/share_preferences.dart';
import '../model/GetAdressListModal.dart';
import '../model/GetAvailableUserNameListModel.dart';
import '../model/GetCategoryListModal.dart';
import '../model/GetPrivacyPolicyModal.dart';
import '../model/GetPushNotificationModal.dart';
import '../model/GetSubSegmentListModal.dart';
import '../model/RecentSearchModel.dart';
import '../model/TrandingSearchModel.dart';

class DrawAuraAPi{

  Future registrationApi({phonenumber,displayname}) async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/registration"),
        body: {
           "phonenumber":"$phonenumber",
          "displayname" : "$displayname"
        },
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }



  // Future otpVerifyApi({phonenumber,otp,displayName}) async {
  //   try{
  //     final response  = await http.post(Uri.parse("${Url.BASE_URL}/verifyOTP"),
  //       body: {"phonenumber":"$phonenumber","otp":"$otp","displayname":"${displayName}"},
  //     );
  //     var model = jsonDecode(response.body);
  //     return model;
  //   }catch(e){
  //     print(e);
  //   }
  // }

  Future otpLoginVerifyApi({phonenumber,otp,username}) async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/verifyLoginOTP"),
        body: {
        "phonenumber":"$phonenumber",
          "otp":"$otp",
          "username":"${username}"
        },
      );
      var model = jsonDecode(response.body);
      return model;
    }catch(e){
      print(e);
    }
  }

  Future loginApi({phonenumber,username,deviceToken}) async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/login"),
        body: {
        "phonenumber":"$phonenumber",
          "username":"$username",
          "deviceToken" : deviceToken
        },
      );
      var model =json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future checkUserNameApi({userName}) async {
    // print("username");
    // print(userName);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/checkUsername"),
        body: {"username":"$userName"},
      );
      var model =json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  static Future<GetAvailableUserNameListModel>availableUserNameListApi() async {
    var data;
    final response = await http.get(Uri.parse("${Url.BASE_URL}/usernameList"),
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes));
        // print("procut");
        // print(data);
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetAvailableUserNameListModel.fromJson(data);

  }

   Future updateSubscriberProfileApi({data}) async {
    // print("username");
    // print(userName);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/updateSubscriberProfile"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  static Future<GetSubscribePlanListApi>subscribePlanListApi() async {
    var data;
    final response = await http.get(Uri.parse("${Url.BASE_URL}/getPlanList"),
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes));
        print("Subscribe Plan List");
        print(data);
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetSubscribePlanListApi.fromJson(data);

  }

  Future subscribePlanApi({userId,planId}) async {
    print("api idd");
    print(userId);
    print(planId);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/subscribePlan"),
        body: {"user_id":userId.toString(),"plan_id":planId.toString()},
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future getUserSubscribedPlanApi() async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/getUserSubscribedPlan"),
        body: {"id": DataManager.getInstance().getuserId().toString() },
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  static  Future<dynamic> getFollowersList({userId}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/getFollowerList"),
        body: {"id":userId,},
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static  Future<dynamic> FollowUser({follower_id,following_id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/followSubscriber"),
        body: {
            "follower_id":follower_id.toString(),
            "following_id":following_id.toString(),
        },
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static  Future<dynamic> UnFollowUser({follower_id,following_id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/unfollowSubscriber"),
        body: {
          "follower_id":follower_id.toString(),
          "following_id":following_id.toString(),
        },
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody =json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static  Future<dynamic> likeUnlikeOffer({user_id,offer_id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/offerLikeUnlike"),
        body: {
          "user_id":user_id.toString(),
          "offer_id":offer_id.toString(),
        },
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static  Future<dynamic> disLikeOffer({user_id,offer_id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/offerDisLike"),
        body: {
          "user_id":user_id.toString(),
          "offer_id":offer_id.toString(),
        },
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }
  static  Future<dynamic> AddRemoveFavorite({user_id,offer_id}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/bookmarkOffer"),
        body: {
          "user_id":user_id.toString(),
          "offer_id":offer_id.toString(),
        },
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static  Future<dynamic> getSubscriberDetailsApi({userId}) async {
    try {
      print("${Url.BASE_URL}/getSubscriberDetails");
      final response = await http.post(Uri.parse("${Url.BASE_URL}/getSubscriberDetails"),
          body: {"id":userId,},
          // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static Future<dynamic> getUserAccountsApi({MobileNumber}) async {
    print("getUserAccountsApi");
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/getUserAccounts"),
        body: {"phonenumber":"$MobileNumber"},
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      log(response.toString());
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      print("responseBody");
      print(responseBody);
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static Future<dynamic> getSubscriberOfferApi({SubcriberId}) async {
    try {

      final response = await http.post(Uri.parse("${Url.BASE_URL}/getSubscriberOffers"),
        body:{"id":SubcriberId},
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static Future<dynamic> getSubscriberCounterOfferApi({SubcriberId}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/getSubscriberCounteredOffers"),
        body:{"id":SubcriberId},
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    }catch(e){
      print(e);
    }
  }
  static Future<dynamic> getSubscriberTemplateOfferApi({SubcriberId}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/getSubscriberTemplate"),
        body:{"id":SubcriberId},
        // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static Future<dynamic> getSubscriberFavouriteOfferApi({SubcriberId}) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/getSubscriberFavouriteOffers"),
        body:{"id":SubcriberId},
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print("getSubscriberFavouriteOffers");

        return responseBody;

      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  // static Future<dynamic> getTrendingOffer() async {
  //   final client = http.Client();
  //   try {
  //     final response = await client.post(Uri.parse("${Url.BASE_URL}/getTrendingOffers"),
  //     );
  //     Map<String, dynamic> responseBody = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       return responseBody;
  //     }else{
  //       Constants.showToast(responseBody["message"]);
  //       return;
  //     }
  //   } catch(e){
  //     print(e);
  //   }
  // }
  static Future<List<OfferDataModelResult>> getRecentViewOffer() async {
    final client = http.Client();
    http.Response ?response ;
    try {
      response = await client.post(Uri.parse("${Url.BASE_URL}/offerVisitRecords"),
        body:{"user_id": DataManager.getInstance().getuserId().toString(),},
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(utf8.decode(response!.bodyBytes));
   print("REcentView");
   print(responseBody);
    if (response.statusCode == 200) {
      return List.from(responseBody["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
    }else{
      Constants.showToast(responseBody["message"]);
      return [];
    }
  }

  static Future<List<OfferDataModelResult>> getTrendingOffer({limit}) async {
    final client = http.Client();
    http.Response ?response ;
    try {
      response = await client.post(Uri.parse("${Url.BASE_URL}/getTrendingOffers"),
        body:{"user_id": DataManager.getInstance().getuserId().toString(),
          "limit" : limit
        },
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(utf8.decode(response!.bodyBytes));

    if (response.statusCode == 200) {
      return List.from(responseBody["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
    }else{
      Constants.showToast(responseBody["message"]);
      return [];
    }
  }

  static Future<List<OfferDataModelResult>> getRecommendedOffer({limit}) async {
    final client = http.Client();
    http.Response ?response ;
    try {
       response = await client.post(Uri.parse("${Url.BASE_URL}/getRecommendedOffers"),
         body:{"user_id": DataManager.getInstance().getuserId().toString(),
           "limit" : limit
         },
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(utf8.decode(response!.bodyBytes));
   print("getRecommendedOffersRes");

    if (response!.statusCode == 200) {
      return List.from(responseBody["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();

    }else{
      Constants.showToast(responseBody["message"]);
      return [];
    }
  }

  static Future<List<OfferDataModelResult>> getTemplateList({limit}) async {
    final client = http.Client();
    http.Response ?response ;
    try {
      response = await client.post(Uri.parse("${Url.BASE_URL}/getTemplatesList"),
        body:{"user_id": DataManager.getInstance().getuserId().toString(),
          "limit" : limit
        },
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(utf8.decode(response!.bodyBytes));
    print("getTemplatesListRes");

    if (response.statusCode == 200) {
      return List.from(responseBody["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
    }else{
      Constants.showToast(responseBody["message"]);
      return [];
    }
  }

  static Future<dynamic> getOfferIntermediatDetails({offer_id}) async {
    print("InterMidiatedPage");
    print(offer_id);
    final client = http.Client();
    try {
      final response = await client.post(Uri.parse("${Url.BASE_URL}/getOfferIntermediatDetails"),
        body:{"offer_id": offer_id},
      );
    var data =  json.decode(utf8.decode(response.bodyBytes));
print("InterMidiatedPageRes");
print(data);
      if (response.statusCode == 200) {
        return data;
      }else{
        Constants.showToast(data["message"]);
        return;
      }
    }catch(e){
      print(e);
    }
  }

  static Future<http.StreamedResponse> updateSubscriberProfileManageProfileApi({data,profileImage,backImage}) async {
    var request = http.MultipartRequest('POST', Uri.parse("${Url.BASE_URL}/updateSubscriberProfile"));
    request.fields.addAll(data);
    profileImage==null?null: request.files.add(await http.MultipartFile.fromPath("profile_picture",profileImage));
    backImage==null?null: request.files.add(await http.MultipartFile.fromPath("page_picture",backImage));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);
    try{
      var model= jsonDecode(res.body);
      var OtpRes= jsonDecode(res.body);
      if(response.statusCode==200){
        print(model);
        SharePre.setUserImage(model["result"]["profile_picture"].toString());
        DataManager.getInstance().setuserImage(model["result"]["profile_picture"].toString());

        SharePre.setUserId(OtpRes["result"]["id"].toString());
        SharePre.setUserName(OtpRes["result"]["username"].toString());
        SharePre.setUserMobile(OtpRes["result"]["phonenumber"].toString());
        SharePre.setUserEmail(OtpRes["result"]["email"].toString());
        SharePre.setUserImage(OtpRes["result"]["profile_picture"].toString());
        SharePre.setOfferingArea(OtpRes["result"]["Current_Location"].toString());
        SharePre.setUserDisplayName(OtpRes["result"]["displayname"].toString());
        SharePre.setUserIsPlaceType(OtpRes["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
        DataManager.getInstance().setuserId(OtpRes["result"]["id"].toString());
        DataManager.getInstance().setuserName(OtpRes["result"]["username"].toString());
        DataManager.getInstance().setphonedata(OtpRes["result"]["phonenumber"].toString());
        DataManager.getInstance().setuserEmail(OtpRes["result"]["email"].toString());
        DataManager.getInstance().setuserImage(OtpRes["result"]["profile_picture"].toString());
        DataManager.getInstance().setOfferArea(OtpRes["result"]["Current_Location"].toString());
        DataManager.getInstance().setUserDisplayName(OtpRes["result"]["displayname"].toString());
        DataManager.getInstance().setUserIsPlaceType(OtpRes["result"]["placeORperson"].toString().toUpperCase().trim() == "PERSON" ? "false":"true");
        DataManager.getInstance().setUserSecMobile(OtpRes["result"]["additionalnumber"].toString());
        SharePre.setUserSecMobile(OtpRes["result"]["additionalnumber"].toString());
        Fluttertoast.showToast(
            msg: model["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18.0
        );
      }else{
        Fluttertoast.showToast(
            msg: model["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0
        );
      }
    }catch(e){
      print(e.hashCode);
    }
    return response;
  }

  Future addShcoolDetailsApi({data}) async {
    // print("username");
    // print(userName);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/addSubscriberSchoolStudy"),
        body: data,
      );
      var model =json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future addCollageDetailsApi({data}) async {
    // print("username");
    // print(userName);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/addSubscriberCollegeStudy"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future addSubscribersWorkApi({data}) async {
    // print("username");
    // print(userName);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/addSubscribersWork"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future addSubscribersCertificationApi({data}) async {
    // print("username");
    // print(userName);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/addSubscribersCertification"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  static Future <GetCategoryList> getCategoryListApi() async {
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getCategoryList"),
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes));
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetCategoryList.fromJson(data);
  }

  Future createCategoryApi({data}) async {
    print("Category");
    print(data);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/createCategory"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future createSegmentApi({data}) async {
    print("Segment");
    print(data);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/createSegment"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future createSubSegmentApi({data}) async {
    print("SubSegment");
    print(data);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/createSubSegment"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      print(model);
      return model;
    }catch(e){
      print(e);
    }
  }

  static Future <GetSegmentListModal> getSegmentListApi({catId}) async {
    print("Category Id");
    print(catId);
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getSegmentList"),
        body:{"id":catId},
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes)
        );
        // print("GetSegmentList");
        // print(data);
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetSegmentListModal.fromJson(data);
  }

  Future <GetSubSegmentListModal> getSubSegmentListApi({segId}) async {
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getSubSegmentList"),
      body:{"id":segId},
    );
    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes)
        );
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetSubSegmentListModal.fromJson(data);
  }

  static Future <GetFollowersListModel> getFollowersListApi({UserId}) async {
    // print("Category Id");
    // print(segId);
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getFollowerList"),
      body:{"id":UserId },
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes)
        );
        // print("GetSegmentList");
        // print(data);
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetFollowersListModel.fromJson(data);
  }

  static Future <GetFollowingListModal> getFollowingListApi() async {
    // print("Category Id");
    // print(segId);
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getFollowingList"),
      body:{"id":DataManager.getInstance().userId.toString()},
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes)
        );
        // print("GetSegmentList");
        // print(data);
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetFollowingListModal.fromJson(data);
  }

   Future createAdressApi({adress}) async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/createAddress"),
        body: adress,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  static Future getPrivacyPolicyApi() async {
    var data;
    final response = await http.get(Uri.parse("${Url.BASE_URL}/getPrivacyPolicy"),
    );

    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes));

      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return data;

  }

  static Future getTermsConditionsApi() async {
    var data;
    final response = await http.get(Uri.parse("${Url.BASE_URL}/getTermsAndConditions"),
    );
    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes));
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return data;

  }

  Future <GetAdressListModal> getAdressListApi() async {
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getAddressList"),
      body:{"id":DataManager.getInstance().userId.toString()},
    );
    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes)
        );
        print("GetAddressData");
        print(data);
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetAdressListModal.fromJson(data);
  }

  Future unfollowSubscriberApi({ids}) async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/unfollowSubscriber"),
        body: ids,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  Future <GetPushNotificationModal> getPushNotificationApi() async {

    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getPushNotificationSettings"),
      body:{"id":DataManager.getInstance().userId.toString()},
    );
    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes)
        );
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return GetPushNotificationModal.fromJson(data);
  }

  Future updatePushNotificationSettingsApi ({notifyValue}) async {
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/updatePushNotificationSettings"),
        body: notifyValue,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      print(model);
      return model;
    }catch(e){
      print(e);
    }
  }

  Future<dynamic> createOffer(Map<String, dynamic> bodyParams) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/createOffer"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bodyParams));
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      print("responseBody");
      log(responseBody.toString());
      // Constants.showToast(responseBody['message']);
      return response;
    } catch(e){
      print(e);
    }
  }

  Future<dynamic> UpdateOfferDetails(Map<String, dynamic> bodyParams) async {

    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/updateOffer"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bodyParams));
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      print("UpdateData responseBody");
      print(responseBody);
      // Constants.showToast(responseBody['message']);
      return response;
    }catch(e){
      print(e);
    }
  }

  Future<dynamic> createOfferCounter(Map<String, dynamic> bodyParams) async {
       print("Create counter param");
       print(bodyParams.toString());
       log(bodyParams.toString());
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/createCounterOffer"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bodyParams));
      Map<String, dynamic> responseBody =json.decode(utf8.decode(response.bodyBytes));
      print(responseBody);
      // Constants.showToast(responseBody['message']);
      return response;
    } catch(e){
      print(e);
    }
  }

  Future<dynamic> updateCounterOffer(Map<String, dynamic> bodyParams) async {
    try {
      final response = await http.post(Uri.parse("${Url.BASE_URL}/updateCounterOffer"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bodyParams));
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      print(responseBody);
      print(responseBody);
      // Constants.showToast(responseBody['message']);
      return response;
    } catch(e){
      print(e);
    }
  }

  // Future<http.Response> GetDataApi({Endpoint}) async{
  //   var data ;
  //   try{
  //    data = await http.post(Uri.parse("${Url.BASE_URL}/$Endpoint"),);
  //   }catch(e){
  //     print(e);
  //   }
  //   return data;
  // }

  Future updateAddressApi(body) async {
    var data;

    final response  = await http.post(Uri.parse("${Url.BASE_URL}/updateAddress"),
      body : body,
    );
    print(response.body);
    data= jsonDecode(response.body);
    if(response.statusCode==200){
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    }else{
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return data;
  }

  Future deleteAddressApi(String id) async{
    var data;
    var body={
      "id":id.toString(),
    };
    print(body);
    final response = await http.post(Uri.parse('${Url.BASE_URL}/deleteAddress'),
      body : body,
    );
    print(response.body);
    data= jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    }else{
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
   }
    }

  Future<http.Response> getSearchData(String latter) async {
     var body = {
       "searchText" : latter,
       "user_id": DataManager.getInstance().getuserId().toString()
     };
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/searchOffer"),
          body: {
             "searchText" : latter,
             "user_id": DataManager.getInstance().getuserId().toString()
          });
        return response;
        //return List.from(responseBody['data']).map<SerachDataModel>((item) => SerachDataModel.fromJson(item)).toList();
    }

  Future<http.Response> getLastCounterOffer({offer_id,to_counter}) async {
    var body = {
      "offer_id" : "$offer_id",
      "from_counter" : DataManager.getInstance().getuserId(),
      "to_counter": to_counter
    };
    print(body);
    print("LastCounterBody");
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getLastCounterOffer"),
        body: body
    );
    print(response);
    return response;
    //return List.from(responseBody['data']).map<SerachDataModel>((item) => SerachDataModel.fromJson(item)).toList();
  }

  Future<List<GetOfferCounteredOffersModelResult>> getOfferCounteredOffers({offer_id,to_counter}) async {
    var body = {
      "offer_id" : "$offer_id",
      "from_counter" : DataManager.getInstance().getuserId(),
      "to_counter": to_counter
    };
    print(body);
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getOfferCounteredOffers"),
        body: body
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<GetOfferCounteredOffersModelResult>((item) => GetOfferCounteredOffersModelResult.fromJson(item)).toList();
  }

  static Future<dynamic> getCounterOfferDetails({offer_id}) async {

    final client = http.Client();
    try {
      final response = await client.post(Uri.parse("${Url.BASE_URL}/getCounterOfferDetails"),
        body:{"id": offer_id},
      );
      var data =   json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return data;
      }else{
        Constants.showToast(data["message"]);
        return;
      }
    }catch(e){
      print(e);
    }
  }

  static Future<dynamic> getOfferDetails({offer_id}) async {
    final client = http.Client();
    try {
      final response = await client.post(Uri.parse("${Url.BASE_URL}/getOfferDetails"),
        body:{"id": offer_id},
      );
      var data =   json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return data;
      }else{
        Constants.showToast(data["message"]);
        return;
      }
    }catch(e){
      print(e);
    }
  }

  Future<List<CommentsDataList>> getOfferCommentsList({offer_id}) async {
    var body = {
      "offer_id" : "$offer_id"
    };
    print(body);
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getOfferComments"),
        body: body
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<CommentsDataList>((item) => CommentsDataList.fromJson(item)).toList();
  }

  static Future <dynamic>CreateOfferComments({offer_id,user_id,Comments}) async{
    var body = {
      "offer" : offer_id,
      "user" : user_id,
      "comment" : Comments,
    };
      final client = http.Client();
      try {
        final response = await client.post(Uri.parse("${Url.BASE_URL}/createCommentReply"),
          body: body,
        );
        Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
        if (response.statusCode == 200) {
          return responseBody;
        }else{
          Constants.showToast(responseBody["message"]);
          return;
        }
      } catch(e){
        print(e);
      }
  }

  static Future <dynamic>SendExecutionNotification({offer_id,user_id,counter_id,type,message}) async{
    var body = {
      "user_id" : user_id,
      "offer_id" : offer_id,
      "counter_id" : counter_id,
      "type" : type,
      "message" : message,
    };
    print("SendExecutionNotificationBody");
    print(body);
    final client = http.Client();
    try {
      final response = await client.post(Uri.parse("${Url.BASE_URL}/sendPushNotification"),
        body: body,
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }


  static Future<List<TrendingSearchData>> GetTrendingSearch({limit}) async {

    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getTrendingSearches"),
      body: {
        "limit" : limit
      }
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<TrendingSearchData>((item) => TrendingSearchData.fromJson(item)).toList();
  }

  static Future<List<RecentSearchData>> GerRecentSearch({user_Id,limit}) async {
    var body = {
      "user_id" : "$user_Id",
      "limit" : limit
    };
    print(body);
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getRecentSearches"),
        body: body
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<RecentSearchData>((item) => RecentSearchData.fromJson(item)).toList();
  }

  static Future<List<OfferDataModelResult>> GetFeedList({user_Id}) async {
    var body = {
      "user_id" : "$user_Id"
    };
    print(body);
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getFeedsList"),
        body: body
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
  }

  static Future <dynamic>CreateSearchHistory({search_text}) async{
    var body = {
      "search_text" : search_text.toString(),
      "subscriber" : DataManager.getInstance().getuserId().toString()
    };
    final client = http.Client();
    try {
      final response = await client.post(Uri.parse("${Url.BASE_URL}/createSearchHistory"),
        body: body,
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static Future<List<NotificationListModel>> getNotificationsListApi({user_Id}) async {
    var body = {
      "user_id" : user_Id.toString()
    };
    print(body);
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getNotificationList"),
        body: body
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<NotificationListModel>((item) => NotificationListModel.fromJson(item)).toList();
  }

  static Future <dynamic>changeOfferStatus({offerId,CLOSED}) async{
    var body = {
      "offer_id": offerId,
      "status": CLOSED
    };
    print(body);
    final client = http.Client();
    try {
      final response = await client.post(Uri.parse("${Url.BASE_URL}/changeOfferStatus"),
        body: body,
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

  static Future<List<TrendingPersonData>> getTrendingPersonPlace({limit}) async {
    final response  = await http.post(Uri.parse("${Url.BASE_URL}/getTrendingPeopleOrPlace"),
      body: {
        "limit" : limit,
        "user_id" :DataManager.getInstance().getuserId().toString()
      }
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    print(response);
    return List.from(data["result"]).map<TrendingPersonData>((item) => TrendingPersonData.fromJson(item)).toList();
  }

  static Future<List<ServicePersonListModel>> GetServicePersonList() async {
    final client = http.Client();

    final response = await client.post(Uri.parse("${Url.BASE_URL}/getServicePersonsList"),);

    var data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return List.from(data["result"]).map<ServicePersonListModel>((item) => ServicePersonListModel.fromJson(item)).toList();
    }else{
      Constants.showToast(data["message"]);
      return <ServicePersonListModel>[];
    }


  }

  static Future <UnitListModel> getUnitList() async {
    var data;
    final response = await http.post(Uri.parse("${Url.BASE_URL}/getUnitList"),
    );
    try {
      if (response.statusCode == 200) {
        data = json.decode(utf8.decode(response.bodyBytes));
      }
      else {
        throw Exception('Failed to load post');
      }
    }catch(e){
      print(e);
    }
    return UnitListModel.fromJson(data);
  }

  Future createUnitApi({data}) async {
    print("UniParam");
    print(data);
    try{
      final response  = await http.post(Uri.parse("${Url.BASE_URL}/createUnit"),
        body: data,
      );
      var model = json.decode(utf8.decode(response.bodyBytes));
      return model;
    }catch(e){
      print(e);
    }
  }

  static Future <dynamic> GetListData({body,ApiEndPoint}) async {

    final client = http.Client();
    try{
      final response = await client.post(Uri.parse("${Url.BASE_URL}/$ApiEndPoint"),
       body: body,
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }

  }

  static Future<List<ClassificationListModel>> getClassificationAPi({Endpoint,BodyParam}) async {
    final client = http.Client();
    List<ClassificationListModel> ClassificationList= [];
    http.Response ?response ;
    print("Endpoint");
    print(Endpoint);
    try {
      response = await client.post(Uri.parse("$Endpoint"),
        body:BodyParam,
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(response!.body);
       print("responseBody");
       print(responseBody);
    if (response.statusCode == 200) {
      ClassificationList = List.from(responseBody["data"]).map<ClassificationListModel>((item) => ClassificationListModel.fromJson(item)).toList();
      return ClassificationList;
    }else{
      Constants.showToast(responseBody["message"]);
      return ClassificationList;
    }
  }

  static Future CreateDataApi({body,ApiEndPoint}) async {
    print(body);
    print("APIBodyParam");
    final client = http.Client();
    try{
      final response = await client.post(Uri.parse("${Url.BASE_URL}/$ApiEndPoint"),
        body: body,
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }


  static Future<http.StreamedResponse> KycDocUploadApi({data,frontImage,backImage,EndPoint}) async {
    var request = http.MultipartRequest('POST', Uri.parse("${Url.BASE_URL}/$EndPoint"));
    request.fields.addAll(data);
    frontImage==null?null: request.files.add(await http.MultipartFile.fromPath("kyc_image_front",frontImage));
    backImage==null?null: request.files.add(await http.MultipartFile.fromPath("kyc_image_back",backImage));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);
    try{
      var model= jsonDecode(res.body);
      if(response.statusCode==200){
        Fluttertoast.showToast(
            msg: model["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18.0
        );
      }else{
        Fluttertoast.showToast(
            msg: model["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.0
        );
      }
    }catch(e){
      print(e.hashCode);
    }
    return response;
  }

  static Future UpdateImageMultiPart({data,ImagePath,imageName}) async {
    var request = http.MultipartRequest('POST', Uri.parse("${Url.BASE_URL}/updateSubscriberProfile"));
    request.fields.addAll(data);
    ImagePath==null?null: request.files.add(await http.MultipartFile.fromPath("$imageName",ImagePath));

    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);
    var model= jsonDecode(res.body);
    SharePre.setUserImage(model["result"]["profile_picture"].toString());
    DataManager.getInstance().setuserImage(model["result"]["profile_picture"].toString());
    return model;
  }

  static Future  GetListFromParam({ApiEndPoint}) async {
    List Temp =[];
    print(ApiEndPoint);
    final client = http.Client();
    try{
      final response = await client.post(Uri.parse("${Url.BASE_URL}/$ApiEndPoint"),
      );
      Temp = json.decode(utf8.decode(response.bodyBytes));
      return Temp;
      // if (response.statusCode == 200) {
      //
      // }else{
      //   Constants.showToast(Temp.toString());
      //   return;
      // }
    } catch(e){
      print(e);
    }

  }

  static Future<List<FiltterOfferDetailsModel>> GetFilterOfferListFromParam(EndPoint) async {
    final client = http.Client();
    print(EndPoint);
    final response = await client.get(Uri.parse("${Url.BASE_URL}/$EndPoint"),);

    var data = json.decode(utf8.decode(response.bodyBytes));
    print(data.toString());
    if (response.statusCode == 200) {
      return List.from(data).map<FiltterOfferDetailsModel>((item) => FiltterOfferDetailsModel.fromJson(item)).toList();
    }else{
      Constants.showToast("Something went wrong");
      return <FiltterOfferDetailsModel>[];
    }
  }

  // static Future<List<OfferDataModelResult>> GetFilterOfferListFromParam(EndPoint) async {
  //   final client = http.Client();
  //   print(EndPoint);
  //   final response = await client.get(Uri.parse("${Url.BASE_URL}/$EndPoint"),);
  //
  //   var data = json.decode(utf8.decode(response.bodyBytes));
  //   print(data.toString());
  //   if (response.statusCode == 200) {
  //     return List.from(data).map<OfferDataModelResult>((item) => OfferDataModelResult.fromJson(item)).toList();
  //   }else{
  //     Constants.showToast("Something went wrong");
  //     return <OfferDataModelResult>[];
  //   }
  // }

  static Future TextModeration({body,ApiEndPoint}) async {

    final client = http.Client();
    try{
      final response = await client.post(Uri.parse("${Url.RefuseContentCheck}"),
        body: body,
      );
      Map<String, dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        print(responseBody);
        return responseBody;
      }else{
        Constants.showToast(responseBody["message"]);
        return;
      }
    } catch(e){
      print(e);
    }
  }

}

Future <String> getAddressFromLatLong(String Lat, String Long) async{
  final client = http.Client();
  final response = await client.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$Lat,$Long&sensor=false&key=${ApiUrls.mapKey}"));
  var data = json.decode(utf8.decode(response.bodyBytes));
  return data["results"][0]["formatted_address"].toString();
}