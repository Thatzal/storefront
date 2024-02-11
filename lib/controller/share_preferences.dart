
import 'package:shared_preferences/shared_preferences.dart';

class SharePre{

  static setUserId(String UserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', UserId);
  }

  static setUserName(String UserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserName', UserName);
  }

  static setUserDisplayName(String USerDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserDisplayName', USerDisplayName);
  }


  static setUserMobile(String UserMobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserMobile', UserMobile);
  }

  static setUserEmail(String UserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserEmail', UserEmail);
  }

  static setUserSecMobile(String userSecMobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userSecMobile', userSecMobile);
  }

  static setAddress(String SaveAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('SaveAddress', SaveAddress);
  }
  static setAddressTitle(String SaveAddressTitle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('SaveAddressTitle', SaveAddressTitle);
  }
  static setAddressId(String SaveAddressId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('SaveAddressId', SaveAddressId);
  }
  static setUserImage(String userImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userImage', userImage);
  }
  static setOfferingArea(String offerArea) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('offerArea', offerArea);
  }
  static setOfferChoice(String OfferChoice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('OfferChoice', OfferChoice);
  }
  static setUserIsPlaceType(String isPlace) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('isPlace', isPlace);
  }
}