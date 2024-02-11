class DataManager{
  var phonedata,userId,userName,userEmail,userImage,offerArea,userDisplayName,UserIsPlaceType,setUserSecMobileNo;

  static final DataManager ourInstance = DataManager();

  static DataManager getInstance() {
    return ourInstance;
  }

  String getphonedata() {
    return phonedata;
  }
  setphonedata(value) {
    phonedata = value;
  }

  String getuserId() {
    return userId;
  }
  setuserId(value) {
    userId = value;
  }

  String getuserName() {
    return userName;
  }
  setuserName(value) {
    userName = value;
  }

  String getuserEmail() {
    return userEmail;
  }
  setuserEmail(value) {
    userEmail = value;
  }

  String getUserSecMobile() {
    return setUserSecMobileNo;
  }
  setUserSecMobile(value) {
    setUserSecMobileNo = value;
  }

  String getuserImage() {
    return userImage;
  }
  setuserImage(value) {
    userImage = value;
  }

  String getOfferArea() {
    return offerArea;
  }
  setOfferArea(value) {
    offerArea = value;
  }

  String getUserDisplayName() {
    return userDisplayName;
  }
  setUserDisplayName(value) {
    userDisplayName = value;
  }

  String getUserIsPlaceType() {
    return UserIsPlaceType;
  }
  setUserIsPlaceType(value) {
    UserIsPlaceType = value;
  }

}

