import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialapps/Apis/CommonApis.dart';
import 'package:socialapps/Apis/api.dart';
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/controller/DataManager.dart';
import 'package:socialapps/model/GetUserAccountModal.dart';
import 'package:socialapps/model/subcribsionPlanDettailsModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingController extends  GetxController{

  final onSwitch = true.obs;
  final usernames = "".obs;
  final butttonLoader = false.obs;


  final PlanResultDetails = PlanResult().obs;
  final  isLoading = false.obs;

  final selectedUserValue = GetUserAccountResult().obs;
  final getUserAccountList = <GetUserAccountResult>[].obs;
  final UserAccountDetails = GetUserAccountModal().obs;
  final isGetSubscriberAccounts = true.obs;
  final token = ''.obs;

  GetUserAccount(){
    if(DataManager.getInstance().getuserId().toString() == "1"){
      getUserAccountList.value = [];
    }else{
      var body = {"phonenumber":"${DataManager.getInstance().getphonedata().toString()}"};
      ThatZalApis.fromDataPost(BodyParam: body,Endpoint: ApiUrls.getUserAccounts).then((UserAccountRes) {
        if (UserAccountRes["status"] == 200) {
          UserAccountDetails.value = GetUserAccountModal.fromJson(UserAccountRes);
          getUserAccountList.value = UserAccountDetails!.value.result!;
          for (var i = 0; i < getUserAccountList.length; i++) {
            if (getUserAccountList[i].id.toString().trim() == DataManager.getInstance().getuserId().toString()) {
              selectedUserValue.value = getUserAccountList[i];
              isGetSubscriberAccounts.value = false;
              break;
            }
          }
        }
      });

      FirebaseMessaging.instance.getToken().then((newToken) {
        token.value = newToken!;
      });
    }

  }

}