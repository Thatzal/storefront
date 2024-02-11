/// status : 200
/// message : "All accounts related phonenumber 9988776655"
/// result : [{"id":4,"followers":4,"following":4,"displayname":"kishore Patidar","phonenumber":"9988776655","username":"kishore Patidar","email":"kishorepatidar@gmail.com","profile_picture":"/media/profile/man_0HADR2A.png","page_picture":"/media/page/yellow-chrysanthemum_n7ykcjd.jpg","desc":"hello world","placeORperson":"place","businessORpublic":"public","classification":null,"movable":false,"addressORarea":"address","operatingaddress":null,"maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"15-05-2023 11:34","modified":"17-05-2023 11:23"},{"id":16,"followers":0,"following":0,"displayname":"mohan","phonenumber":"9988776655","username":"mohan1","email":null,"profile_picture":null,"page_picture":null,"desc":null,"placeORperson":"person","businessORpublic":"public","classification":null,"movable":false,"addressORarea":"address","operatingaddress":null,"maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"17-05-2023 15:39","modified":"17-05-2023 15:40"}]

class GetUserAccountModal {
  GetUserAccountModal({
      num? status, 
      String? message, 
      List<GetUserAccountResult>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetUserAccountModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(GetUserAccountResult.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<GetUserAccountResult>? _result;
GetUserAccountModal copyWith({  num? status,
  String? message,
  List<GetUserAccountResult>? result,
}) => GetUserAccountModal(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<GetUserAccountResult>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// followers : 4
/// following : 4
/// displayname : "kishore Patidar"
/// phonenumber : "9988776655"
/// username : "kishore Patidar"
/// email : "kishorepatidar@gmail.com"
/// profile_picture : "/media/profile/man_0HADR2A.png"
/// page_picture : "/media/page/yellow-chrysanthemum_n7ykcjd.jpg"
/// desc : "hello world"
/// placeORperson : "place"
/// businessORpublic : "public"
/// classification : null
/// movable : false
/// addressORarea : "address"
/// operatingaddress : null
/// maritalstatus : "single"
/// passportnumber : null
/// dateofissue : null
/// nationality : null
/// dateofbirth : null
/// gender : "M"
/// religion : null
/// subreligion : null
/// caste : null
/// subsect : null
/// search_page_position_preferences : "TRENDING OFFERS"
/// Offering_area_preference : null
/// Offer_Category_preference : null
/// Offer_Segment_preference : null
/// Offer_Sub_Segment_preference : null
/// Current_Location : null
/// Want_to_Buy : false
/// Want_to_sell : false
/// Opt_Delivery : false
/// Close_Confirmed_Offers : false
/// Ok_for_Current_location_Offers : false
/// Offer_match_percentage : "0.00"
/// mean_computed_rating : 0
/// numberofcomputations : 0
/// mean_user_rating : 0
/// numberofusers_rating : 0
/// blocked : "NO"
/// blockedtime : null
/// subscription_status : "FREE"
/// payment_done : null
/// payment_date : null
/// created_at : "15-05-2023 11:34"
/// modified : "17-05-2023 11:23"

class GetUserAccountResult {
  GetUserAccountResult({
      num? id, 
      num? followers, 
      num? following, 
      String? displayname, 
      String? phonenumber, 
      String? username, 
      String? email, 
      String? profilePicture, 
      String? pagePicture, 
      String? desc, 
      String? placeORperson, 
      String? businessORpublic, 
      dynamic classification, 
      bool? movable, 
      String? addressORarea, 
      dynamic operatingaddress, 
      String? maritalstatus, 
      dynamic passportnumber, 
      dynamic dateofissue, 
      dynamic nationality, 
      dynamic dateofbirth, 
      String? gender, 
      dynamic religion, 
      dynamic subreligion, 
      dynamic caste, 
      dynamic subsect, 
      String? searchPagePositionPreferences, 
      dynamic offeringAreaPreference, 
      dynamic offerCategoryPreference, 
      dynamic offerSegmentPreference, 
      dynamic offerSubSegmentPreference, 
      dynamic currentLocation, 
      bool? wantToBuy, 
      bool? wantToSell, 
      bool? optDelivery, 
      bool? closeConfirmedOffers, 
      bool? okForCurrentLocationOffers, 
      String? offerMatchPercentage, 
      num? meanComputedRating, 
      num? numberofcomputations, 
      num? meanUserRating, 
      num? numberofusersRating, 
      String? blocked, 
      dynamic blockedtime, 
      String? subscriptionStatus, 
      dynamic paymentDone, 
      dynamic paymentDate, 
      String? createdAt, 
      String? modified,}){
    _id = id;
    _followers = followers;
    _following = following;
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
    _searchPagePositionPreferences = searchPagePositionPreferences;
    _offeringAreaPreference = offeringAreaPreference;
    _offerCategoryPreference = offerCategoryPreference;
    _offerSegmentPreference = offerSegmentPreference;
    _offerSubSegmentPreference = offerSubSegmentPreference;
    _currentLocation = currentLocation;
    _wantToBuy = wantToBuy;
    _wantToSell = wantToSell;
    _optDelivery = optDelivery;
    _closeConfirmedOffers = closeConfirmedOffers;
    _okForCurrentLocationOffers = okForCurrentLocationOffers;
    _offerMatchPercentage = offerMatchPercentage;
    _meanComputedRating = meanComputedRating;
    _numberofcomputations = numberofcomputations;
    _meanUserRating = meanUserRating;
    _numberofusersRating = numberofusersRating;
    _blocked = blocked;
    _blockedtime = blockedtime;
    _subscriptionStatus = subscriptionStatus;
    _paymentDone = paymentDone;
    _paymentDate = paymentDate;
    _createdAt = createdAt;
    _modified = modified;
}

  GetUserAccountResult.fromJson(dynamic json) {
    _id = json['id'];
    _followers = json['followers'];
    _following = json['following'];
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
    _searchPagePositionPreferences = json['search_page_position_preferences'];
    _offeringAreaPreference = json['Offering_area_preference'];
    _offerCategoryPreference = json['Offer_Category_preference'];
    _offerSegmentPreference = json['Offer_Segment_preference'];
    _offerSubSegmentPreference = json['Offer_Sub_Segment_preference'];
    _currentLocation = json['Current_Location'];
    _wantToBuy = json['Want_to_Buy'];
    _wantToSell = json['Want_to_sell'];
    _optDelivery = json['Opt_Delivery'];
    _closeConfirmedOffers = json['Close_Confirmed_Offers'];
    _okForCurrentLocationOffers = json['Ok_for_Current_location_Offers'];
    _offerMatchPercentage = json['Offer_match_percentage'];
    _meanComputedRating = json['mean_computed_rating'];
    _numberofcomputations = json['numberofcomputations'];
    _meanUserRating = json['mean_user_rating'];
    _numberofusersRating = json['numberofusers_rating'];
    _blocked = json['blocked'];
    _blockedtime = json['blockedtime'];
    _subscriptionStatus = json['subscription_status'];
    _paymentDone = json['payment_done'];
    _paymentDate = json['payment_date'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
  }
  num? _id;
  num? _followers;
  num? _following;
  String? _displayname;
  String? _phonenumber;
  String? _username;
  String? _email;
  String? _profilePicture;
  String? _pagePicture;
  String? _desc;
  String? _placeORperson;
  String? _businessORpublic;
  dynamic _classification;
  bool? _movable;
  String? _addressORarea;
  dynamic _operatingaddress;
  String? _maritalstatus;
  dynamic _passportnumber;
  dynamic _dateofissue;
  dynamic _nationality;
  dynamic _dateofbirth;
  String? _gender;
  dynamic _religion;
  dynamic _subreligion;
  dynamic _caste;
  dynamic _subsect;
  String? _searchPagePositionPreferences;
  dynamic _offeringAreaPreference;
  dynamic _offerCategoryPreference;
  dynamic _offerSegmentPreference;
  dynamic _offerSubSegmentPreference;
  dynamic _currentLocation;
  bool? _wantToBuy;
  bool? _wantToSell;
  bool? _optDelivery;
  bool? _closeConfirmedOffers;
  bool? _okForCurrentLocationOffers;
  String? _offerMatchPercentage;
  num? _meanComputedRating;
  num? _numberofcomputations;
  num? _meanUserRating;
  num? _numberofusersRating;
  String? _blocked;
  dynamic _blockedtime;
  String? _subscriptionStatus;
  dynamic _paymentDone;
  dynamic _paymentDate;
  String? _createdAt;
  String? _modified;
GetUserAccountResult copyWith({  num? id,
  num? followers,
  num? following,
  String? displayname,
  String? phonenumber,
  String? username,
  String? email,
  String? profilePicture,
  String? pagePicture,
  String? desc,
  String? placeORperson,
  String? businessORpublic,
  dynamic classification,
  bool? movable,
  String? addressORarea,
  dynamic operatingaddress,
  String? maritalstatus,
  dynamic passportnumber,
  dynamic dateofissue,
  dynamic nationality,
  dynamic dateofbirth,
  String? gender,
  dynamic religion,
  dynamic subreligion,
  dynamic caste,
  dynamic subsect,
  String? searchPagePositionPreferences,
  dynamic offeringAreaPreference,
  dynamic offerCategoryPreference,
  dynamic offerSegmentPreference,
  dynamic offerSubSegmentPreference,
  dynamic currentLocation,
  bool? wantToBuy,
  bool? wantToSell,
  bool? optDelivery,
  bool? closeConfirmedOffers,
  bool? okForCurrentLocationOffers,
  String? offerMatchPercentage,
  num? meanComputedRating,
  num? numberofcomputations,
  num? meanUserRating,
  num? numberofusersRating,
  String? blocked,
  dynamic blockedtime,
  String? subscriptionStatus,
  dynamic paymentDone,
  dynamic paymentDate,
  String? createdAt,
  String? modified,
}) => GetUserAccountResult(  id: id ?? _id,
  followers: followers ?? _followers,
  following: following ?? _following,
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
  searchPagePositionPreferences: searchPagePositionPreferences ?? _searchPagePositionPreferences,
  offeringAreaPreference: offeringAreaPreference ?? _offeringAreaPreference,
  offerCategoryPreference: offerCategoryPreference ?? _offerCategoryPreference,
  offerSegmentPreference: offerSegmentPreference ?? _offerSegmentPreference,
  offerSubSegmentPreference: offerSubSegmentPreference ?? _offerSubSegmentPreference,
  currentLocation: currentLocation ?? _currentLocation,
  wantToBuy: wantToBuy ?? _wantToBuy,
  wantToSell: wantToSell ?? _wantToSell,
  optDelivery: optDelivery ?? _optDelivery,
  closeConfirmedOffers: closeConfirmedOffers ?? _closeConfirmedOffers,
  okForCurrentLocationOffers: okForCurrentLocationOffers ?? _okForCurrentLocationOffers,
  offerMatchPercentage: offerMatchPercentage ?? _offerMatchPercentage,
  meanComputedRating: meanComputedRating ?? _meanComputedRating,
  numberofcomputations: numberofcomputations ?? _numberofcomputations,
  meanUserRating: meanUserRating ?? _meanUserRating,
  numberofusersRating: numberofusersRating ?? _numberofusersRating,
  blocked: blocked ?? _blocked,
  blockedtime: blockedtime ?? _blockedtime,
  subscriptionStatus: subscriptionStatus ?? _subscriptionStatus,
  paymentDone: paymentDone ?? _paymentDone,
  paymentDate: paymentDate ?? _paymentDate,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
);
  num? get id => _id;
  num? get followers => _followers;
  num? get following => _following;
  String? get displayname => _displayname;
  String? get phonenumber => _phonenumber;
  String? get username => _username;
  String? get email => _email;
  String? get profilePicture => _profilePicture;
  String? get pagePicture => _pagePicture;
  String? get desc => _desc;
  String? get placeORperson => _placeORperson;
  String? get businessORpublic => _businessORpublic;
  dynamic get classification => _classification;
  bool? get movable => _movable;
  String? get addressORarea => _addressORarea;
  dynamic get operatingaddress => _operatingaddress;
  String? get maritalstatus => _maritalstatus;
  dynamic get passportnumber => _passportnumber;
  dynamic get dateofissue => _dateofissue;
  dynamic get nationality => _nationality;
  dynamic get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  dynamic get religion => _religion;
  dynamic get subreligion => _subreligion;
  dynamic get caste => _caste;
  dynamic get subsect => _subsect;
  String? get searchPagePositionPreferences => _searchPagePositionPreferences;
  dynamic get offeringAreaPreference => _offeringAreaPreference;
  dynamic get offerCategoryPreference => _offerCategoryPreference;
  dynamic get offerSegmentPreference => _offerSegmentPreference;
  dynamic get offerSubSegmentPreference => _offerSubSegmentPreference;
  dynamic get currentLocation => _currentLocation;
  bool? get wantToBuy => _wantToBuy;
  bool? get wantToSell => _wantToSell;
  bool? get optDelivery => _optDelivery;
  bool? get closeConfirmedOffers => _closeConfirmedOffers;
  bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
  String? get offerMatchPercentage => _offerMatchPercentage;
  num? get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
  num? get meanUserRating => _meanUserRating;
  num? get numberofusersRating => _numberofusersRating;
  String? get blocked => _blocked;
  dynamic get blockedtime => _blockedtime;
  String? get subscriptionStatus => _subscriptionStatus;
  dynamic get paymentDone => _paymentDone;
  dynamic get paymentDate => _paymentDate;
  String? get createdAt => _createdAt;
  String? get modified => _modified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['followers'] = _followers;
    map['following'] = _following;
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
    map['search_page_position_preferences'] = _searchPagePositionPreferences;
    map['Offering_area_preference'] = _offeringAreaPreference;
    map['Offer_Category_preference'] = _offerCategoryPreference;
    map['Offer_Segment_preference'] = _offerSegmentPreference;
    map['Offer_Sub_Segment_preference'] = _offerSubSegmentPreference;
    map['Current_Location'] = _currentLocation;
    map['Want_to_Buy'] = _wantToBuy;
    map['Want_to_sell'] = _wantToSell;
    map['Opt_Delivery'] = _optDelivery;
    map['Close_Confirmed_Offers'] = _closeConfirmedOffers;
    map['Ok_for_Current_location_Offers'] = _okForCurrentLocationOffers;
    map['Offer_match_percentage'] = _offerMatchPercentage;
    map['mean_computed_rating'] = _meanComputedRating;
    map['numberofcomputations'] = _numberofcomputations;
    map['mean_user_rating'] = _meanUserRating;
    map['numberofusers_rating'] = _numberofusersRating;
    map['blocked'] = _blocked;
    map['blockedtime'] = _blockedtime;
    map['subscription_status'] = _subscriptionStatus;
    map['payment_done'] = _paymentDone;
    map['payment_date'] = _paymentDate;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    return map;
  }

}