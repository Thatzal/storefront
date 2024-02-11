/// status : 200
/// message : "Plan subscribed by user"
/// result : {"id":27,"created_at":"08-08-2023 18:39","updated_at":"26-09-2023 13:39","expire_at":"25-12-2023","user":{"id":102,"displayname":"Deepak Goswami","phonenumber":"9630706209","username":"deepak123","email":"dg29380@gmail.com","profile_picture":"/media/profile/image_cropper_1694843283980.jpg","page_picture":"/media/page/image_cropper_1694843247294.jpg","desc":"null","placeORperson":"person","businessORpublic":"public","classification":"null","movable":true,"addressORarea":"address","operatingaddress":"","maritalstatus":"single","passportnumber":"","dateofissue":null,"nationality":"","dateofbirth":null,"gender":"M","religion":"","subreligion":"","caste":"","subsect":"","search_page_preferences":"","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":"[{\"Address\":\"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore\"}]","Want_to_Buy":true,"Want_to_sell":true,"Opt_Delivery":false,"not_offering_reminder":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"20.00","mean_computed_rating":0,"numberofcomputations":0,"deafault_offer_duration":"","mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"deviceToken":"","created_at":"07-07-2023 12:00","modified":"26-09-2023 10:20","is_deleted":false,"delete_date":null,"followers":[7,155,161,184,185],"following":[7,155,161,184,185]},"plan":{"id":3,"type":"MONTHLY","title":"Monthly Subscription","sub_title":"Renewable every year","desc":"this is yearly subscription for one year. In this you got this access","image":"/media/plans/pana_kRJ4KK2.png","price":"99.00","duration":3,"created_at":"15-05-2023 11:37","modified":"26-09-2023 13:38"}}

class SubcribsionPlanDettailsModel {
  SubcribsionPlanDettailsModel({
      num? status, 
      String? message, 
      PlanResult? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  SubcribsionPlanDettailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? PlanResult.fromJson(json['result']) : null;
  }
  num? _status;
  String? _message;
  PlanResult? _result;
SubcribsionPlanDettailsModel copyWith({  num? status,
  String? message,
  PlanResult? result,
}) => SubcribsionPlanDettailsModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  PlanResult? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// id : 27
/// created_at : "08-08-2023 18:39"
/// updated_at : "26-09-2023 13:39"
/// expire_at : "25-12-2023"
/// user : {"id":102,"displayname":"Deepak Goswami","phonenumber":"9630706209","username":"deepak123","email":"dg29380@gmail.com","profile_picture":"/media/profile/image_cropper_1694843283980.jpg","page_picture":"/media/page/image_cropper_1694843247294.jpg","desc":"null","placeORperson":"person","businessORpublic":"public","classification":"null","movable":true,"addressORarea":"address","operatingaddress":"","maritalstatus":"single","passportnumber":"","dateofissue":null,"nationality":"","dateofbirth":null,"gender":"M","religion":"","subreligion":"","caste":"","subsect":"","search_page_preferences":"","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":"[{\"Address\":\"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore\"}]","Want_to_Buy":true,"Want_to_sell":true,"Opt_Delivery":false,"not_offering_reminder":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"20.00","mean_computed_rating":0,"numberofcomputations":0,"deafault_offer_duration":"","mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"deviceToken":"","created_at":"07-07-2023 12:00","modified":"26-09-2023 10:20","is_deleted":false,"delete_date":null,"followers":[7,155,161,184,185],"following":[7,155,161,184,185]}
/// plan : {"id":3,"type":"MONTHLY","title":"Monthly Subscription","sub_title":"Renewable every year","desc":"this is yearly subscription for one year. In this you got this access","image":"/media/plans/pana_kRJ4KK2.png","price":"99.00","duration":3,"created_at":"15-05-2023 11:37","modified":"26-09-2023 13:38"}

class PlanResult {
  PlanResult({
      num? id, 
      String? createdAt, 
      String? updatedAt, 
      String? expireAt, 
      User? user, 
      PlanDetails? plan,}){
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _expireAt = expireAt;
    _user = user;
    _plan = plan;
}

  PlanResult.fromJson(dynamic json) {
    _id = json['id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _expireAt = json['expire_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _plan = json['plan'] != null ? PlanDetails.fromJson(json['plan']) : null;
  }
  num? _id;
  String? _createdAt;
  String? _updatedAt;
  String? _expireAt;
  User? _user;
  PlanDetails? _plan;
PlanResult copyWith({  num? id,
  String? createdAt,
  String? updatedAt,
  String? expireAt,
  User? user,
  PlanDetails? plan,
}) => PlanResult(  id: id ?? _id,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  expireAt: expireAt ?? _expireAt,
  user: user ?? _user,
  plan: plan ?? _plan,
);
  num? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get expireAt => _expireAt;
  User? get user => _user;
  PlanDetails? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['expire_at'] = _expireAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }

}

/// id : 3
/// type : "MONTHLY"
/// title : "Monthly Subscription"
/// sub_title : "Renewable every year"
/// desc : "this is yearly subscription for one year. In this you got this access"
/// image : "/media/plans/pana_kRJ4KK2.png"
/// price : "99.00"
/// duration : 3
/// created_at : "15-05-2023 11:37"
/// modified : "26-09-2023 13:38"

class PlanDetails {
  PlanDetails({
      num? id, 
      String? type, 
      String? title, 
      String? subTitle, 
      String? desc, 
      String? image, 
      String? price, 
      num? duration, 
      String? createdAt, 
      String? modified,}){
    _id = id;
    _type = type;
    _title = title;
    _subTitle = subTitle;
    _desc = desc;
    _image = image;
    _price = price;
    _duration = duration;
    _createdAt = createdAt;
    _modified = modified;
}

  PlanDetails.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _title = json['title'];
    _subTitle = json['sub_title'];
    _desc = json['desc'];
    _image = json['image'];
    _price = json['price'];
    _duration = json['duration'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
  }
  num? _id;
  String? _type;
  String? _title;
  String? _subTitle;
  String? _desc;
  String? _image;
  String? _price;
  num? _duration;
  String? _createdAt;
  String? _modified;
PlanDetails copyWith({  num? id,
  String? type,
  String? title,
  String? subTitle,
  String? desc,
  String? image,
  String? price,
  num? duration,
  String? createdAt,
  String? modified,
}) => PlanDetails(  id: id ?? _id,
  type: type ?? _type,
  title: title ?? _title,
  subTitle: subTitle ?? _subTitle,
  desc: desc ?? _desc,
  image: image ?? _image,
  price: price ?? _price,
  duration: duration ?? _duration,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
);
  num? get id => _id;
  String? get type => _type;
  String? get title => _title;
  String? get subTitle => _subTitle;
  String? get desc => _desc;
  String? get image => _image;
  String? get price => _price;
  num? get duration => _duration;
  String? get createdAt => _createdAt;
  String? get modified => _modified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['title'] = _title;
    map['sub_title'] = _subTitle;
    map['desc'] = _desc;
    map['image'] = _image;
    map['price'] = _price;
    map['duration'] = _duration;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    return map;
  }

}

/// id : 102
/// displayname : "Deepak Goswami"
/// phonenumber : "9630706209"
/// username : "deepak123"
/// email : "dg29380@gmail.com"
/// profile_picture : "/media/profile/image_cropper_1694843283980.jpg"
/// page_picture : "/media/page/image_cropper_1694843247294.jpg"
/// desc : "null"
/// placeORperson : "person"
/// businessORpublic : "public"
/// classification : "null"
/// movable : true
/// addressORarea : "address"
/// operatingaddress : ""
/// maritalstatus : "single"
/// passportnumber : ""
/// dateofissue : null
/// nationality : ""
/// dateofbirth : null
/// gender : "M"
/// religion : ""
/// subreligion : ""
/// caste : ""
/// subsect : ""
/// search_page_preferences : ""
/// Offering_area_preference : null
/// Offer_Category_preference : null
/// Offer_Segment_preference : null
/// Offer_Sub_Segment_preference : null
/// Current_Location : "[{\"Address\":\"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore\"}]"
/// Want_to_Buy : true
/// Want_to_sell : true
/// Opt_Delivery : false
/// not_offering_reminder : false
/// Close_Confirmed_Offers : false
/// Ok_for_Current_location_Offers : false
/// Offer_match_percentage : "20.00"
/// mean_computed_rating : 0
/// numberofcomputations : 0
/// deafault_offer_duration : ""
/// mean_user_rating : 0
/// numberofusers_rating : 0
/// blocked : "NO"
/// blockedtime : null
/// subscription_status : "FREE"
/// payment_done : null
/// payment_date : null
/// deviceToken : ""
/// created_at : "07-07-2023 12:00"
/// modified : "26-09-2023 10:20"
/// is_deleted : false
/// delete_date : null
/// followers : [7,155,161,184,185]
/// following : [7,155,161,184,185]

class User {
  User({
      num? id, 
      String? displayname, 
      String? phonenumber, 
      String? username, 
      String? email, 
      String? profilePicture, 
      String? pagePicture, 
      String? desc, 
      String? placeORperson, 
      String? businessORpublic, 
      String? classification, 
      bool? movable, 
      String? addressORarea, 
      String? operatingaddress, 
      String? maritalstatus, 
      String? passportnumber, 
      dynamic dateofissue, 
      String? nationality, 
      dynamic dateofbirth, 
      String? gender, 
      String? religion, 
      String? subreligion, 
      String? caste, 
      String? subsect, 
      String? searchPagePreferences, 
      dynamic offeringAreaPreference, 
      dynamic offerCategoryPreference, 
      dynamic offerSegmentPreference, 
      dynamic offerSubSegmentPreference, 
      String? currentLocation, 
      bool? wantToBuy, 
      bool? wantToSell, 
      bool? optDelivery, 
      bool? notOfferingReminder, 
      bool? closeConfirmedOffers, 
      bool? okForCurrentLocationOffers, 
      String? offerMatchPercentage, 
      num? meanComputedRating, 
      num? numberofcomputations, 
      String? deafaultOfferDuration, 
      num? meanUserRating, 
      num? numberofusersRating, 
      String? blocked, 
      dynamic blockedtime, 
      String? subscriptionStatus, 
      dynamic paymentDone, 
      dynamic paymentDate, 
      String? deviceToken, 
      String? createdAt, 
      String? modified, 
      bool? isDeleted, 
      dynamic deleteDate, 
      List<num>? followers, 
      List<num>? following,}){
    _id = id;
    _displayname = displayname;
    _phonenumber = phonenumber;
    _username = username;
    _email = email;
    _profilePicture = profilePicture;
    _pagePicture = pagePicture;
    _desc = desc;
    _placeORperson = placeORperson;
    _businessORpublic = businessORpublic;
    _classification = classification;
    _movable = movable;
    _addressORarea = addressORarea;
    _operatingaddress = operatingaddress;
    _maritalstatus = maritalstatus;
    _passportnumber = passportnumber;
    _dateofissue = dateofissue;
    _nationality = nationality;
    _dateofbirth = dateofbirth;
    _gender = gender;
    _religion = religion;
    _subreligion = subreligion;
    _caste = caste;
    _subsect = subsect;
    _searchPagePreferences = searchPagePreferences;
    _offeringAreaPreference = offeringAreaPreference;
    _offerCategoryPreference = offerCategoryPreference;
    _offerSegmentPreference = offerSegmentPreference;
    _offerSubSegmentPreference = offerSubSegmentPreference;
    _currentLocation = currentLocation;
    _wantToBuy = wantToBuy;
    _wantToSell = wantToSell;
    _optDelivery = optDelivery;
    _notOfferingReminder = notOfferingReminder;
    _closeConfirmedOffers = closeConfirmedOffers;
    _okForCurrentLocationOffers = okForCurrentLocationOffers;
    _offerMatchPercentage = offerMatchPercentage;
    _meanComputedRating = meanComputedRating;
    _numberofcomputations = numberofcomputations;
    _deafaultOfferDuration = deafaultOfferDuration;
    _meanUserRating = meanUserRating;
    _numberofusersRating = numberofusersRating;
    _blocked = blocked;
    _blockedtime = blockedtime;
    _subscriptionStatus = subscriptionStatus;
    _paymentDone = paymentDone;
    _paymentDate = paymentDate;
    _deviceToken = deviceToken;
    _createdAt = createdAt;
    _modified = modified;
    _isDeleted = isDeleted;
    _deleteDate = deleteDate;
    _followers = followers;
    _following = following;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _displayname = json['displayname'];
    _phonenumber = json['phonenumber'];
    _username = json['username'];
    _email = json['email'];
    _profilePicture = json['profile_picture'];
    _pagePicture = json['page_picture'];
    _desc = json['desc'];
    _placeORperson = json['placeORperson'];
    _businessORpublic = json['businessORpublic'];
    _classification = json['classification'];
    _movable = json['movable'];
    _addressORarea = json['addressORarea'];
    _operatingaddress = json['operatingaddress'];
    _maritalstatus = json['maritalstatus'];
    _passportnumber = json['passportnumber'];
    _dateofissue = json['dateofissue'];
    _nationality = json['nationality'];
    _dateofbirth = json['dateofbirth'];
    _gender = json['gender'];
    _religion = json['religion'];
    _subreligion = json['subreligion'];
    _caste = json['caste'];
    _subsect = json['subsect'];
    _searchPagePreferences = json['search_page_preferences'];
    _offeringAreaPreference = json['Offering_area_preference'];
    _offerCategoryPreference = json['Offer_Category_preference'];
    _offerSegmentPreference = json['Offer_Segment_preference'];
    _offerSubSegmentPreference = json['Offer_Sub_Segment_preference'];
    _currentLocation = json['Current_Location'];
    _wantToBuy = json['Want_to_Buy'];
    _wantToSell = json['Want_to_sell'];
    _optDelivery = json['Opt_Delivery'];
    _notOfferingReminder = json['not_offering_reminder'];
    _closeConfirmedOffers = json['Close_Confirmed_Offers'];
    _okForCurrentLocationOffers = json['Ok_for_Current_location_Offers'];
    _offerMatchPercentage = json['Offer_match_percentage'];
    _meanComputedRating = json['mean_computed_rating'];
    _numberofcomputations = json['numberofcomputations'];
    _deafaultOfferDuration = json['deafault_offer_duration'];
    _meanUserRating = json['mean_user_rating'];
    _numberofusersRating = json['numberofusers_rating'];
    _blocked = json['blocked'];
    _blockedtime = json['blockedtime'];
    _subscriptionStatus = json['subscription_status'];
    _paymentDone = json['payment_done'];
    _paymentDate = json['payment_date'];
    _deviceToken = json['deviceToken'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _isDeleted = json['is_deleted'];
    _deleteDate = json['delete_date'];
    _followers = json['followers'] != null ? json['followers'].cast<num>() : [];
    _following = json['following'] != null ? json['following'].cast<num>() : [];
  }
  num? _id;
  String? _displayname;
  String? _phonenumber;
  String? _username;
  String? _email;
  String? _profilePicture;
  String? _pagePicture;
  String? _desc;
  String? _placeORperson;
  String? _businessORpublic;
  String? _classification;
  bool? _movable;
  String? _addressORarea;
  String? _operatingaddress;
  String? _maritalstatus;
  String? _passportnumber;
  dynamic _dateofissue;
  String? _nationality;
  dynamic _dateofbirth;
  String? _gender;
  String? _religion;
  String? _subreligion;
  String? _caste;
  String? _subsect;
  String? _searchPagePreferences;
  dynamic _offeringAreaPreference;
  dynamic _offerCategoryPreference;
  dynamic _offerSegmentPreference;
  dynamic _offerSubSegmentPreference;
  String? _currentLocation;
  bool? _wantToBuy;
  bool? _wantToSell;
  bool? _optDelivery;
  bool? _notOfferingReminder;
  bool? _closeConfirmedOffers;
  bool? _okForCurrentLocationOffers;
  String? _offerMatchPercentage;
  num? _meanComputedRating;
  num? _numberofcomputations;
  String? _deafaultOfferDuration;
  num? _meanUserRating;
  num? _numberofusersRating;
  String? _blocked;
  dynamic _blockedtime;
  String? _subscriptionStatus;
  dynamic _paymentDone;
  dynamic _paymentDate;
  String? _deviceToken;
  String? _createdAt;
  String? _modified;
  bool? _isDeleted;
  dynamic _deleteDate;
  List<num>? _followers;
  List<num>? _following;
User copyWith({  num? id,
  String? displayname,
  String? phonenumber,
  String? username,
  String? email,
  String? profilePicture,
  String? pagePicture,
  String? desc,
  String? placeORperson,
  String? businessORpublic,
  String? classification,
  bool? movable,
  String? addressORarea,
  String? operatingaddress,
  String? maritalstatus,
  String? passportnumber,
  dynamic dateofissue,
  String? nationality,
  dynamic dateofbirth,
  String? gender,
  String? religion,
  String? subreligion,
  String? caste,
  String? subsect,
  String? searchPagePreferences,
  dynamic offeringAreaPreference,
  dynamic offerCategoryPreference,
  dynamic offerSegmentPreference,
  dynamic offerSubSegmentPreference,
  String? currentLocation,
  bool? wantToBuy,
  bool? wantToSell,
  bool? optDelivery,
  bool? notOfferingReminder,
  bool? closeConfirmedOffers,
  bool? okForCurrentLocationOffers,
  String? offerMatchPercentage,
  num? meanComputedRating,
  num? numberofcomputations,
  String? deafaultOfferDuration,
  num? meanUserRating,
  num? numberofusersRating,
  String? blocked,
  dynamic blockedtime,
  String? subscriptionStatus,
  dynamic paymentDone,
  dynamic paymentDate,
  String? deviceToken,
  String? createdAt,
  String? modified,
  bool? isDeleted,
  dynamic deleteDate,
  List<num>? followers,
  List<num>? following,
}) => User(  id: id ?? _id,
  displayname: displayname ?? _displayname,
  phonenumber: phonenumber ?? _phonenumber,
  username: username ?? _username,
  email: email ?? _email,
  profilePicture: profilePicture ?? _profilePicture,
  pagePicture: pagePicture ?? _pagePicture,
  desc: desc ?? _desc,
  placeORperson: placeORperson ?? _placeORperson,
  businessORpublic: businessORpublic ?? _businessORpublic,
  classification: classification ?? _classification,
  movable: movable ?? _movable,
  addressORarea: addressORarea ?? _addressORarea,
  operatingaddress: operatingaddress ?? _operatingaddress,
  maritalstatus: maritalstatus ?? _maritalstatus,
  passportnumber: passportnumber ?? _passportnumber,
  dateofissue: dateofissue ?? _dateofissue,
  nationality: nationality ?? _nationality,
  dateofbirth: dateofbirth ?? _dateofbirth,
  gender: gender ?? _gender,
  religion: religion ?? _religion,
  subreligion: subreligion ?? _subreligion,
  caste: caste ?? _caste,
  subsect: subsect ?? _subsect,
  searchPagePreferences: searchPagePreferences ?? _searchPagePreferences,
  offeringAreaPreference: offeringAreaPreference ?? _offeringAreaPreference,
  offerCategoryPreference: offerCategoryPreference ?? _offerCategoryPreference,
  offerSegmentPreference: offerSegmentPreference ?? _offerSegmentPreference,
  offerSubSegmentPreference: offerSubSegmentPreference ?? _offerSubSegmentPreference,
  currentLocation: currentLocation ?? _currentLocation,
  wantToBuy: wantToBuy ?? _wantToBuy,
  wantToSell: wantToSell ?? _wantToSell,
  optDelivery: optDelivery ?? _optDelivery,
  notOfferingReminder: notOfferingReminder ?? _notOfferingReminder,
  closeConfirmedOffers: closeConfirmedOffers ?? _closeConfirmedOffers,
  okForCurrentLocationOffers: okForCurrentLocationOffers ?? _okForCurrentLocationOffers,
  offerMatchPercentage: offerMatchPercentage ?? _offerMatchPercentage,
  meanComputedRating: meanComputedRating ?? _meanComputedRating,
  numberofcomputations: numberofcomputations ?? _numberofcomputations,
  deafaultOfferDuration: deafaultOfferDuration ?? _deafaultOfferDuration,
  meanUserRating: meanUserRating ?? _meanUserRating,
  numberofusersRating: numberofusersRating ?? _numberofusersRating,
  blocked: blocked ?? _blocked,
  blockedtime: blockedtime ?? _blockedtime,
  subscriptionStatus: subscriptionStatus ?? _subscriptionStatus,
  paymentDone: paymentDone ?? _paymentDone,
  paymentDate: paymentDate ?? _paymentDate,
  deviceToken: deviceToken ?? _deviceToken,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  isDeleted: isDeleted ?? _isDeleted,
  deleteDate: deleteDate ?? _deleteDate,
  followers: followers ?? _followers,
  following: following ?? _following,
);
  num? get id => _id;
  String? get displayname => _displayname;
  String? get phonenumber => _phonenumber;
  String? get username => _username;
  String? get email => _email;
  String? get profilePicture => _profilePicture;
  String? get pagePicture => _pagePicture;
  String? get desc => _desc;
  String? get placeORperson => _placeORperson;
  String? get businessORpublic => _businessORpublic;
  String? get classification => _classification;
  bool? get movable => _movable;
  String? get addressORarea => _addressORarea;
  String? get operatingaddress => _operatingaddress;
  String? get maritalstatus => _maritalstatus;
  String? get passportnumber => _passportnumber;
  dynamic get dateofissue => _dateofissue;
  String? get nationality => _nationality;
  dynamic get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get subreligion => _subreligion;
  String? get caste => _caste;
  String? get subsect => _subsect;
  String? get searchPagePreferences => _searchPagePreferences;
  dynamic get offeringAreaPreference => _offeringAreaPreference;
  dynamic get offerCategoryPreference => _offerCategoryPreference;
  dynamic get offerSegmentPreference => _offerSegmentPreference;
  dynamic get offerSubSegmentPreference => _offerSubSegmentPreference;
  String? get currentLocation => _currentLocation;
  bool? get wantToBuy => _wantToBuy;
  bool? get wantToSell => _wantToSell;
  bool? get optDelivery => _optDelivery;
  bool? get notOfferingReminder => _notOfferingReminder;
  bool? get closeConfirmedOffers => _closeConfirmedOffers;
  bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
  String? get offerMatchPercentage => _offerMatchPercentage;
  num? get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
  String? get deafaultOfferDuration => _deafaultOfferDuration;
  num? get meanUserRating => _meanUserRating;
  num? get numberofusersRating => _numberofusersRating;
  String? get blocked => _blocked;
  dynamic get blockedtime => _blockedtime;
  String? get subscriptionStatus => _subscriptionStatus;
  dynamic get paymentDone => _paymentDone;
  dynamic get paymentDate => _paymentDate;
  String? get deviceToken => _deviceToken;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  bool? get isDeleted => _isDeleted;
  dynamic get deleteDate => _deleteDate;
  List<num>? get followers => _followers;
  List<num>? get following => _following;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['displayname'] = _displayname;
    map['phonenumber'] = _phonenumber;
    map['username'] = _username;
    map['email'] = _email;
    map['profile_picture'] = _profilePicture;
    map['page_picture'] = _pagePicture;
    map['desc'] = _desc;
    map['placeORperson'] = _placeORperson;
    map['businessORpublic'] = _businessORpublic;
    map['classification'] = _classification;
    map['movable'] = _movable;
    map['addressORarea'] = _addressORarea;
    map['operatingaddress'] = _operatingaddress;
    map['maritalstatus'] = _maritalstatus;
    map['passportnumber'] = _passportnumber;
    map['dateofissue'] = _dateofissue;
    map['nationality'] = _nationality;
    map['dateofbirth'] = _dateofbirth;
    map['gender'] = _gender;
    map['religion'] = _religion;
    map['subreligion'] = _subreligion;
    map['caste'] = _caste;
    map['subsect'] = _subsect;
    map['search_page_preferences'] = _searchPagePreferences;
    map['Offering_area_preference'] = _offeringAreaPreference;
    map['Offer_Category_preference'] = _offerCategoryPreference;
    map['Offer_Segment_preference'] = _offerSegmentPreference;
    map['Offer_Sub_Segment_preference'] = _offerSubSegmentPreference;
    map['Current_Location'] = _currentLocation;
    map['Want_to_Buy'] = _wantToBuy;
    map['Want_to_sell'] = _wantToSell;
    map['Opt_Delivery'] = _optDelivery;
    map['not_offering_reminder'] = _notOfferingReminder;
    map['Close_Confirmed_Offers'] = _closeConfirmedOffers;
    map['Ok_for_Current_location_Offers'] = _okForCurrentLocationOffers;
    map['Offer_match_percentage'] = _offerMatchPercentage;
    map['mean_computed_rating'] = _meanComputedRating;
    map['numberofcomputations'] = _numberofcomputations;
    map['deafault_offer_duration'] = _deafaultOfferDuration;
    map['mean_user_rating'] = _meanUserRating;
    map['numberofusers_rating'] = _numberofusersRating;
    map['blocked'] = _blocked;
    map['blockedtime'] = _blockedtime;
    map['subscription_status'] = _subscriptionStatus;
    map['payment_done'] = _paymentDone;
    map['payment_date'] = _paymentDate;
    map['deviceToken'] = _deviceToken;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['is_deleted'] = _isDeleted;
    map['delete_date'] = _deleteDate;
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}