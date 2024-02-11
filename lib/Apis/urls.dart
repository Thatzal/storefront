

class Url{
  static String IOSReleaseDate = "Jan 31, 2024";
  static String AndroidReleaseDate = "Jan 31, 2024";


 // static String BASE_URL = "http://13.51.44.195:8000/api/v1";
 // static String BASE_URL = "http://13.51.249.145:8000/api/v1";
  static String BASE_URL = "http://platform.thatzal.com/api/v1";
 // static String BASE_URL = "http://13.48.171.2:8000/api/v1";
 // static String BASE_URL = "http://65.0.251.3/api/v1";
 // static String BASE_URL = "http://16.170.254.80:8000/api/v1";
  static String IMAGE_URL = "";
  static String RefuseContentCheck = "https://api.sightengine.com/1.0/text/check.json";
  static String markFav = "Marked as Favorite!";
  static String UnMarkFav = "Un-Marked Favorite";
  static String OnFollow = "You followed ";

  static String peopleResponded = " ";
  static String personResponded = " ";
  static String NoResponded = "No one responded";
  static String abusedReportMessage = "You abused in this offer";
  static String searchHint = "Search Products or Services to Sell or Buy";
  static String AccountSwitchMessage = "Account Switched Successfully";
  static String AccountIDCreated = "Account ID Created";
  static String LogInMessage = "Logged in successfully";
  static String NotDeleteMessage = "You can't delete account with LIVE offers";
  static String OTPVerified = "OTP verified";
  static String NotExecuteMessage = "It's not the Execution time yet";
  static String isRequiredItemSelectMessage = "Please select required item to publish";
  static String isRequiredItemPriceSelectMessage = "Please enter item price to publish";
  static String BidsMessage = "Please enter bids to publish";
  static String selectItemExecute = "Please Execute item to publish";
  static String waitForResponse = "Please wait for the response";
  static String CatSegSubSegEnterMessage = "Category-Segment-Subsegment values needed";
  static String itemNameEnterMessage = "Please Enter Item name to publish";

}



class ApiUrls{
 // static String mapKey = "AIzaSyDE9xGmWMOftPvz1hHwPlTecShhHtR4goE";
 static String mapKey = "AIzaSyAvNwZ_RUaMuDHblwRJBi1QYs8oZQK8xOs";
//  static String mapKey = "AIzaSyCA7_Y5gTGf71rSeE_4BGjWlJfuQqqDulk";
//  static String mapKey = "AIzaSyDpfcXE7BpDcZKHOgE4V9CIPjVbZ7kKLaI";
  static String getTrendingOffer = "${Url.BASE_URL}/getTrendingOffers";
  static String getRecommendedOffer = "${Url.BASE_URL}/getRecommendedOffers";
  static String getTemplatesList = "${Url.BASE_URL}/getTemplatesList";
  static String getTrendingPerson = "${Url.BASE_URL}/getTrendingPeopleOrPlace";
  static String getRecentViewOffer = "${Url.BASE_URL}/offerVisitRecords";
  static String getTrendingSearches = "${Url.BASE_URL}/getTrendingSearches";
  static String getRecentSearches = "${Url.BASE_URL}/getRecentSearches";
  static String getFeedList = "${Url.BASE_URL}/getFeedsList";
  static String getFeedListV2 = "${Url.BASE_URL}/feedsListPaginate";
  static String getSubscriberDetails = "${Url.BASE_URL}/getSubscriberDetails";
  static String getUserAccounts = "${Url.BASE_URL}/getUserAccounts";
  static String getSubscriberOffers = "${Url.BASE_URL}/getSubscriberOffers";
  static String getSubscriberCounteredOffers = "${Url.BASE_URL}/getSubscriberCounteredOffers";
  static String getSubscriberFavouriteOffers = "${Url.BASE_URL}/getSubscriberFavouriteOffers";
  static String getSubscriberTemplate = "${Url.BASE_URL}/getSubscriberTemplate";
  static String uploadFile = "${Url.BASE_URL}/uploadFile";
  static String search_place = "${Url.BASE_URL}/search_place";
  static String sendOtpV2 = "sendF2Sms";
  static String registration = "registration";
  static String exicuteOfferItem = "exicuteOfferItem";
  static String getClassifications = "${Url.BASE_URL}/getClassifications";



}