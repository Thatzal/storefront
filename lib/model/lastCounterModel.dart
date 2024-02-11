
class LastCounterModel {
  LastCounterModel({
      String? status, 
      String? message, 
      lastCounterData? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  LastCounterModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? lastCounterData.fromJson(json['result']) : null;
  }
  String? _status;
  String? _message;
  lastCounterData? _result;
LastCounterModel copyWith({  String? status,
  String? message,
  lastCounterData? result,
}) => LastCounterModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  lastCounterData? get result => _result;

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


class lastCounterData {
  lastCounterData({
      num? id, 
      OfferConditions? offerConditions, 
      List<OfferItems>? offerItems, 
      dynamic parent, 
      Offer? offer, 
      String? tabactivity, 
      String? counteringstatus, 
      String? createdAt, 
      String? modified, 
      num? confirmSteps,
      String ? confirmBy,
      String? slug, 
      FromCounter? fromCounter, 
      ToCounter? toCounter, 
      List<OfferBid>? offerBid, 
      List<Counters>? counters, 
      dynamic offerNotify,}){
    _id = id;
    _offerConditions = offerConditions;
    _offerItems = offerItems;
    _parent = parent;
    _offer = offer;
    _tabactivity = tabactivity;
    _counteringstatus = counteringstatus;
    _createdAt = createdAt;
    _modified = modified;
    _confirmSteps = confirmSteps;
    _confirmBy = confirmBy;
    _slug = slug;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
    _offerBid = offerBid;
    _counters = counters;
    _offerNotify = offerNotify;
}

  lastCounterData.fromJson(dynamic json) {
    _id = json['id'];
    _offerConditions = json['offer_conditions'] != null ? OfferConditions.fromJson(json['offer_conditions']) : null;
    if (json['offer_items'] != null) {
      _offerItems = [];
      json['offer_items'].forEach((v) {
        _offerItems?.add(OfferItems.fromJson(v));
      });
    }
    _parent = json['parent'];
    _offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    _tabactivity = json['tabactivity'];
    _counteringstatus = json['counteringstatus'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _confirmSteps = json['confirm_steps'];
    _confirmBy = json["confirm_by"];
    _slug = json['slug'];
    _fromCounter = json['from_counter'] != null ? FromCounter.fromJson(json['from_counter']) : null;
    _toCounter = json['to_counter'] != null ? ToCounter.fromJson(json['to_counter']) : null;
    if (json['offer_bid'] != null) {
      _offerBid = [];
      json['offer_bid'].forEach((v) {
        _offerBid?.add(OfferBid.fromJson(v));
      });
    }
    if (json['counters'] != null) {
      _counters = [];
      json['counters'].forEach((v) {
        _counters?.add(Counters.fromJson(v));
      });
    }
    _offerNotify = json['offer_notify'];
  }
  num? _id;
  OfferConditions? _offerConditions;
  List<OfferItems>? _offerItems;
  dynamic _parent;
  Offer? _offer;
  String? _tabactivity;
  String? _counteringstatus;
  String? _createdAt;
  String? _modified;
  String ? _confirmBy;
  num? _confirmSteps;
  String? _slug;
  FromCounter? _fromCounter;
  ToCounter? _toCounter;
  List<OfferBid>? _offerBid;
  List<Counters>? _counters;
  dynamic _offerNotify;
lastCounterData copyWith({
  num? id,
  OfferConditions? offerConditions,
  List<OfferItems>? offerItems,
  dynamic parent,
  Offer? offer,
  String? tabactivity,
  String? counteringstatus,
  String? createdAt,
  String? modified,
  num? confirmSteps,
  String ? confirmBy,
  String? slug,
  FromCounter? fromCounter,
  ToCounter? toCounter,
  List<OfferBid>? offerBid,
  List<Counters>? counters,
  dynamic offerNotify,
}) => lastCounterData(
  id: id ?? _id,
  offerConditions: offerConditions ?? _offerConditions,
  offerItems: offerItems ?? _offerItems,
  parent: parent ?? _parent,
  offer: offer ?? _offer,
  tabactivity: tabactivity ?? _tabactivity,
  counteringstatus: counteringstatus ?? _counteringstatus,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  confirmSteps: confirmSteps ?? _confirmSteps,
  confirmBy: confirmBy ?? _confirmBy,
  slug: slug ?? _slug,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
  offerBid: offerBid ?? _offerBid,
  counters: counters ?? _counters,
  offerNotify: offerNotify ?? _offerNotify,
);
  num? get id => _id;
  OfferConditions? get offerConditions => _offerConditions;
  List<OfferItems>? get offerItems => _offerItems;
  dynamic get parent => _parent;
  Offer? get offer => _offer;
  String? get tabactivity => _tabactivity;
  String? get counteringstatus => _counteringstatus;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  String ? get confirmBy => _confirmBy;
  num? get confirmSteps => _confirmSteps;
  String? get slug => _slug;
  FromCounter? get fromCounter => _fromCounter;
  ToCounter? get toCounter => _toCounter;
  List<OfferBid>? get offerBid => _offerBid;
  List<Counters>? get counters => _counters;
  dynamic get offerNotify => _offerNotify;

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
    if (_offer != null) {
      map['offer'] = _offer?.toJson();
    }
    map['tabactivity'] = _tabactivity;
    map['counteringstatus'] = _counteringstatus;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['confirm_by'] = _confirmBy;
    map['confirm_steps'] = _confirmSteps;
    map['slug'] = _slug;
    if (_fromCounter != null) {
      map['from_counter'] = _fromCounter?.toJson();
    }
    if (_toCounter != null) {
      map['to_counter'] = _toCounter?.toJson();
    }
    if (_offerBid != null) {
      map['offer_bid'] = _offerBid?.map((v) => v.toJson()).toList();
    }
    if (_counters != null) {
      map['counters'] = _counters?.map((v) => v.toJson()).toList();
    }
    map['offer_notify'] = _offerNotify;
    return map;
  }

}


class Counters {
  Counters({
      num? id, 
      num? fromCounterId, 
      num? toCounterId, 
      String? fromCounter, 
      String? toCounter,}){
    _id = id;
    _fromCounterId = fromCounterId;
    _toCounterId = toCounterId;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
}

  Counters.fromJson(dynamic json) {
    _id = json['id'];
    _fromCounterId = json['from_counter_id'];
    _toCounterId = json['to_counter_id'];
    _fromCounter = json['from_counter'];
    _toCounter = json['to_counter'];
  }
  num? _id;
  num? _fromCounterId;
  num? _toCounterId;
  String? _fromCounter;
  String? _toCounter;
Counters copyWith({  num? id,
  num? fromCounterId,
  num? toCounterId,
  String? fromCounter,
  String? toCounter,
}) => Counters(  id: id ?? _id,
  fromCounterId: fromCounterId ?? _fromCounterId,
  toCounterId: toCounterId ?? _toCounterId,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
);
  num? get id => _id;
  num? get fromCounterId => _fromCounterId;
  num? get toCounterId => _toCounterId;
  String? get fromCounter => _fromCounter;
  String? get toCounter => _toCounter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['from_counter_id'] = _fromCounterId;
    map['to_counter_id'] = _toCounterId;
    map['from_counter'] = _fromCounter;
    map['to_counter'] = _toCounter;
    return map;
  }

}


class OfferBid {
  OfferBid({
      num? id, 
      String? comment, 
      String? createdAt, 
      String? modified, 
      FromCounter? fromCounter, 
      dynamic toCounter,}){
    _id = id;
    _comment = comment;
    _createdAt = createdAt;
    _modified = modified;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
}

  OfferBid.fromJson(dynamic json) {
    _id = json['id'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _fromCounter = json['from_counter'] != null ? FromCounter.fromJson(json['from_counter']) : null;
    _toCounter = json['to_counter'];
  }
  num? _id;
  String? _comment;
  String? _createdAt;
  String? _modified;
  FromCounter? _fromCounter;
  dynamic _toCounter;
OfferBid copyWith({  num? id,
  String? comment,
  String? createdAt,
  String? modified,
  FromCounter? fromCounter,
  dynamic toCounter,
}) => OfferBid(  id: id ?? _id,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
);
  num? get id => _id;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  FromCounter? get fromCounter => _fromCounter;
  dynamic get toCounter => _toCounter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    if (_fromCounter != null) {
      map['from_counter'] = _fromCounter?.toJson();
    }
    map['to_counter'] = _toCounter;
    return map;
  }

}



class FromCounter {
  FromCounter({
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
      String? passportnumber, 
      String? dateofissue, 
      String? nationality, 
      String? dateofbirth, 
      String? gender, 
      String? religion, 
      String? subreligion, 
      String? caste, 
      String? subsect, 
      String? searchPagePositionPreferences, 
      String? offeringAreaPreference, 
      String? offerCategoryPreference, 
      String? offerSegmentPreference, 
      String? offerSubSegmentPreference, 
      String? currentLocation, 
      bool? wantToBuy, 
      bool? wantToSell, 
      bool? optDelivery, 
      bool? closeConfirmedOffers, 
      bool? okForCurrentLocationOffers, 
      String? offerMatchPercentage,
      dynamic meanComputedRating,
      num? numberofcomputations, 
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
    _deviceToken = deviceToken;
    _createdAt = createdAt;
    _modified = modified;
    _followers = followers;
    _following = following;
}

  FromCounter.fromJson(dynamic json) {
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
    _deviceToken = json['deviceToken'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
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
  dynamic _classification;
  bool? _movable;
  String? _addressORarea;
  String? _operatingaddress;
  String? _maritalstatus;
  String? _passportnumber;
  String? _dateofissue;
  String? _nationality;
  String? _dateofbirth;
  String? _gender;
  String? _religion;
  String? _subreligion;
  String? _caste;
  String? _subsect;
  String? _searchPagePositionPreferences;
  String? _offeringAreaPreference;
  String? _offerCategoryPreference;
  String? _offerSegmentPreference;
  String? _offerSubSegmentPreference;
  String? _currentLocation;
  bool? _wantToBuy;
  bool? _wantToSell;
  bool? _optDelivery;
  bool? _closeConfirmedOffers;
  bool? _okForCurrentLocationOffers;
  String? _offerMatchPercentage;
  dynamic _meanComputedRating;
  num? _numberofcomputations;
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
  List<num>? _followers;
  List<num>? _following;
FromCounter copyWith({  num? id,
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
  String? passportnumber,
  String? dateofissue,
  String? nationality,
  String? dateofbirth,
  String? gender,
  String? religion,
  String? subreligion,
  String? caste,
  String? subsect,
  String? searchPagePositionPreferences,
  String? offeringAreaPreference,
  String? offerCategoryPreference,
  String? offerSegmentPreference,
  String? offerSubSegmentPreference,
  String? currentLocation,
  bool? wantToBuy,
  bool? wantToSell,
  bool? optDelivery,
  bool? closeConfirmedOffers,
  bool? okForCurrentLocationOffers,
  String? offerMatchPercentage,
  dynamic meanComputedRating,
  num? numberofcomputations,
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
  List<num>? followers,
  List<num>? following,
}) => FromCounter(  id: id ?? _id,
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
  deviceToken: deviceToken ?? _deviceToken,
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
  String? get passportnumber => _passportnumber;
  String? get dateofissue => _dateofissue;
  String? get nationality => _nationality;
  String? get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get subreligion => _subreligion;
  String? get caste => _caste;
  String? get subsect => _subsect;
  String? get searchPagePositionPreferences => _searchPagePositionPreferences;
  String? get offeringAreaPreference => _offeringAreaPreference;
  String? get offerCategoryPreference => _offerCategoryPreference;
  String? get offerSegmentPreference => _offerSegmentPreference;
  String? get offerSubSegmentPreference => _offerSubSegmentPreference;
  String? get currentLocation => _currentLocation;
  bool? get wantToBuy => _wantToBuy;
  bool? get wantToSell => _wantToSell;
  bool? get optDelivery => _optDelivery;
  bool? get closeConfirmedOffers => _closeConfirmedOffers;
  bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
  String? get offerMatchPercentage => _offerMatchPercentage;
  dynamic get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
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
    map['deviceToken'] = _deviceToken;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}



class ToCounter {
  ToCounter({
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
      String? passportnumber, 
      String? dateofissue, 
      String? nationality, 
      String? dateofbirth, 
      String? gender, 
      String? religion, 
      String? subreligion, 
      String? caste, 
      String? subsect, 
      String? searchPagePositionPreferences, 
      String? offeringAreaPreference, 
      String? offerCategoryPreference, 
      String? offerSegmentPreference, 
      String? offerSubSegmentPreference, 
      String? currentLocation, 
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
      String? deviceToken, 
      String? createdAt, 
      String? modified, 
      List<Followers>? followers, 
      List<Following>? following,}){
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
    _deviceToken = deviceToken;
    _createdAt = createdAt;
    _modified = modified;
    _followers = followers;
    _following = following;
}

  ToCounter.fromJson(dynamic json) {
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
    _deviceToken = json['deviceToken'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    if (json['followers'] != null) {
      _followers = [];
      json['followers'].forEach((v) {
        _followers?.add(Followers.fromJson(v));
      });
    }
    if (json['following'] != null) {
      _following = [];
      json['following'].forEach((v) {
        _following?.add(Following.fromJson(v));
      });
    }
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
  String? _passportnumber;
  String? _dateofissue;
  String? _nationality;
  String? _dateofbirth;
  String? _gender;
  String? _religion;
  String? _subreligion;
  String? _caste;
  String? _subsect;
  String? _searchPagePositionPreferences;
  String? _offeringAreaPreference;
  String? _offerCategoryPreference;
  String? _offerSegmentPreference;
  String? _offerSubSegmentPreference;
  String? _currentLocation;
  bool? _wantToBuy;
  bool? _wantToSell;
  bool? _optDelivery;
  bool? _closeConfirmedOffers;
  bool? _okForCurrentLocationOffers;
  String? _offerMatchPercentage;
  dynamic _meanComputedRating;
  num? _numberofcomputations;
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
  List<Followers>? _followers;
  List<Following>? _following;
ToCounter copyWith({  num? id,
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
  String? passportnumber,
  String? dateofissue,
  String? nationality,
  String? dateofbirth,
  String? gender,
  String? religion,
  String? subreligion,
  String? caste,
  String? subsect,
  String? searchPagePositionPreferences,
  String? offeringAreaPreference,
  String? offerCategoryPreference,
  String? offerSegmentPreference,
  String? offerSubSegmentPreference,
  String? currentLocation,
  bool? wantToBuy,
  bool? wantToSell,
  bool? optDelivery,
  bool? closeConfirmedOffers,
  bool? okForCurrentLocationOffers,
  String? offerMatchPercentage,
  dynamic meanComputedRating,
  num? numberofcomputations,
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
  List<Followers>? followers,
  List<Following>? following,
}) => ToCounter(  id: id ?? _id,
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
  deviceToken: deviceToken ?? _deviceToken,
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
  String? get passportnumber => _passportnumber;
  String? get dateofissue => _dateofissue;
  String? get nationality => _nationality;
  String? get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get subreligion => _subreligion;
  String? get caste => _caste;
  String? get subsect => _subsect;
  String? get searchPagePositionPreferences => _searchPagePositionPreferences;
  String? get offeringAreaPreference => _offeringAreaPreference;
  String? get offerCategoryPreference => _offerCategoryPreference;
  String? get offerSegmentPreference => _offerSegmentPreference;
  String? get offerSubSegmentPreference => _offerSubSegmentPreference;
  String? get currentLocation => _currentLocation;
  bool? get wantToBuy => _wantToBuy;
  bool? get wantToSell => _wantToSell;
  bool? get optDelivery => _optDelivery;
  bool? get closeConfirmedOffers => _closeConfirmedOffers;
  bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
  String? get offerMatchPercentage => _offerMatchPercentage;
  dynamic get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
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
  List<Followers>? get followers => _followers;
  List<Following>? get following => _following;

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
    map['deviceToken'] = _deviceToken;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    if (_followers != null) {
      map['followers'] = _followers?.map((v) => v.toJson()).toList();
    }
    if (_following != null) {
      map['following'] = _following?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class Following {
  Following({
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
      dynamic deviceToken, 
      String? createdAt, 
      String? modified, 
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
    _deviceToken = deviceToken;
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
    _deviceToken = json['deviceToken'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
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
  dynamic _meanComputedRating;
  num? _numberofcomputations;
  num? _meanUserRating;
  num? _numberofusersRating;
  String? _blocked;
  dynamic _blockedtime;
  String? _subscriptionStatus;
  dynamic _paymentDone;
  dynamic _paymentDate;
  dynamic _deviceToken;
  String? _createdAt;
  String? _modified;
  List<num>? _followers;
  List<num>? _following;
Following copyWith({  num? id,
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
  dynamic meanComputedRating,
  num? numberofcomputations,
  num? meanUserRating,
  num? numberofusersRating,
  String? blocked,
  dynamic blockedtime,
  String? subscriptionStatus,
  dynamic paymentDone,
  dynamic paymentDate,
  dynamic deviceToken,
  String? createdAt,
  String? modified,
  List<num>? followers,
  List<num>? following,
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
  deviceToken: deviceToken ?? _deviceToken,
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
  dynamic get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
  num? get meanUserRating => _meanUserRating;
  num? get numberofusersRating => _numberofusersRating;
  String? get blocked => _blocked;
  dynamic get blockedtime => _blockedtime;
  String? get subscriptionStatus => _subscriptionStatus;
  dynamic get paymentDone => _paymentDone;
  dynamic get paymentDate => _paymentDate;
  dynamic get deviceToken => _deviceToken;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
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
    map['deviceToken'] = _deviceToken;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}



class Followers {
  Followers({
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
    dynamic meanComputedRating,
      num? numberofcomputations, 
      num? meanUserRating, 
      num? numberofusersRating, 
      String? blocked, 
      dynamic blockedtime, 
      String? subscriptionStatus, 
      dynamic paymentDone, 
      dynamic paymentDate, 
      dynamic deviceToken, 
      String? createdAt, 
      String? modified, 
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
    _deviceToken = deviceToken;
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
    _deviceToken = json['deviceToken'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
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
  dynamic _meanComputedRating;
  num? _numberofcomputations;
  num? _meanUserRating;
  num? _numberofusersRating;
  String? _blocked;
  dynamic _blockedtime;
  String? _subscriptionStatus;
  dynamic _paymentDone;
  dynamic _paymentDate;
  dynamic _deviceToken;
  String? _createdAt;
  String? _modified;
  List<num>? _followers;
  List<num>? _following;
Followers copyWith({  num? id,
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
  dynamic meanComputedRating,
  num? numberofcomputations,
  num? meanUserRating,
  num? numberofusersRating,
  String? blocked,
  dynamic blockedtime,
  String? subscriptionStatus,
  dynamic paymentDone,
  dynamic paymentDate,
  dynamic deviceToken,
  String? createdAt,
  String? modified,
  List<num>? followers,
  List<num>? following,
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
  deviceToken: deviceToken ?? _deviceToken,
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
  dynamic get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
  num? get meanUserRating => _meanUserRating;
  num? get numberofusersRating => _numberofusersRating;
  String? get blocked => _blocked;
  dynamic get blockedtime => _blockedtime;
  String? get subscriptionStatus => _subscriptionStatus;
  dynamic get paymentDone => _paymentDone;
  dynamic get paymentDate => _paymentDate;
  dynamic get deviceToken => _deviceToken;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
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
    map['deviceToken'] = _deviceToken;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}





class Offer {
  Offer({
      num? id, 
      OfferConditions? offerConditions, 
      List<OfferItems>? offerItems, 
      num? offerfavoritecount,
      List<dynamic>? offerviewcount,
      num? offercopycount, 
      num? offerresponses, 
      List<OfferBids>? offerBids, 
      List<CounterdUser>? counterdUser, 
      num? offerLike, 
      num? offerDisLike, 
      num? comments, 
      String? addres, 
      String? offerareas, 
      String? privacy, 
      String? tabactivity, 
      String? buyORsell, 
      bool? offerconfirmed, 
      bool? offerinform, 
      bool? offertemplate, 
      bool? offerevent, 
      dynamic offerexecutestart, 
      String? offerexecuteend, 
      bool? offersignedoff, 
      String? offerstatus, 
      String? offerservicepercentage,
    dynamic computedRating,
      String? userRating, 
      dynamic offerincepted, 
      String? createdAt, 
      String? modified, 
      String? slug, 
      Subscribers? subscribers, 
      Category? category, 
      Segment? segment, 
      Subsegment? subsegment,}){
    _id = id;
    _offerConditions = offerConditions;
    _offerItems = offerItems;
    _offerfavoritecount = offerfavoritecount;
    _offerviewcount = offerviewcount;
    _offercopycount = offercopycount;
    _offerresponses = offerresponses;
    _offerBids = offerBids;
    _counterdUser = counterdUser;
    _offerLike = offerLike;
    _offerDisLike = offerDisLike;
    _comments = comments;
    _addres = addres;
    _offerareas = offerareas;
    _privacy = privacy;
    _tabactivity = tabactivity;
    _buyORsell = buyORsell;
    _offerconfirmed = offerconfirmed;
    _offerinform = offerinform;
    _offertemplate = offertemplate;
    _offerevent = offerevent;
    _offerexecutestart = offerexecutestart;
    _offerexecuteend = offerexecuteend;
    _offersignedoff = offersignedoff;
    _offerstatus = offerstatus;
    _offerservicepercentage = offerservicepercentage;
    _computedRating = computedRating;
    _userRating = userRating;
    _offerincepted = offerincepted;
    _createdAt = createdAt;
    _modified = modified;
    _slug = slug;
    _subscribers = subscribers;
    _category = category;
    _segment = segment;
    _subsegment = subsegment;
}

  Offer.fromJson(dynamic json) {
    _id = json['id'];
    _offerConditions = json['offer_conditions'] != null ? OfferConditions.fromJson(json['offer_conditions']) : null;
    if (json['offer_items'] != null) {
      _offerItems = [];
      json['offer_items'].forEach((v) {
        _offerItems?.add(OfferItems.fromJson(v));
      });
    }
    _offerviewcount = json['offerviewcount'] != null ? json['offerviewcount'].cast<dynamic>() : [];
    _offerviewcount = json['offerviewcount'];
    _offercopycount = json['offercopycount'];
    _offerresponses = json['offerresponses'];
    if (json['offer_bids'] != null) {
      _offerBids = [];
      json['offer_bids'].forEach((v) {
        _offerBids?.add(OfferBids.fromJson(v));
      });
    }
    if (json['counterd_user'] != null) {
      _counterdUser = [];
      json['counterd_user'].forEach((v) {
        _counterdUser?.add(CounterdUser.fromJson(v));
      });
    }
    _offerLike = json['offerLike'];
    _offerDisLike = json['offerDisLike'];
    _comments = json['comments'];
    _addres = json['addres'];
    _offerareas = json['offerareas'];
    _privacy = json['privacy'];
    _tabactivity = json['tabactivity'];
    _buyORsell = json['buyORsell'];
    _offerconfirmed = json['offerconfirmed'];
    _offerinform = json['offerinform'];
    _offertemplate = json['offertemplate'];
    _offerevent = json['offerevent'];
    _offerexecutestart = json['offerexecutestart'];
    _offerexecuteend = json['offerexecuteend'];
    _offersignedoff = json['offersignedoff'];
    _offerstatus = json['offerstatus'];
    _offerservicepercentage = json['offerservicepercentage'];
    _computedRating = json['computed_rating'];
    _userRating = json['user_rating'];
    _offerincepted = json['offerincepted'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _slug = json['slug'];
    _subscribers = json['subscribers'] != null ? Subscribers.fromJson(json['subscribers']) : null;
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _segment = json['segment'] != null ? Segment.fromJson(json['segment']) : null;
    _subsegment = json['subsegment'] != null ? Subsegment.fromJson(json['subsegment']) : null;
  }
  num? _id;
  OfferConditions? _offerConditions;
  List<OfferItems>? _offerItems;
  num? _offerfavoritecount;
  List<dynamic>? _offerviewcount;
  num? _offercopycount;
  num? _offerresponses;
  List<OfferBids>? _offerBids;
  List<CounterdUser>? _counterdUser;
  num? _offerLike;
  num? _offerDisLike;
  num? _comments;
  String? _addres;
  String? _offerareas;
  String? _privacy;
  String? _tabactivity;
  String? _buyORsell;
  bool? _offerconfirmed;
  bool? _offerinform;
  bool? _offertemplate;
  bool? _offerevent;
  dynamic _offerexecutestart;
  String? _offerexecuteend;
  bool? _offersignedoff;
  String? _offerstatus;
  String? _offerservicepercentage;
  dynamic _computedRating;
  String? _userRating;
  dynamic _offerincepted;
  String? _createdAt;
  String? _modified;
  String? _slug;
  Subscribers? _subscribers;
  Category? _category;
  Segment? _segment;
  Subsegment? _subsegment;
Offer copyWith({  num? id,
  OfferConditions? offerConditions,
  List<OfferItems>? offerItems,
  num? offerfavoritecount,
  List<dynamic>? offerviewcount,
  num? offercopycount,
  num? offerresponses,
  List<OfferBids>? offerBids,
  List<CounterdUser>? counterdUser,
  num? offerLike,
  num? offerDisLike,
  num? comments,
  String? addres,
  String? offerareas,
  String? privacy,
  String? tabactivity,
  String? buyORsell,
  bool? offerconfirmed,
  bool? offerinform,
  bool? offertemplate,
  bool? offerevent,
  dynamic offerexecutestart,
  String? offerexecuteend,
  bool? offersignedoff,
  String? offerstatus,
  String? offerservicepercentage,
  dynamic computedRating,
  String? userRating,
  dynamic offerincepted,
  String? createdAt,
  String? modified,
  String? slug,
  Subscribers? subscribers,
  Category? category,
  Segment? segment,
  Subsegment? subsegment,
}) => Offer(  id: id ?? _id,
  offerConditions: offerConditions ?? _offerConditions,
  offerItems: offerItems ?? _offerItems,
  offerfavoritecount: offerfavoritecount ?? _offerfavoritecount,
  offerviewcount: offerviewcount ?? _offerviewcount,
  offercopycount: offercopycount ?? _offercopycount,
  offerresponses: offerresponses ?? _offerresponses,
  offerBids: offerBids ?? _offerBids,
  counterdUser: counterdUser ?? _counterdUser,
  offerLike: offerLike ?? _offerLike,
  offerDisLike: offerDisLike ?? _offerDisLike,
  comments: comments ?? _comments,
  addres: addres ?? _addres,
  offerareas: offerareas ?? _offerareas,
  privacy: privacy ?? _privacy,
  tabactivity: tabactivity ?? _tabactivity,
  buyORsell: buyORsell ?? _buyORsell,
  offerconfirmed: offerconfirmed ?? _offerconfirmed,
  offerinform: offerinform ?? _offerinform,
  offertemplate: offertemplate ?? _offertemplate,
  offerevent: offerevent ?? _offerevent,
  offerexecutestart: offerexecutestart ?? _offerexecutestart,
  offerexecuteend: offerexecuteend ?? _offerexecuteend,
  offersignedoff: offersignedoff ?? _offersignedoff,
  offerstatus: offerstatus ?? _offerstatus,
  offerservicepercentage: offerservicepercentage ?? _offerservicepercentage,
  computedRating: computedRating ?? _computedRating,
  userRating: userRating ?? _userRating,
  offerincepted: offerincepted ?? _offerincepted,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  slug: slug ?? _slug,
  subscribers: subscribers ?? _subscribers,
  category: category ?? _category,
  segment: segment ?? _segment,
  subsegment: subsegment ?? _subsegment,
);
  num? get id => _id;
  OfferConditions? get offerConditions => _offerConditions;
  List<OfferItems>? get offerItems => _offerItems;
  num? get offerfavoritecount => _offerfavoritecount;
  List<dynamic>? get offerviewcount => _offerviewcount;
  num? get offercopycount => _offercopycount;
  num? get offerresponses => _offerresponses;
  List<OfferBids>? get offerBids => _offerBids;
  List<CounterdUser>? get counterdUser => _counterdUser;
  num? get offerLike => _offerLike;
  num? get offerDisLike => _offerDisLike;
  num? get comments => _comments;
  String? get addres => _addres;
  String? get offerareas => _offerareas;
  String? get privacy => _privacy;
  String? get tabactivity => _tabactivity;
  String? get buyORsell => _buyORsell;
  bool? get offerconfirmed => _offerconfirmed;
  bool? get offerinform => _offerinform;
  bool? get offertemplate => _offertemplate;
  bool? get offerevent => _offerevent;
  dynamic get offerexecutestart => _offerexecutestart;
  String? get offerexecuteend => _offerexecuteend;
  bool? get offersignedoff => _offersignedoff;
  String? get offerstatus => _offerstatus;
  String? get offerservicepercentage => _offerservicepercentage;
  dynamic get computedRating => _computedRating;
  String? get userRating => _userRating;
  dynamic get offerincepted => _offerincepted;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  String? get slug => _slug;
  Subscribers? get subscribers => _subscribers;
  Category? get category => _category;
  Segment? get segment => _segment;
  Subsegment? get subsegment => _subsegment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_offerConditions != null) {
      map['offer_conditions'] = _offerConditions?.toJson();
    }
    if (_offerItems != null) {
      map['offer_items'] = _offerItems?.map((v) => v.toJson()).toList();
    }
    map['offerfavoritecount'] = _offerfavoritecount;
    map['offerviewcount'] = _offerviewcount;
    map['offercopycount'] = _offercopycount;
    map['offerresponses'] = _offerresponses;
    if (_offerBids != null) {
      map['offer_bids'] = _offerBids?.map((v) => v.toJson()).toList();
    }
    if (_counterdUser != null) {
      map['counterd_user'] = _counterdUser?.map((v) => v.toJson()).toList();
    }
    map['offerLike'] = _offerLike;
    map['offerDisLike'] = _offerDisLike;
    map['comments'] = _comments;
    map['addres'] = _addres;
    map['offerareas'] = _offerareas;
    map['privacy'] = _privacy;
    map['tabactivity'] = _tabactivity;
    map['buyORsell'] = _buyORsell;
    map['offerconfirmed'] = _offerconfirmed;
    map['offerinform'] = _offerinform;
    map['offertemplate'] = _offertemplate;
    map['offerevent'] = _offerevent;
    map['offerexecutestart'] = _offerexecutestart;
    map['offerexecuteend'] = _offerexecuteend;
    map['offersignedoff'] = _offersignedoff;
    map['offerstatus'] = _offerstatus;
    map['offerservicepercentage'] = _offerservicepercentage;
    map['computed_rating'] = _computedRating;
    map['user_rating'] = _userRating;
    map['offerincepted'] = _offerincepted;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['slug'] = _slug;
    if (_subscribers != null) {
      map['subscribers'] = _subscribers?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_segment != null) {
      map['segment'] = _segment?.toJson();
    }
    if (_subsegment != null) {
      map['subsegment'] = _subsegment?.toJson();
    }
    return map;
  }

}

/// id : 4
/// name : "new"
/// segment : 5

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

/// id : 5
/// name : "Grocery"
/// category : 1

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

/// id : 1
/// name : "Grocery"

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
      String? passportnumber, 
      String? dateofissue, 
      String? nationality, 
      String? dateofbirth, 
      String? gender, 
      String? religion, 
      String? subreligion, 
      String? caste, 
      String? subsect, 
      String? searchPagePositionPreferences, 
      String? offeringAreaPreference, 
      String? offerCategoryPreference, 
      String? offerSegmentPreference, 
      String? offerSubSegmentPreference, 
      String? currentLocation, 
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
      String? deviceToken, 
      String? createdAt, 
      String? modified, 
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
    _deviceToken = deviceToken;
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
    _deviceToken = json['deviceToken'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
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
  dynamic _classification;
  bool? _movable;
  String? _addressORarea;
  String? _operatingaddress;
  String? _maritalstatus;
  String? _passportnumber;
  String? _dateofissue;
  String? _nationality;
  String? _dateofbirth;
  String? _gender;
  String? _religion;
  String? _subreligion;
  String? _caste;
  String? _subsect;
  String? _searchPagePositionPreferences;
  String? _offeringAreaPreference;
  String? _offerCategoryPreference;
  String? _offerSegmentPreference;
  String? _offerSubSegmentPreference;
  String? _currentLocation;
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
  String? _deviceToken;
  String? _createdAt;
  String? _modified;
  List<num>? _followers;
  List<num>? _following;
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
  String? passportnumber,
  String? dateofissue,
  String? nationality,
  String? dateofbirth,
  String? gender,
  String? religion,
  String? subreligion,
  String? caste,
  String? subsect,
  String? searchPagePositionPreferences,
  String? offeringAreaPreference,
  String? offerCategoryPreference,
  String? offerSegmentPreference,
  String? offerSubSegmentPreference,
  String? currentLocation,
  bool? wantToBuy,
  bool? wantToSell,
  bool? optDelivery,
  bool? closeConfirmedOffers,
  bool? okForCurrentLocationOffers,
  String? offerMatchPercentage,
  dynamic meanComputedRating,
  num? numberofcomputations,
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
  List<num>? followers,
  List<num>? following,
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
  deviceToken: deviceToken ?? _deviceToken,
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
  String? get passportnumber => _passportnumber;
  String? get dateofissue => _dateofissue;
  String? get nationality => _nationality;
  String? get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get subreligion => _subreligion;
  String? get caste => _caste;
  String? get subsect => _subsect;
  String? get searchPagePositionPreferences => _searchPagePositionPreferences;
  String? get offeringAreaPreference => _offeringAreaPreference;
  String? get offerCategoryPreference => _offerCategoryPreference;
  String? get offerSegmentPreference => _offerSegmentPreference;
  String? get offerSubSegmentPreference => _offerSubSegmentPreference;
  String? get currentLocation => _currentLocation;
  bool? get wantToBuy => _wantToBuy;
  bool? get wantToSell => _wantToSell;
  bool? get optDelivery => _optDelivery;
  bool? get closeConfirmedOffers => _closeConfirmedOffers;
  bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
  String? get offerMatchPercentage => _offerMatchPercentage;
  dynamic get meanComputedRating => _meanComputedRating;
  num? get numberofcomputations => _numberofcomputations;
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
    map['deviceToken'] = _deviceToken;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}


class CounterdUser {
  CounterdUser({
      num? id, 
      String? name, 
      String? displayName, 
      String? image,}){
    _id = id;
    _name = name;
    _displayName = displayName;
    _image = image;
}

  CounterdUser.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _displayName = json['display_name'];
    _image = json['image'];
  }
  num? _id;
  String? _name;
  String? _displayName;
  String? _image;
CounterdUser copyWith({  num? id,
  String? name,
  String? displayName,
  String? image,
}) => CounterdUser(  id: id ?? _id,
  name: name ?? _name,
  displayName: displayName ?? _displayName,
  image: image ?? _image,
);
  num? get id => _id;
  String? get name => _name;
  String? get displayName => _displayName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['display_name'] = _displayName;
    map['image'] = _image;
    return map;
  }

}



class OfferBids {
  OfferBids({
      num? id, 
      String? comment, 
      String? createdAt, 
      String? modified, 
      FromCounter? fromCounter, 
      dynamic toCounter,}){
    _id = id;
    _comment = comment;
    _createdAt = createdAt;
    _modified = modified;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
}

  OfferBids.fromJson(dynamic json) {
    _id = json['id'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _fromCounter = json['from_counter'] != null ? FromCounter.fromJson(json['from_counter']) : null;
    _toCounter = json['to_counter'];
  }
  num? _id;
  String? _comment;
  String? _createdAt;
  String? _modified;
  FromCounter? _fromCounter;
  dynamic _toCounter;
OfferBids copyWith({  num? id,
  String? comment,
  String? createdAt,
  String? modified,
  FromCounter? fromCounter,
  dynamic toCounter,
}) => OfferBids(  id: id ?? _id,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
);
  num? get id => _id;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  FromCounter? get fromCounter => _fromCounter;
  dynamic get toCounter => _toCounter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    if (_fromCounter != null) {
      map['from_counter'] = _fromCounter?.toJson();
    }
    map['to_counter'] = _toCounter;
    return map;
  }

}



class OfferItems {
  OfferItems({
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
      bool? isExicuted,
      num? offer,
      num? counterOffer,
      num? user,
      String? createdAt,

  }){
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
    _isExicuted = isExicuted;
    _offer = offer;
    _counterOffer = counterOffer;
    _user = user;
    _createdAt = createdAt;
}

  OfferItems.fromJson(dynamic json) {
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
    _isExicuted = json['is_exicuted'];
    _offer = json['offer'];
    _counterOffer = json['counter_offer'];
    _user = json['user'];
    _createdAt = json['create_date'];

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
  bool? _isExicuted;

  num? _offer;
  num? _counterOffer;
  num? _user;
  String? _createdAt;
OfferItems copyWith({  num? id,
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
  bool? isExicuted,
  num? offer,
  num? counterOffer,
  num? user,
  String? createdAt,
}) => OfferItems(  id: id ?? _id,
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
  isExicuted: isExicuted ?? _isExicuted,
  offer: offer ?? _offer,
  counterOffer: counterOffer ?? _counterOffer,
  user: user ?? _user,
  createdAt: createdAt ?? _createdAt,
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
  bool? get isExicuted => _isExicuted;
  num? get offer => _offer;
  num? get counterOffer => _counterOffer;
  num? get user => _user;
  String? get createdAt => _createdAt;
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
    map['is_exicuted'] = _isExicuted;
    map['offer'] = _offer;
    map['counter_offer'] = _counterOffer;
    map['user'] = _user;
    map['create_date'] = _createdAt;
    return map;
  }

}


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
      dynamic tolocation, 
      dynamic atlocation, 
      String? priority, 
      String? expiry, 
      num? offerItem, 
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
    _offerItem = offerItem;
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
    _offerItem = json['offer_item'];
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
  dynamic _tolocation;
  dynamic _atlocation;
  String? _priority;
  String? _expiry;
  num? _offerItem;
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
  dynamic tolocation,
  dynamic atlocation,
  String? priority,
  String? expiry,
  num? offerItem,
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
  offerItem: offerItem ?? _offerItem,
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
  dynamic get tolocation => _tolocation;
  dynamic get atlocation => _atlocation;
  String? get priority => _priority;
  String? get expiry => _expiry;
  num? get offerItem => _offerItem;
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
    map['offer_item'] = _offerItem;
    map['servicepersons'] = _servicepersons;
    return map;
  }

}



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


class OfferConditions {
  OfferConditions({
      num? id, 
      List<Serviceperson>? serviceperson, 
      String? periodicity, 
      String? fromperiod, 
      String? toperiod, 
      String? duration, 
      String? fromperiodtime, 
      String? toperiodtime, 
      String? durationoftime, 
      String? fromlocation, 
      dynamic tolocation, 
      dynamic atlocation, 
      String? priority, 
      String? expiry, 
      num? offer, 
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
    _offer = offer;
    _servicepersons = servicepersons;
}

  OfferConditions.fromJson(dynamic json) {
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
    _offer = json['offer'];
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
  String? _durationoftime;
  String? _fromlocation;
  dynamic _tolocation;
  dynamic _atlocation;
  String? _priority;
  String? _expiry;
  num? _offer;
  List<num>? _servicepersons;
OfferConditions copyWith({  num? id,
  List<Serviceperson>? serviceperson,
  String? periodicity,
  String? fromperiod,
  String? toperiod,
  String? duration,
  String? fromperiodtime,
  String? toperiodtime,
  String? durationoftime,
  String? fromlocation,
  dynamic tolocation,
  dynamic atlocation,
  String? priority,
  String? expiry,
  num? offer,
  List<num>? servicepersons,
}) => OfferConditions(  id: id ?? _id,
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
  offer: offer ?? _offer,
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
  String? get durationoftime => _durationoftime;
  String? get fromlocation => _fromlocation;
  dynamic get tolocation => _tolocation;
  dynamic get atlocation => _atlocation;
  String? get priority => _priority;
  String? get expiry => _expiry;
  num? get offer => _offer;
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
    map['offer'] = _offer;
    map['servicepersons'] = _servicepersons;
    return map;
  }

}




