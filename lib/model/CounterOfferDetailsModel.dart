
class CounterOfferDetailsModel {
  CounterOfferDetailsModel({
      String? status,
      String? message,
      CounterOfferDetailsModelResult? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  CounterOfferDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? CounterOfferDetailsModelResult.fromJson(json['result']) : null;
  }
  String? _status;
  String? _message;
  CounterOfferDetailsModelResult? _result;
CounterOfferDetailsModel copyWith({  String? status,
  String? message,
  CounterOfferDetailsModelResult? result,
}) => CounterOfferDetailsModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  CounterOfferDetailsModelResult? get result => _result;

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

class CounterOfferDetailsModelResult {
  CounterOfferDetailsModelResult({
      num? id,
      CounterDetailsOfferConditions? offerConditions,
      List<CounterDetailsOfferItems>? offerItems,
      dynamic parent,
      String? tabactivity,
      String? counteringstatus,
      String? createdAt,
      String? modified,
      num? confirmSteps,
      String? slug,
      Offer? offer,
      CounterDetailsFromCounter? fromCounter,
      CounterDetailsToCounter? toCounter,
      List<OfferBidCouterDetails>? offerBid,
  }){
    _id = id;
    _offerConditions = offerConditions;
    _offerItems = offerItems;
    _parent = parent;
    _tabactivity = tabactivity;
    _counteringstatus = counteringstatus;
    _createdAt = createdAt;
    _modified = modified;
    _confirmSteps = confirmSteps;
    _slug = slug;
    _offer = offer;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
    _offerBid = offerBid;
}

  CounterOfferDetailsModelResult.fromJson(dynamic json) {
    _id = json['id'];
    _offerConditions = json['offer_conditions'] != null ? CounterDetailsOfferConditions.fromJson(json['offer_conditions']) : null;
    if (json['offer_items'] != null) {
      _offerItems = [];
      json['offer_items'].forEach((v) {
        _offerItems?.add(CounterDetailsOfferItems.fromJson(v));
      });
    }
    _parent = json['parent'];
    _tabactivity = json['tabactivity'];
    _counteringstatus = json['counteringstatus'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _confirmSteps = json['confirm_steps'];
    _slug = json['slug'];
    _offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    _fromCounter = json['from_counter'] != null ? CounterDetailsFromCounter.fromJson(json['from_counter']) : null;
    _toCounter = json['to_counter'] != null ? CounterDetailsToCounter.fromJson(json['to_counter']) : null;
    if (json['offer_bid'] != null) {
      _offerBid = [];
      json['offer_bid'].forEach((v) {
        _offerBid?.add(OfferBidCouterDetails.fromJson(v));
      });
    }
  }
  num? _id;
  CounterDetailsOfferConditions? _offerConditions;
  List<CounterDetailsOfferItems>? _offerItems;
  dynamic _parent;
  String? _tabactivity;
  String? _counteringstatus;
  String? _createdAt;
  String? _modified;
  num? _confirmSteps;
  String? _slug;
  Offer? _offer;
  CounterDetailsFromCounter? _fromCounter;
  CounterDetailsToCounter? _toCounter;
  List<OfferBidCouterDetails>? _offerBid;
CounterOfferDetailsModelResult copyWith({  num? id,
  CounterDetailsOfferConditions? offerConditions,
  List<CounterDetailsOfferItems>? offerItems,
  dynamic parent,
  String? tabactivity,
  String? counteringstatus,
  String? createdAt,
  String? modified,
  num? confirmSteps,
  String? slug,
  Offer? offer,
  CounterDetailsFromCounter? fromCounter,
  CounterDetailsToCounter? toCounter,
  List<OfferBidCouterDetails>? offerBid,
}) => CounterOfferDetailsModelResult(  id: id ?? _id,
  offerConditions: offerConditions ?? _offerConditions,
  offerItems: offerItems ?? _offerItems,
  parent: parent ?? _parent,
  tabactivity: tabactivity ?? _tabactivity,
  counteringstatus: counteringstatus ?? _counteringstatus,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  confirmSteps: confirmSteps ?? _confirmSteps,
  slug: slug ?? _slug,
  offer: offer ?? _offer,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
  offerBid: offerBid ?? _offerBid,
);
  num? get id => _id;
  CounterDetailsOfferConditions? get offerConditions => _offerConditions;
  List<CounterDetailsOfferItems>? get offerItems => _offerItems;
  dynamic get parent => _parent;
  String? get tabactivity => _tabactivity;
  String? get counteringstatus => _counteringstatus;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  num? get confirmSteps => _confirmSteps;
  String? get slug => _slug;
  Offer? get offer => _offer;
  CounterDetailsFromCounter? get fromCounter => _fromCounter;
  CounterDetailsToCounter? get toCounter => _toCounter;
  List<OfferBidCouterDetails>? get offerBid => _offerBid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_offerConditions != null) {
      map['offer_conditions'] = _offerConditions?.toJson();
    }
    if (_offerItems != null) {
      map['offer_items'] = _offerItems?.map((v) => v.toJson()).toList();
    }
    map['parent'] = _parent;
    map['tabactivity'] = _tabactivity;
    map['counteringstatus'] = _counteringstatus;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['confirm_steps'] = _confirmSteps;
    map['slug'] = _slug;
    if (_offer != null) {
      map['offer'] = _offer?.toJson();
    }
    if (_fromCounter != null) {
      map['from_counter'] = _fromCounter?.toJson();
    }
    if (_toCounter != null) {
      map['to_counter'] = _toCounter?.toJson();
    }
    if (_offerBid != null) {
      map['offer_bid'] = _offerBid?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class OfferBidCouterDetails {
  OfferBidCouterDetails({
      num? id,
      String? comment,
      String? createdAt,
      CounterDetailsFromCounter? fromCounter,
      CounterDetailsToCounter? toCounter,
      Offer? offer,}){
    _id = id;
    _comment = comment;
    _createdAt = createdAt;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
    _offer = offer;
}

  OfferBidCouterDetails.fromJson(dynamic json) {
    _id = json['id'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _fromCounter = json['from_counter'] != null ? CounterDetailsFromCounter.fromJson(json['from_counter']) : null;
    _toCounter = json['to_counter'] != null ? CounterDetailsToCounter.fromJson(json['to_counter']) : null;
    _offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
  }
  num? _id;
  String? _comment;
  String? _createdAt;
  CounterDetailsFromCounter? _fromCounter;
  CounterDetailsToCounter? _toCounter;
  Offer? _offer;
OfferBidCouterDetails copyWith({  num? id,
  String? comment,
  String? createdAt,
  CounterDetailsFromCounter? fromCounter,
  CounterDetailsToCounter? toCounter,
  Offer? offer,
}) => OfferBidCouterDetails(  id: id ?? _id,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
  offer: offer ?? _offer,
);
  num? get id => _id;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  CounterDetailsFromCounter? get fromCounter => _fromCounter;
  CounterDetailsToCounter? get toCounter => _toCounter;
  Offer? get offer => _offer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    if (_fromCounter != null) {
      map['from_counter'] = _fromCounter?.toJson();
    }
    if (_toCounter != null) {
      map['to_counter'] = _toCounter?.toJson();
    }
    if (_offer != null) {
      map['offer'] = _offer?.toJson();
    }
    return map;
  }

}

/// id : 81
/// tabactivity : "ANSWER"
/// counteringstatus : "OPEN"
/// created_at : "20-07-2023 17:28"
/// modified : "20-07-2023 17:28"
/// confirm_steps : 0
/// slug : "electronics mobiles 5g mohan1 address43 khajrana main rd pipal chowk khajrana main rd indore"
/// offer : 115
/// parent : null
/// from_counter_bid : null
/// to_counter_bid : null

class Offer {
  Offer({
      num? id,
      String? tabactivity,
      String? counteringstatus,
      String? createdAt,
      String? modified,
      num? confirmSteps,
      String? slug,
      num? offer,
      dynamic parent,
      dynamic fromCounterBid,
      dynamic toCounterBid,}){
    _id = id;
    _tabactivity = tabactivity;
    _counteringstatus = counteringstatus;
    _createdAt = createdAt;
    _modified = modified;
    _confirmSteps = confirmSteps;
    _slug = slug;
    _offer = offer;
    _parent = parent;
    _fromCounterBid = fromCounterBid;
    _toCounterBid = toCounterBid;
}

  Offer.fromJson(dynamic json) {
    _id = json['id'];
    _tabactivity = json['tabactivity'];
    _counteringstatus = json['counteringstatus'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _confirmSteps = json['confirm_steps'];
    _slug = json['slug'];
    _offer = json['offer'];
    _parent = json['parent'];
    _fromCounterBid = json['from_counter'];
    _toCounterBid = json['to_counter'];
  }
  num? _id;
  String? _tabactivity;
  String? _counteringstatus;
  String? _createdAt;
  String? _modified;
  num? _confirmSteps;
  String? _slug;
  num? _offer;
  dynamic _parent;
  dynamic _fromCounterBid;
  dynamic _toCounterBid;
Offer copyWith({  num? id,
  String? tabactivity,
  String? counteringstatus,
  String? createdAt,
  String? modified,
  num? confirmSteps,
  String? slug,
  num? offer,
  dynamic parent,
  dynamic fromCounterBid,
  dynamic toCounterBid,
}) => Offer(  id: id ?? _id,
  tabactivity: tabactivity ?? _tabactivity,
  counteringstatus: counteringstatus ?? _counteringstatus,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  confirmSteps: confirmSteps ?? _confirmSteps,
  slug: slug ?? _slug,
  offer: offer ?? _offer,
  parent: parent ?? _parent,
  fromCounterBid: fromCounterBid ?? _fromCounterBid,
  toCounterBid: toCounterBid ?? _toCounterBid,
);
  num? get id => _id;
  String? get tabactivity => _tabactivity;
  String? get counteringstatus => _counteringstatus;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  num? get confirmSteps => _confirmSteps;
  String? get slug => _slug;
  num? get offer => _offer;
  dynamic get parent => _parent;
  dynamic get fromCounterBid => _fromCounterBid;
  dynamic get toCounterBid => _toCounterBid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tabactivity'] = _tabactivity;
    map['counteringstatus'] = _counteringstatus;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['confirm_steps'] = _confirmSteps;
    map['slug'] = _slug;
    map['offer'] = _offer;
    map['parent'] = _parent;
    map['from_counter_bid'] = _fromCounterBid;
    map['to_counter_bid'] = _toCounterBid;
    return map;
  }

}



class CounterDetailsToCounter {
  CounterDetailsToCounter({
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
      dynamic classification,
      bool? movable,
      String? addressORarea,
      String? operatingaddress,
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
      dynamic followers,
      dynamic following,}){
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
    _followers = followers;
    _following = following;
}

  CounterDetailsToCounter.fromJson(dynamic json) {
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
    _followers = json['followers'];
    _following = json['following'];
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
  dynamic _classification;
  bool? _movable;
  String? _addressORarea;
  String? _operatingaddress;
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
  dynamic _followers;
  dynamic _following;
CounterDetailsToCounter copyWith({  num? id,
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
  String? operatingaddress,
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
  dynamic followers,
  dynamic following,
}) => CounterDetailsToCounter(  id: id ?? _id,
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
  dynamic get classification => _classification;
  bool? get movable => _movable;
  String? get addressORarea => _addressORarea;
  String? get operatingaddress => _operatingaddress;
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
  dynamic get followers => _followers;
  dynamic get following => _following;

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
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}



class CounterDetailsFromCounter {
  CounterDetailsFromCounter({
      num? id,
      String? displayname,
      String? phonenumber,
      String? username,
      dynamic email,
      dynamic profilePicture,
      dynamic pagePicture,
      dynamic desc,
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
      dynamic followers,
      dynamic following,}){
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
    _followers = followers;
    _following = following;
}

  CounterDetailsFromCounter.fromJson(dynamic json) {
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
    _followers = json['followers'];
    _following = json['following'];
  }
  num? _id;
  String? _displayname;
  String? _phonenumber;
  String? _username;
  dynamic _email;
  dynamic _profilePicture;
  dynamic _pagePicture;
  dynamic _desc;
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
  dynamic _followers;
  dynamic _following;
CounterDetailsFromCounter copyWith({  num? id,
  String? displayname,
  String? phonenumber,
  String? username,
  dynamic email,
  dynamic profilePicture,
  dynamic pagePicture,
  dynamic desc,
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
  dynamic followers,
  dynamic following,
}) => CounterDetailsFromCounter(  id: id ?? _id,
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
  followers: followers ?? _followers,
  following: following ?? _following,
);
  num? get id => _id;
  String? get displayname => _displayname;
  String? get phonenumber => _phonenumber;
  String? get username => _username;
  dynamic get email => _email;
  dynamic get profilePicture => _profilePicture;
  dynamic get pagePicture => _pagePicture;
  dynamic get desc => _desc;
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
  dynamic get followers => _followers;
  dynamic get following => _following;

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
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}





class Following {
  Following({
      num? id,
      dynamic displayname,
      String? phonenumber,
      String? username,
      dynamic email,
      dynamic profilePicture,
      dynamic pagePicture,
      dynamic desc,
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
      dynamic followers,
      dynamic following,}){
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
    _followers = followers;
    _following = following;
}

  Following.fromJson(dynamic json) {
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
    _followers = json['followers'];
    _following = json['following'];
  }
  num? _id;
  dynamic _displayname;
  String? _phonenumber;
  String? _username;
  dynamic _email;
  dynamic _profilePicture;
  dynamic _pagePicture;
  dynamic _desc;
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
  dynamic _followers;
  dynamic _following;
Following copyWith({  num? id,
  dynamic displayname,
  String? phonenumber,
  String? username,
  dynamic email,
  dynamic profilePicture,
  dynamic pagePicture,
  dynamic desc,
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
  dynamic followers,
  dynamic following,
}) => Following(  id: id ?? _id,
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
  followers: followers ?? _followers,
  following: following ?? _following,
);
  num? get id => _id;
  dynamic get displayname => _displayname;
  String? get phonenumber => _phonenumber;
  String? get username => _username;
  dynamic get email => _email;
  dynamic get profilePicture => _profilePicture;
  dynamic get pagePicture => _pagePicture;
  dynamic get desc => _desc;
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
  dynamic get followers => _followers;
  dynamic get following => _following;

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
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}

/// id : 5
/// displayname : null
/// phonenumber : "9977665544"
/// username : "mohan"
/// email : null
/// profile_picture : null
/// page_picture : null
/// desc : null
/// placeORperson : "person"
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
/// created_at : "15-05-2023 11:40"
/// modified : "15-05-2023 11:40"
/// followers : null
/// following : null

class Followers {
  Followers({
      num? id,
      dynamic displayname,
      String? phonenumber,
      String? username,
      dynamic email,
      dynamic profilePicture,
      dynamic pagePicture,
      dynamic desc,
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
      dynamic followers,
      dynamic following,}){
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
    _followers = followers;
    _following = following;
}

  Followers.fromJson(dynamic json) {
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
    _followers = json['followers'];
    _following = json['following'];
  }
  num? _id;
  dynamic _displayname;
  String? _phonenumber;
  String? _username;
  dynamic _email;
  dynamic _profilePicture;
  dynamic _pagePicture;
  dynamic _desc;
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
  dynamic _followers;
  dynamic _following;
Followers copyWith({  num? id,
  dynamic displayname,
  String? phonenumber,
  String? username,
  dynamic email,
  dynamic profilePicture,
  dynamic pagePicture,
  dynamic desc,
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
  dynamic followers,
  dynamic following,
}) => Followers(  id: id ?? _id,
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
  followers: followers ?? _followers,
  following: following ?? _following,
);
  num? get id => _id;
  dynamic get displayname => _displayname;
  String? get phonenumber => _phonenumber;
  String? get username => _username;
  dynamic get email => _email;
  dynamic get profilePicture => _profilePicture;
  dynamic get pagePicture => _pagePicture;
  dynamic get desc => _desc;
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
  dynamic get followers => _followers;
  dynamic get following => _following;

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
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}


class Subsegment {
  Subsegment({
      num? id,
      String? name,
      num? segment,}){
    _id = id;
    _name = name;
    _segment = segment;
}

  Subsegment.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _segment = json['segment'];
  }
  num? _id;
  String? _name;
  num? _segment;
Subsegment copyWith({  num? id,
  String? name,
  num? segment,
}) => Subsegment(  id: id ?? _id,
  name: name ?? _name,
  segment: segment ?? _segment,
);
  num? get id => _id;
  String? get name => _name;
  num? get segment => _segment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['segment'] = _segment;
    return map;
  }

}

/// id : 3
/// name : "Mobiles"
/// category : 3

class Segment {
  Segment({
      num? id,
      String? name,
      num? category,}){
    _id = id;
    _name = name;
    _category = category;
}

  Segment.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _category = json['category'];
  }
  num? _id;
  String? _name;
  num? _category;
Segment copyWith({  num? id,
  String? name,
  num? category,
}) => Segment(  id: id ?? _id,
  name: name ?? _name,
  category: category ?? _category,
);
  num? get id => _id;
  String? get name => _name;
  num? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['category'] = _category;
    return map;
  }

}

/// id : 3
/// name : "Electronics"

class Category {
  Category({
      num? id,
      String? name,}){
    _id = id;
    _name = name;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Category copyWith({  num? id,
  String? name,
}) => Category(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}



class Subscribers {
  Subscribers({
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
    dynamic classification,
      bool? movable,
      String? addressORarea,
      String? operatingaddress,
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
      dynamic followers,
      dynamic following,}){
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
    _followers = followers;
    _following = following;
}

  Subscribers.fromJson(dynamic json) {
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
    _followers = json['followers'];
    _following = json['following'];
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
  dynamic _classification;
  bool? _movable;
  String? _addressORarea;
  String? _operatingaddress;
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
  dynamic _followers;
  dynamic _following;
Subscribers copyWith({  num? id,
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
  String? operatingaddress,
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
  dynamic followers,
  dynamic following,
}) => Subscribers(  id: id ?? _id,
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
  dynamic get classification => _classification;
  bool? get movable => _movable;
  String? get addressORarea => _addressORarea;
  String? get operatingaddress => _operatingaddress;
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
  dynamic get followers => _followers;
  dynamic get following => _following;

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
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}

/// id : 139
/// offer_item_conditions : {"id":119,"servicepersons":null,"periodicity":"Monthly","fromperiod":"22-07-2023","toperiod":"28-08-2023","duration":"1 Months 7 Days","fromperiodtime":"17:24:00","toperiodtime":"17:24:00","durationoftime":null,"fromlocation":"","tolocation":"","atlocation":"","priority":"PREMIUM","expiry":"24-07-2023 17:24","counter_offer_item":139}
/// item_media : [{"id":119,"media_type":"","media":"/media/counterofferitemsmedia/temp_yD9U7IP.jpg","counter_offer_item":139}]
/// name : "OnePlus Nord"
/// desc : "I need to multiple OnePlus mobile"
/// quantity : 5
/// unit : "upto mobile"
/// price : 20000.0
/// currency : "INR"
/// addon : false
/// required : true
/// toggle_state : true
/// counter_offer : 81


class CounterDetailsOfferItems {
  CounterDetailsOfferItems({
    num? id,
    OfferItemConditions? offerItemConditions,
    List<ItemMedia>? itemMedia,
    Unit? unit,
    AdvanceUnit? advanceUnit,
    MaintenanceUnit? maintenanceUnit,
    String? name,
    String? desc,
    num? quantity,
    num? price,
    dynamic advancePrice,
    dynamic maintenancePrice,
    String? currency,
    bool? addon,
    bool? required,
    bool? toggleState,
    String? createDate,
    num? counterOffer,
    num? user,}){
    _id = id;
    _offerItemConditions = offerItemConditions;
    _itemMedia = itemMedia;
    _unit = unit;
    _advanceUnit = advanceUnit;
    _maintenanceUnit = maintenanceUnit;
    _name = name;
    _desc = desc;
    _quantity = quantity;
    _price = price;
    _advancePrice = advancePrice;
    _maintenancePrice = maintenancePrice;
    _currency = currency;
    _addon = addon;
    _required = required;
    _toggleState = toggleState;
    _createDate = createDate;
    _counterOffer = counterOffer;
    _user = user;
  }

  CounterDetailsOfferItems.fromJson(dynamic json) {
    _id = json['id'];
    _offerItemConditions = json['offer_item_conditions'] != null ? OfferItemConditions.fromJson(json['offer_item_conditions']) : null;
    if (json['item_media'] != null) {
      _itemMedia = [];
      json['item_media'].forEach((v) {
        _itemMedia?.add(ItemMedia.fromJson(v));
      });
    }
    _unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    _advanceUnit = json['advance_unit'] != null ? AdvanceUnit.fromJson(json['advance_unit']) : null;
    _maintenanceUnit = json['maintenance_unit'] != null ? MaintenanceUnit.fromJson(json['maintenance_unit']) : null;
    _name = json['name'];
    _desc = json['desc'];
    _quantity = json['quantity'];
    _price = json['price'];
    _advancePrice = json['advance_price'];
    _maintenancePrice = json['maintenance_price'];
    _currency = json['currency'];
    _addon = json['addon'];
    _required = json['required'];
    _toggleState = json['toggle_state'];
    _createDate = json['create_date'];
    _counterOffer = json['counter_offer'];
    _user = json['user'];
  }
  num? _id;
  OfferItemConditions? _offerItemConditions;
  List<ItemMedia>? _itemMedia;
  Unit? _unit;
  AdvanceUnit? _advanceUnit;
  MaintenanceUnit? _maintenanceUnit;
  String? _name;
  String? _desc;
  num? _quantity;
  num? _price;
  dynamic _advancePrice;
  dynamic _maintenancePrice;
  String? _currency;
  bool? _addon;
  bool? _required;
  bool? _toggleState;
  String? _createDate;
  num? _counterOffer;
  num? _user;
  CounterDetailsOfferItems copyWith({  num? id,
    OfferItemConditions? offerItemConditions,
    List<ItemMedia>? itemMedia,
    Unit? unit,
    AdvanceUnit? advanceUnit,
    MaintenanceUnit? maintenanceUnit,
    String? name,
    String? desc,
    num? quantity,
    num? price,
    dynamic advancePrice,
    dynamic maintenancePrice,
    String? currency,
    bool? addon,
    bool? required,
    bool? toggleState,
    String? createDate,
    num? counterOffer,
    num? user,
  }) => CounterDetailsOfferItems(  id: id ?? _id,
    offerItemConditions: offerItemConditions ?? _offerItemConditions,
    itemMedia: itemMedia ?? _itemMedia,
    unit: unit ?? _unit,
    advanceUnit: advanceUnit ?? _advanceUnit,
    maintenanceUnit: maintenanceUnit ?? _maintenanceUnit,
    name: name ?? _name,
    desc: desc ?? _desc,
    quantity: quantity ?? _quantity,
    price: price ?? _price,
    advancePrice: advancePrice ?? _advancePrice,
    maintenancePrice: maintenancePrice ?? _maintenancePrice,
    currency: currency ?? _currency,
    addon: addon ?? _addon,
    required: required ?? _required,
    toggleState: toggleState ?? _toggleState,
    createDate: createDate ?? _createDate,
    counterOffer: counterOffer ?? _counterOffer,
    user: user ?? _user,
  );
  num? get id => _id;
  OfferItemConditions? get offerItemConditions => _offerItemConditions;
  List<ItemMedia>? get itemMedia => _itemMedia;
  Unit? get unit => _unit;
  AdvanceUnit? get advanceUnit => _advanceUnit;
  MaintenanceUnit? get maintenanceUnit => _maintenanceUnit;
  String? get name => _name;
  String? get desc => _desc;
  num? get quantity => _quantity;
  num? get price => _price;
  dynamic get advancePrice => _advancePrice;
  dynamic get maintenancePrice => _maintenancePrice;
  String? get currency => _currency;
  bool? get addon => _addon;
  bool? get required => _required;
  bool? get toggleState => _toggleState;
  String? get createDate => _createDate;
  num? get counterOffer => _counterOffer;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_offerItemConditions != null) {
      map['offer_item_conditions'] = _offerItemConditions?.toJson();
    }
    if (_itemMedia != null) {
      map['item_media'] = _itemMedia?.map((v) => v.toJson()).toList();
    }
    if (_unit != null) {
      map['unit'] = _unit?.toJson();
    }
    if (_advanceUnit != null) {
      map['advance_unit'] = _advanceUnit?.toJson();
    }
    if (_maintenanceUnit != null) {
      map['maintenance_unit'] = _maintenanceUnit?.toJson();
    }
    map['name'] = _name;
    map['desc'] = _desc;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['advance_price'] = _advancePrice;
    map['maintenance_price'] = _maintenancePrice;
    map['currency'] = _currency;
    map['addon'] = _addon;
    map['required'] = _required;
    map['toggle_state'] = _toggleState;
    map['create_date'] = _createDate;
    map['counter_offer'] = _counterOffer;
    map['user'] = _user;
    return map;
  }

}

/// id : null
/// name : null

class MaintenanceUnit {
  MaintenanceUnit({
    dynamic id,
    dynamic name,}){
    _id = id;
    _name = name;
  }

  MaintenanceUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  dynamic _id;
  dynamic _name;
  MaintenanceUnit copyWith({  dynamic id,
    dynamic name,
  }) => MaintenanceUnit(  id: id ?? _id,
    name: name ?? _name,
  );
  dynamic get id => _id;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : null
/// name : null

class AdvanceUnit {
  AdvanceUnit({
    dynamic id,
    dynamic name,}){
    _id = id;
    _name = name;
  }

  AdvanceUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  dynamic _id;
  dynamic _name;
  AdvanceUnit copyWith({  dynamic id,
    dynamic name,
  }) => AdvanceUnit(  id: id ?? _id,
    name: name ?? _name,
  );
  dynamic get id => _id;
  dynamic get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 6
/// name : "liter"

class Unit {
  Unit({
    num? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  Unit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  Unit copyWith({  num? id,
    String? name,
  }) => Unit(  id: id ?? _id,
    name: name ?? _name,
  );
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 282
/// media_type : ""
/// media : "/media/counterofferitemsmedia/temp_X9sWLRW.jpg"
/// counter_offer_item : 9

class ItemMedia {
  ItemMedia({
    String? id,
    String? file,
    String? name,}){
    _id = id;
    _file = file;
    _name = name;
  }

  ItemMedia.fromJson(dynamic json) {
    _id = json['id'];
    _file = json['file'];
    _name = json['name'];
  }
  String? _id;
  String? _file;
  String? _name;
  ItemMedia copyWith({  String? id,
    String? file,
    String? name,
  }) => ItemMedia(  id: id ?? _id,
    file: file ?? _file,
    name: name ?? _name,
  );
  String? get id => _id;
  String? get file => _file;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['file'] = _file;
    map['name'] = _name;
    return map;
  }

}

/// id : 317
/// serviceperson : [{"id":107,"username":"sandeep","displayname":"Sandeep"}]
/// periodicity : "Weekends"
/// fromperiod : "22-08-2023"
/// toperiod : "04-09-2023"
/// duration : "13 Days"
/// fromperiodtime : "13:03:00"
/// toperiodtime : "13:03:00"
/// durationoftime : null
/// fromlocation : "43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore"
/// tolocation : ""
/// atlocation : ""
/// priority : "PREMIUM"
/// expiry : "21-08-2023 13:03"
/// counter_offer_item : 9
/// servicepersons : [107]

class OfferItemConditions {
  OfferItemConditions({
    num? id,
    List<Serviceperson>? serviceperson,
    String? periodicity,
    String? fromperiod,
    String? toperiod,
    String? duration,
    String? fromperiodtime,
    String? toperiodtime,
    dynamic durationoftime,
    String? fromlocation,
    String? tolocation,
    String? atlocation,
    String? priority,
    String? expiry,
    num? counterOfferItem,
    List<num>? servicepersons,}){
    _id = id;
    _serviceperson = serviceperson;
    _periodicity = periodicity;
    _fromperiod = fromperiod;
    _toperiod = toperiod;
    _duration = duration;
    _fromperiodtime = fromperiodtime;
    _toperiodtime = toperiodtime;
    _durationoftime = durationoftime;
    _fromlocation = fromlocation;
    _tolocation = tolocation;
    _atlocation = atlocation;
    _priority = priority;
    _expiry = expiry;
    _counterOfferItem = counterOfferItem;
    _servicepersons = servicepersons;
  }

  OfferItemConditions.fromJson(dynamic json) {
    _id = json['id'];
    if (json['serviceperson'] != null) {
      _serviceperson = [];
      json['serviceperson'].forEach((v) {
        _serviceperson?.add(Serviceperson.fromJson(v));
      });
    }
    _periodicity = json['periodicity'];
    _fromperiod = json['fromperiod'];
    _toperiod = json['toperiod'];
    _duration = json['duration'];
    _fromperiodtime = json['fromperiodtime'];
    _toperiodtime = json['toperiodtime'];
    _durationoftime = json['durationoftime'];
    _fromlocation = json['fromlocation'];
    _tolocation = json['tolocation'];
    _atlocation = json['atlocation'];
    _priority = json['priority'];
    _expiry = json['expiry'];
    _counterOfferItem = json['counter_offer_item'];
    _servicepersons = json['servicepersons'] != null ? json['servicepersons'].cast<num>() : [];
  }
  num? _id;
  List<Serviceperson>? _serviceperson;
  String? _periodicity;
  String? _fromperiod;
  String? _toperiod;
  String? _duration;
  String? _fromperiodtime;
  String? _toperiodtime;
  dynamic _durationoftime;
  String? _fromlocation;
  String? _tolocation;
  String? _atlocation;
  String? _priority;
  String? _expiry;
  num? _counterOfferItem;
  List<num>? _servicepersons;
  OfferItemConditions copyWith({  num? id,
    List<Serviceperson>? serviceperson,
    String? periodicity,
    String? fromperiod,
    String? toperiod,
    String? duration,
    String? fromperiodtime,
    String? toperiodtime,
    dynamic durationoftime,
    String? fromlocation,
    String? tolocation,
    String? atlocation,
    String? priority,
    String? expiry,
    num? counterOfferItem,
    List<num>? servicepersons,
  }) => OfferItemConditions(  id: id ?? _id,
    serviceperson: serviceperson ?? _serviceperson,
    periodicity: periodicity ?? _periodicity,
    fromperiod: fromperiod ?? _fromperiod,
    toperiod: toperiod ?? _toperiod,
    duration: duration ?? _duration,
    fromperiodtime: fromperiodtime ?? _fromperiodtime,
    toperiodtime: toperiodtime ?? _toperiodtime,
    durationoftime: durationoftime ?? _durationoftime,
    fromlocation: fromlocation ?? _fromlocation,
    tolocation: tolocation ?? _tolocation,
    atlocation: atlocation ?? _atlocation,
    priority: priority ?? _priority,
    expiry: expiry ?? _expiry,
    counterOfferItem: counterOfferItem ?? _counterOfferItem,
    servicepersons: servicepersons ?? _servicepersons,
  );
  num? get id => _id;
  List<Serviceperson>? get serviceperson => _serviceperson;
  String? get periodicity => _periodicity;
  String? get fromperiod => _fromperiod;
  String? get toperiod => _toperiod;
  String? get duration => _duration;
  String? get fromperiodtime => _fromperiodtime;
  String? get toperiodtime => _toperiodtime;
  dynamic get durationoftime => _durationoftime;
  String? get fromlocation => _fromlocation;
  String? get tolocation => _tolocation;
  String? get atlocation => _atlocation;
  String? get priority => _priority;
  String? get expiry => _expiry;
  num? get counterOfferItem => _counterOfferItem;
  List<num>? get servicepersons => _servicepersons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_serviceperson != null) {
      map['serviceperson'] = _serviceperson?.map((v) => v.toJson()).toList();
    }
    map['periodicity'] = _periodicity;
    map['fromperiod'] = _fromperiod;
    map['toperiod'] = _toperiod;
    map['duration'] = _duration;
    map['fromperiodtime'] = _fromperiodtime;
    map['toperiodtime'] = _toperiodtime;
    map['durationoftime'] = _durationoftime;
    map['fromlocation'] = _fromlocation;
    map['tolocation'] = _tolocation;
    map['atlocation'] = _atlocation;
    map['priority'] = _priority;
    map['expiry'] = _expiry;
    map['counter_offer_item'] = _counterOfferItem;
    map['servicepersons'] = _servicepersons;
    return map;
  }

}

/// id : 107
/// username : "sandeep"
/// displayname : "Sandeep"

class Serviceperson {
  Serviceperson({
    num? id,
    String? username,
    String? displayname,}){
    _id = id;
    _username = username;
    _displayname = displayname;
  }

  Serviceperson.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _displayname = json['displayname'];
  }
  num? _id;
  String? _username;
  String? _displayname;
  Serviceperson copyWith({  num? id,
    String? username,
    String? displayname,
  }) => Serviceperson(  id: id ?? _id,
    username: username ?? _username,
    displayname: displayname ?? _displayname,
  );
  num? get id => _id;
  String? get username => _username;
  String? get displayname => _displayname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['displayname'] = _displayname;
    return map;
  }

}

/// id : 119
/// media_type : ""
/// media : "/media/counterofferitemsmedia/temp_yD9U7IP.jpg"
/// counter_offer_item : 139


/// id : 144
/// servicepersons : null
/// periodicity : "Monthly"
/// fromperiod : "22-07-2023"
/// toperiod : "23-09-2023"
/// duration : "2 Months 3 Days"
/// fromperiodtime : "17:22:00"
/// toperiodtime : "17:22:00"
/// durationoftime : ""
/// fromlocation : "Gagan Leather House, Indore"
/// tolocation : ""
/// atlocation : ""
/// priority : "URGENT"
/// expiry : "10-08-2023 17:22"
/// offer : 81

class CounterDetailsOfferConditions {
  CounterDetailsOfferConditions({
      num? id,
      dynamic servicepersons,
      String? periodicity,
      String? fromperiod,
      String? toperiod,
      String? duration,
      String? fromperiodtime,
      String? toperiodtime,
      String? durationoftime,
      String? fromlocation,
      String? tolocation,
      String? atlocation,
      String? priority,
      String? expiry,
      num? offer,}){
    _id = id;
    _servicepersons = servicepersons;
    _periodicity = periodicity;
    _fromperiod = fromperiod;
    _toperiod = toperiod;
    _duration = duration;
    _fromperiodtime = fromperiodtime;
    _toperiodtime = toperiodtime;
    _durationoftime = durationoftime;
    _fromlocation = fromlocation;
    _tolocation = tolocation;
    _atlocation = atlocation;
    _priority = priority;
    _expiry = expiry;
    _offer = offer;
}

  CounterDetailsOfferConditions.fromJson(dynamic json) {
    _id = json['id'];
    _servicepersons = json['servicepersons'];
    _periodicity = json['periodicity'];
    _fromperiod = json['fromperiod'];
    _toperiod = json['toperiod'];
    _duration = json['duration'];
    _fromperiodtime = json['fromperiodtime'];
    _toperiodtime = json['toperiodtime'];
    _durationoftime = json['durationoftime'];
    _fromlocation = json['fromlocation'];
    _tolocation = json['tolocation'];
    _atlocation = json['atlocation'];
    _priority = json['priority'];
    _expiry = json['expiry'];
    _offer = json['offer'];
  }
  num? _id;
  dynamic _servicepersons;
  String? _periodicity;
  String? _fromperiod;
  String? _toperiod;
  String? _duration;
  String? _fromperiodtime;
  String? _toperiodtime;
  String? _durationoftime;
  String? _fromlocation;
  String? _tolocation;
  String? _atlocation;
  String? _priority;
  String? _expiry;
  num? _offer;
CounterDetailsOfferConditions copyWith({  num? id,
  dynamic servicepersons,
  String? periodicity,
  String? fromperiod,
  String? toperiod,
  String? duration,
  String? fromperiodtime,
  String? toperiodtime,
  String? durationoftime,
  String? fromlocation,
  String? tolocation,
  String? atlocation,
  String? priority,
  String? expiry,
  num? offer,
}) => CounterDetailsOfferConditions(  id: id ?? _id,
  servicepersons: servicepersons ?? _servicepersons,
  periodicity: periodicity ?? _periodicity,
  fromperiod: fromperiod ?? _fromperiod,
  toperiod: toperiod ?? _toperiod,
  duration: duration ?? _duration,
  fromperiodtime: fromperiodtime ?? _fromperiodtime,
  toperiodtime: toperiodtime ?? _toperiodtime,
  durationoftime: durationoftime ?? _durationoftime,
  fromlocation: fromlocation ?? _fromlocation,
  tolocation: tolocation ?? _tolocation,
  atlocation: atlocation ?? _atlocation,
  priority: priority ?? _priority,
  expiry: expiry ?? _expiry,
  offer: offer ?? _offer,
);
  num? get id => _id;
  dynamic get servicepersons => _servicepersons;
  String? get periodicity => _periodicity;
  String? get fromperiod => _fromperiod;
  String? get toperiod => _toperiod;
  String? get duration => _duration;
  String? get fromperiodtime => _fromperiodtime;
  String? get toperiodtime => _toperiodtime;
  String? get durationoftime => _durationoftime;
  String? get fromlocation => _fromlocation;
  String? get tolocation => _tolocation;
  String? get atlocation => _atlocation;
  String? get priority => _priority;
  String? get expiry => _expiry;
  num? get offer => _offer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['servicepersons'] = _servicepersons;
    map['periodicity'] = _periodicity;
    map['fromperiod'] = _fromperiod;
    map['toperiod'] = _toperiod;
    map['duration'] = _duration;
    map['fromperiodtime'] = _fromperiodtime;
    map['toperiodtime'] = _toperiodtime;
    map['durationoftime'] = _durationoftime;
    map['fromlocation'] = _fromlocation;
    map['tolocation'] = _tolocation;
    map['atlocation'] = _atlocation;
    map['priority'] = _priority;
    map['expiry'] = _expiry;
    map['offer'] = _offer;
    return map;
  }

}