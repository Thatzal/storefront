

class FiltterOfferDetailsModel {
  FiltterOfferDetailsModel({
      num? id, 
      OfferConditions? offerConditions, 
      List<OfferItems>? offerItems, 
      num? offerfavoritecount, 
      List<num>? offerviewcount, 
      num? offercopycount, 
      num? offerresponses, 
      List<OfferBids>? offerBids, 
      List<CounterdUser>? counterdUser,
      num? offerLike, 
      num? offerDisLike, 
      num? comments, 
      List<dynamic>? confirmingsubscriber, 
      num? computedRating, 
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
      String? userRating, 
      dynamic offerincepted, 
      String? createdAt, 
      String? modified, 
      String? slug, 
      bool? hide, 
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
    _confirmingsubscriber = confirmingsubscriber;
    _computedRating = computedRating;
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
    _userRating = userRating;
    _offerincepted = offerincepted;
    _createdAt = createdAt;
    _modified = modified;
    _slug = slug;
    _hide = hide;
    _subscribers = subscribers;
    _category = category;
    _segment = segment;
    _subsegment = subsegment;
}

  FiltterOfferDetailsModel.fromJson(dynamic json) {
    _id = json['id'];
    _offerConditions = json['offer_conditions'] != null ? OfferConditions.fromJson(json['offer_conditions']) : null;
    if (json['offer_items'] != null) {
      _offerItems = [];
      json['offer_items'].forEach((v) {
        _offerItems?.add(OfferItems.fromJson(v));
      });
    }
    _offerfavoritecount = json['offerfavoritecount'];
    _offerviewcount = json['offerviewcount'] != null ? json['offerviewcount'].cast<num>() : [];
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
    if (json['confirmingsubscriber'] != null) {
      _confirmingsubscriber = [];
      json['confirmingsubscriber'].forEach((v) {
        _confirmingsubscriber?.add((v));
      });
    }
    _computedRating = json['computed_rating'];
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
    _userRating = json['user_rating'];
    _offerincepted = json['offerincepted'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _slug = json['slug'];
    _hide = json['hide'];
    _subscribers = json['subscribers'] != null ? Subscribers.fromJson(json['subscribers']) : null;
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _segment = json['segment'] != null ? Segment.fromJson(json['segment']) : null;
    _subsegment = json['subsegment'] != null ? Subsegment.fromJson(json['subsegment']) : null;
  }
  num? _id;
  OfferConditions? _offerConditions;
  List<OfferItems>? _offerItems;
  num? _offerfavoritecount;
  List<num>? _offerviewcount;
  num? _offercopycount;
  num? _offerresponses;
  List<OfferBids>? _offerBids;
  List<CounterdUser>? _counterdUser;
  num? _offerLike;
  num? _offerDisLike;
  num? _comments;
  List<dynamic>? _confirmingsubscriber;
  num? _computedRating;
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
  String? _userRating;
  dynamic _offerincepted;
  String? _createdAt;
  String? _modified;
  String? _slug;
  bool? _hide;
  Subscribers? _subscribers;
  Category? _category;
  Segment? _segment;
  Subsegment? _subsegment;
FiltterOfferDetailsModel copyWith({  num? id,
  OfferConditions? offerConditions,
  List<OfferItems>? offerItems,
  num? offerfavoritecount,
  List<num>? offerviewcount,
  num? offercopycount,
  num? offerresponses,
  List<OfferBids>? offerBids,
  List<CounterdUser>? counterdUser,
  num? offerLike,
  num? offerDisLike,
  num? comments,
  List<dynamic>? confirmingsubscriber,
  num? computedRating,
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
  String? userRating,
  dynamic offerincepted,
  String? createdAt,
  String? modified,
  String? slug,
  bool? hide,
  Subscribers? subscribers,
  Category? category,
  Segment? segment,
  Subsegment? subsegment,
}) => FiltterOfferDetailsModel(  id: id ?? _id,
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
  confirmingsubscriber: confirmingsubscriber ?? _confirmingsubscriber,
  computedRating: computedRating ?? _computedRating,
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
  userRating: userRating ?? _userRating,
  offerincepted: offerincepted ?? _offerincepted,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
  slug: slug ?? _slug,
  hide: hide ?? _hide,
  subscribers: subscribers ?? _subscribers,
  category: category ?? _category,
  segment: segment ?? _segment,
  subsegment: subsegment ?? _subsegment,
);
  num? get id => _id;
  OfferConditions? get offerConditions => _offerConditions;
  List<OfferItems>? get offerItems => _offerItems;
  num? get offerfavoritecount => _offerfavoritecount;
  List<num>? get offerviewcount => _offerviewcount;
  num? get offercopycount => _offercopycount;
  num? get offerresponses => _offerresponses;
  List<OfferBids>? get offerBids => _offerBids;
  List<CounterdUser>? get counterdUser => _counterdUser;
  num? get offerLike => _offerLike;
  num? get offerDisLike => _offerDisLike;
  num? get comments => _comments;
  List<dynamic>? get confirmingsubscriber => _confirmingsubscriber;
  num? get computedRating => _computedRating;
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
  String? get userRating => _userRating;
  dynamic get offerincepted => _offerincepted;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  String? get slug => _slug;
  bool? get hide => _hide;
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
    if (_confirmingsubscriber != null) {
      map['confirmingsubscriber'] = _confirmingsubscriber?.map((v) => v.toJson()).toList();
    }
    map['computed_rating'] = _computedRating;
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
    map['user_rating'] = _userRating;
    map['offerincepted'] = _offerincepted;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['slug'] = _slug;
    map['hide'] = _hide;
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

/// id : 2
/// name : "Toothpaste"
/// segment : 1

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

/// id : 1
/// name : "Cosmetics Dental"
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
      dynamic dateofissue, 
      String? nationality, 
      dynamic dateofbirth, 
      String? gender, 
      String? religion, 
      String? subreligion, 
      String? caste, 
      String? subsect, 
      String? homePagePreferences, 
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
      dynamic lat, 
      dynamic long, 
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
    _homePagePreferences = homePagePreferences;
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
    _lat = lat;
    _long = long;
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
    _homePagePreferences = json['home_page_preferences'];
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
    _lat = json['lat'];
    _long = json['long'];
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
  dynamic _dateofissue;
  String? _nationality;
  dynamic _dateofbirth;
  String? _gender;
  String? _religion;
  String? _subreligion;
  String? _caste;
  String? _subsect;
  String? _homePagePreferences;
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
  dynamic _lat;
  dynamic _long;
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
  dynamic dateofissue,
  String? nationality,
  dynamic dateofbirth,
  String? gender,
  String? religion,
  String? subreligion,
  String? caste,
  String? subsect,
  String? homePagePreferences,
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
  dynamic lat,
  dynamic long,
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
  homePagePreferences: homePagePreferences ?? _homePagePreferences,
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
  lat: lat ?? _lat,
  long: long ?? _long,
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
  dynamic get dateofissue => _dateofissue;
  String? get nationality => _nationality;
  dynamic get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get subreligion => _subreligion;
  String? get caste => _caste;
  String? get subsect => _subsect;
  String? get homePagePreferences => _homePagePreferences;
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
  dynamic get lat => _lat;
  dynamic get long => _long;
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
    map['home_page_preferences'] = _homePagePreferences;
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
    map['lat'] = _lat;
    map['long'] = _long;
    map['followers'] = _followers;
    map['following'] = _following;
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
      dynamic dateofissue, 
      String? nationality, 
      dynamic dateofbirth, 
      String? gender, 
      String? religion, 
      String? subreligion, 
      String? caste, 
      String? subsect, 
      String? homePagePreferences, 
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
      dynamic lat, 
      dynamic long, 
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
    _homePagePreferences = homePagePreferences;
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
    _lat = lat;
    _long = long;
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
    _homePagePreferences = json['home_page_preferences'];
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
    _lat = json['lat'];
    _long = json['long'];
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
  dynamic _dateofissue;
  String? _nationality;
  dynamic _dateofbirth;
  String? _gender;
  String? _religion;
  String? _subreligion;
  String? _caste;
  String? _subsect;
  String? _homePagePreferences;
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
  dynamic _lat;
  dynamic _long;
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
  dynamic dateofissue,
  String? nationality,
  dynamic dateofbirth,
  String? gender,
  String? religion,
  String? subreligion,
  String? caste,
  String? subsect,
  String? homePagePreferences,
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
  dynamic lat,
  dynamic long,
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
  homePagePreferences: homePagePreferences ?? _homePagePreferences,
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
  lat: lat ?? _lat,
  long: long ?? _long,
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
  dynamic get dateofissue => _dateofissue;
  String? get nationality => _nationality;
  dynamic get dateofbirth => _dateofbirth;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get subreligion => _subreligion;
  String? get caste => _caste;
  String? get subsect => _subsect;
  String? get homePagePreferences => _homePagePreferences;
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
  dynamic get lat => _lat;
  dynamic get long => _long;
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
    map['home_page_preferences'] = _homePagePreferences;
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
    map['lat'] = _lat;
    map['long'] = _long;
    map['followers'] = _followers;
    map['following'] = _following;
    return map;
  }

}

/// id : 94
/// offer_item_conditions : {"id":211,"serviceperson":[],"periodicity":"Daily","fromperiod":"16-09-2023","toperiod":"16-09-2023","duration":"4 Hours","fromperiodtime":"12:54:00","toperiodtime":"15:54:00","durationoftime":null,"fromlocation":"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore","tolocation":"4A, Naveen,Aziz nager 1st main road,Rangarajapuram,Kadambakkam,Chennai,India,600024","atlocation":null,"from_lat":null,"from_long":null,"to_lat":null,"to_long":null,"at_lat":null,"at_long":null,"priority":"NORMAL","expiry":"18-09-2023 00:54","offer_item":94,"servicepersons":[]}
/// item_media : [{"id":232,"media_type":"","media":"/media/offeritemsmedia/temp_s7O4tlT.jpg","offer_item":94}]
/// unit : {"id":1,"name":"Gram"}
/// advance_unit : {"id":null,"name":null}
/// maintenance_unit : {"id":null,"name":null}
/// name : "Test product"
/// desc : "test product"
/// quantity : 2
/// price : 100.0
/// advance_price : null
/// maintenance_price : null
/// currency : "INR"
/// addon : false
/// required : false
/// toggle_state : false
/// offer : 276

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
      num? offer,}){
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
    _offer = offer;
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
    _offer = json['offer'];
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
  num? _offer;
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
  num? offer,
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
  offer: offer ?? _offer,
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
  num? get offer => _offer;

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
    map['offer'] = _offer;
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

/// id : 1
/// name : "Gram"

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

/// id : 232
/// media_type : ""
/// media : "/media/offeritemsmedia/temp_s7O4tlT.jpg"
/// offer_item : 94

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

/// id : 211
/// serviceperson : []
/// periodicity : "Daily"
/// fromperiod : "16-09-2023"
/// toperiod : "16-09-2023"
/// duration : "4 Hours"
/// fromperiodtime : "12:54:00"
/// toperiodtime : "15:54:00"
/// durationoftime : null
/// fromlocation : "43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore"
/// tolocation : "4A, Naveen,Aziz nager 1st main road,Rangarajapuram,Kadambakkam,Chennai,India,600024"
/// atlocation : null
/// from_lat : null
/// from_long : null
/// to_lat : null
/// to_long : null
/// at_lat : null
/// at_long : null
/// priority : "NORMAL"
/// expiry : "18-09-2023 00:54"
/// offer_item : 94
/// servicepersons : []

class OfferItemConditions {
  OfferItemConditions({
      num? id, 
      List<dynamic>? serviceperson, 
      String? periodicity, 
      String? fromperiod, 
      String? toperiod, 
      String? duration, 
      String? fromperiodtime, 
      String? toperiodtime, 
      dynamic durationoftime, 
      String? fromlocation, 
      String? tolocation, 
      dynamic atlocation, 
      dynamic fromLat, 
      dynamic fromLong, 
      dynamic toLat, 
      dynamic toLong, 
      dynamic atLat, 
      dynamic atLong, 
      String? priority, 
      String? expiry, 
      num? offerItem, 
      List<dynamic>? servicepersons,}){
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
    _fromLat = fromLat;
    _fromLong = fromLong;
    _toLat = toLat;
    _toLong = toLong;
    _atLat = atLat;
    _atLong = atLong;
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
        _serviceperson?.add((v));
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
    _fromLat = json['from_lat'];
    _fromLong = json['from_long'];
    _toLat = json['to_lat'];
    _toLong = json['to_long'];
    _atLat = json['at_lat'];
    _atLong = json['at_long'];
    _priority = json['priority'];
    _expiry = json['expiry'];
    _offerItem = json['offer_item'];
    if (json['servicepersons'] != null) {
      _servicepersons = [];
      json['servicepersons'].forEach((v) {
        _servicepersons?.add((v));
      });
    }
  }
  num? _id;
  List<dynamic>? _serviceperson;
  String? _periodicity;
  String? _fromperiod;
  String? _toperiod;
  String? _duration;
  String? _fromperiodtime;
  String? _toperiodtime;
  dynamic _durationoftime;
  String? _fromlocation;
  String? _tolocation;
  dynamic _atlocation;
  dynamic _fromLat;
  dynamic _fromLong;
  dynamic _toLat;
  dynamic _toLong;
  dynamic _atLat;
  dynamic _atLong;
  String? _priority;
  String? _expiry;
  num? _offerItem;
  List<dynamic>? _servicepersons;
OfferItemConditions copyWith({  num? id,
  List<dynamic>? serviceperson,
  String? periodicity,
  String? fromperiod,
  String? toperiod,
  String? duration,
  String? fromperiodtime,
  String? toperiodtime,
  dynamic durationoftime,
  String? fromlocation,
  String? tolocation,
  dynamic atlocation,
  dynamic fromLat,
  dynamic fromLong,
  dynamic toLat,
  dynamic toLong,
  dynamic atLat,
  dynamic atLong,
  String? priority,
  String? expiry,
  num? offerItem,
  List<dynamic>? servicepersons,
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
  fromLat: fromLat ?? _fromLat,
  fromLong: fromLong ?? _fromLong,
  toLat: toLat ?? _toLat,
  toLong: toLong ?? _toLong,
  atLat: atLat ?? _atLat,
  atLong: atLong ?? _atLong,
  priority: priority ?? _priority,
  expiry: expiry ?? _expiry,
  offerItem: offerItem ?? _offerItem,
  servicepersons: servicepersons ?? _servicepersons,
);
  num? get id => _id;
  List<dynamic>? get serviceperson => _serviceperson;
  String? get periodicity => _periodicity;
  String? get fromperiod => _fromperiod;
  String? get toperiod => _toperiod;
  String? get duration => _duration;
  String? get fromperiodtime => _fromperiodtime;
  String? get toperiodtime => _toperiodtime;
  dynamic get durationoftime => _durationoftime;
  String? get fromlocation => _fromlocation;
  String? get tolocation => _tolocation;
  dynamic get atlocation => _atlocation;
  dynamic get fromLat => _fromLat;
  dynamic get fromLong => _fromLong;
  dynamic get toLat => _toLat;
  dynamic get toLong => _toLong;
  dynamic get atLat => _atLat;
  dynamic get atLong => _atLong;
  String? get priority => _priority;
  String? get expiry => _expiry;
  num? get offerItem => _offerItem;
  List<dynamic>? get servicepersons => _servicepersons;

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
    map['from_lat'] = _fromLat;
    map['from_long'] = _fromLong;
    map['to_lat'] = _toLat;
    map['to_long'] = _toLong;
    map['at_lat'] = _atLat;
    map['at_long'] = _atLong;
    map['priority'] = _priority;
    map['expiry'] = _expiry;
    map['offer_item'] = _offerItem;
    if (_servicepersons != null) {
      map['servicepersons'] = _servicepersons?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 257
/// serviceperson : []
/// periodicity : "Today"
/// fromperiod : null
/// toperiod : null
/// duration : "00:00:00:00:04"
/// fromperiodtime : "15:19:00"
/// toperiodtime : "15:22:00"
/// durationoftime : ""
/// fromlocation : ""
/// from_lat : null
/// from_long : null
/// tolocation : "4A, Naveen, Aziz nager 1st main road Rangarajapuram Kadambakkam,Chennai,India,600024"
/// to_lat : null
/// to_long : null
/// atlocation : ""
/// at_lat : null
/// at_long : null
/// priority : "URGENT"
/// expiry : "15-09-2023 15:37"
/// offer : 276
/// servicepersons : []

class OfferConditions {
  OfferConditions({
      num? id, 
      List<dynamic>? serviceperson, 
      String? periodicity, 
      dynamic fromperiod, 
      dynamic toperiod, 
      String? duration, 
      String? fromperiodtime, 
      String? toperiodtime, 
      String? durationoftime, 
      String? fromlocation, 
      dynamic fromLat, 
      dynamic fromLong, 
      String? tolocation, 
      dynamic toLat, 
      dynamic toLong, 
      String? atlocation, 
      dynamic atLat, 
      dynamic atLong, 
      String? priority, 
      String? expiry, 
      num? offer, 
      List<dynamic>? servicepersons,}){
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
    _fromLat = fromLat;
    _fromLong = fromLong;
    _tolocation = tolocation;
    _toLat = toLat;
    _toLong = toLong;
    _atlocation = atlocation;
    _atLat = atLat;
    _atLong = atLong;
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
        _serviceperson?.add((v));
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
    _fromLat = json['from_lat'];
    _fromLong = json['from_long'];
    _tolocation = json['tolocation'];
    _toLat = json['to_lat'];
    _toLong = json['to_long'];
    _atlocation = json['atlocation'];
    _atLat = json['at_lat'];
    _atLong = json['at_long'];
    _priority = json['priority'];
    _expiry = json['expiry'];
    _offer = json['offer'];
    if (json['servicepersons'] != null) {
      _servicepersons = [];
      json['servicepersons'].forEach((v) {
        _servicepersons?.add((v));
      });
    }
  }
  num? _id;
  List<dynamic>? _serviceperson;
  String? _periodicity;
  dynamic _fromperiod;
  dynamic _toperiod;
  String? _duration;
  String? _fromperiodtime;
  String? _toperiodtime;
  String? _durationoftime;
  String? _fromlocation;
  dynamic _fromLat;
  dynamic _fromLong;
  String? _tolocation;
  dynamic _toLat;
  dynamic _toLong;
  String? _atlocation;
  dynamic _atLat;
  dynamic _atLong;
  String? _priority;
  String? _expiry;
  num? _offer;
  List<dynamic>? _servicepersons;
OfferConditions copyWith({  num? id,
  List<dynamic>? serviceperson,
  String? periodicity,
  dynamic fromperiod,
  dynamic toperiod,
  String? duration,
  String? fromperiodtime,
  String? toperiodtime,
  String? durationoftime,
  String? fromlocation,
  dynamic fromLat,
  dynamic fromLong,
  String? tolocation,
  dynamic toLat,
  dynamic toLong,
  String? atlocation,
  dynamic atLat,
  dynamic atLong,
  String? priority,
  String? expiry,
  num? offer,
  List<dynamic>? servicepersons,
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
  fromLat: fromLat ?? _fromLat,
  fromLong: fromLong ?? _fromLong,
  tolocation: tolocation ?? _tolocation,
  toLat: toLat ?? _toLat,
  toLong: toLong ?? _toLong,
  atlocation: atlocation ?? _atlocation,
  atLat: atLat ?? _atLat,
  atLong: atLong ?? _atLong,
  priority: priority ?? _priority,
  expiry: expiry ?? _expiry,
  offer: offer ?? _offer,
  servicepersons: servicepersons ?? _servicepersons,
);
  num? get id => _id;
  List<dynamic>? get serviceperson => _serviceperson;
  String? get periodicity => _periodicity;
  dynamic get fromperiod => _fromperiod;
  dynamic get toperiod => _toperiod;
  String? get duration => _duration;
  String? get fromperiodtime => _fromperiodtime;
  String? get toperiodtime => _toperiodtime;
  String? get durationoftime => _durationoftime;
  String? get fromlocation => _fromlocation;
  dynamic get fromLat => _fromLat;
  dynamic get fromLong => _fromLong;
  String? get tolocation => _tolocation;
  dynamic get toLat => _toLat;
  dynamic get toLong => _toLong;
  String? get atlocation => _atlocation;
  dynamic get atLat => _atLat;
  dynamic get atLong => _atLong;
  String? get priority => _priority;
  String? get expiry => _expiry;
  num? get offer => _offer;
  List<dynamic>? get servicepersons => _servicepersons;

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
    map['from_lat'] = _fromLat;
    map['from_long'] = _fromLong;
    map['tolocation'] = _tolocation;
    map['to_lat'] = _toLat;
    map['to_long'] = _toLong;
    map['atlocation'] = _atlocation;
    map['at_lat'] = _atLat;
    map['at_long'] = _atLong;
    map['priority'] = _priority;
    map['expiry'] = _expiry;
    map['offer'] = _offer;
    if (_servicepersons != null) {
      map['servicepersons'] = _servicepersons?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}