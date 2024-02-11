/// id : 28
/// comment : "call between 10 AM and 6PM contact no 9755745669"
/// created_at : "20-07-2023 17:25"
/// from_counter : {"id":4,"displayname":"kishore Patidar","phonenumber":"9988776655","username":"kishore Patidar","email":"kishorepatidar@gmail.com","profile_picture":"/media/profile/IMG20230621185401.jpg","page_picture":"/media/page/yellow-chrysanthemum_n7ykcjd.jpg","desc":"hello world","placeORperson":"place","businessORpublic":"public","classification":"","movable":false,"addressORarea":"address","operatingaddress":"indore","maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"15-05-2023 11:34","modified":"21-07-2023 13:00","followers":null,"following":null}
/// to_counter : null
/// offer : {"id":115,"addres":"Home, khajarana khajarana indore,mp,india,452001","offerareas":"[{\"Address\":\"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore\"}]","privacy":"PUBLIC","tabactivity":"NEW","buyORsell":"BUY","offerconfirmed":false,"offerinform":false,"offertemplate":false,"offerevent":false,"offerexecutestart":null,"offerexecuteend":null,"offersignedoff":false,"offerviewcount":0,"offerfavoritecount":0,"offerstatus":"LIVE","offerresponses":3,"offerservicepercentage":"0.00","offercopycount":0,"computed_rating":"0.00","user_rating":"0.00","offerincepted":null,"created_at":"20-07-2023 17:25","modified":"20-07-2023 19:43","slug":"electronics mobiles 5g kishore patidar address43 khajrana main rd pipal chowk khajrana main rd indore","subscribers":4,"category":3,"segment":3,"subsegment":3,"confirmingsubscriber":null,"offerfavouritingsubscriber":null,"offercopyingsubscriber":null,"offerLike":null}

class MainOfferBidesModel {
  MainOfferBidesModel({
      num? id, 
      String? comment, 
      String? createdAt, 
      FromCounter? fromCounter, 
      dynamic toCounter, 
      Offer? offer,}){
    _id = id;
    _comment = comment;
    _createdAt = createdAt;
    _fromCounter = fromCounter;
    _toCounter = toCounter;
    _offer = offer;
}

  MainOfferBidesModel.fromJson(dynamic json) {
    _id = json['id'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _fromCounter = json['from_counter'] != null ? FromCounter.fromJson(json['from_counter']) : null;
    _toCounter = json['to_counter'];
    _offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
  }
  num? _id;
  String? _comment;
  String? _createdAt;
  FromCounter? _fromCounter;
  dynamic _toCounter;
  Offer? _offer;
MainOfferBidesModel copyWith({  num? id,
  String? comment,
  String? createdAt,
  FromCounter? fromCounter,
  dynamic toCounter,
  Offer? offer,
}) => MainOfferBidesModel(  id: id ?? _id,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  fromCounter: fromCounter ?? _fromCounter,
  toCounter: toCounter ?? _toCounter,
  offer: offer ?? _offer,
);
  num? get id => _id;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  FromCounter? get fromCounter => _fromCounter;
  dynamic get toCounter => _toCounter;
  Offer? get offer => _offer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    if (_fromCounter != null) {
      map['from_counter'] = _fromCounter?.toJson();
    }
    map['to_counter'] = _toCounter;
    if (_offer != null) {
      map['offer'] = _offer?.toJson();
    }
    return map;
  }

}

/// id : 115
/// addres : "Home, khajarana khajarana indore,mp,india,452001"
/// offerareas : "[{\"Address\":\"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore\"}]"
/// privacy : "PUBLIC"
/// tabactivity : "NEW"
/// buyORsell : "BUY"
/// offerconfirmed : false
/// offerinform : false
/// offertemplate : false
/// offerevent : false
/// offerexecutestart : null
/// offerexecuteend : null
/// offersignedoff : false
/// offerviewcount : 0
/// offerfavoritecount : 0
/// offerstatus : "LIVE"
/// offerresponses : 3
/// offerservicepercentage : "0.00"
/// offercopycount : 0
/// computed_rating : "0.00"
/// user_rating : "0.00"
/// offerincepted : null
/// created_at : "20-07-2023 17:25"
/// modified : "20-07-2023 19:43"
/// slug : "electronics mobiles 5g kishore patidar address43 khajrana main rd pipal chowk khajrana main rd indore"
/// subscribers : 4
/// category : 3
/// segment : 3
/// subsegment : 3
/// confirmingsubscriber : null
/// offerfavouritingsubscriber : null
/// offercopyingsubscriber : null
/// offerLike : null

class Offer {
  Offer({
      num? id, 
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
      dynamic offerexecuteend, 
      bool? offersignedoff, 
      num? offerviewcount, 
      num? offerfavoritecount, 
      String? offerstatus, 
      num? offerresponses, 
      String? offerservicepercentage, 
      num? offercopycount, 
      String? computedRating, 
      String? userRating, 
      dynamic offerincepted, 
      String? createdAt, 
      String? modified, 
      String? slug, 
      num? subscribers, 
      num? category, 
      num? segment, 
      num? subsegment, 
      dynamic confirmingsubscriber, 
      dynamic offerfavouritingsubscriber, 
      dynamic offercopyingsubscriber, 
      dynamic offerLike,}){
    _id = id;
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
    _offerviewcount = offerviewcount;
    _offerfavoritecount = offerfavoritecount;
    _offerstatus = offerstatus;
    _offerresponses = offerresponses;
    _offerservicepercentage = offerservicepercentage;
    _offercopycount = offercopycount;
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
    _confirmingsubscriber = confirmingsubscriber;
    _offerfavouritingsubscriber = offerfavouritingsubscriber;
    _offercopyingsubscriber = offercopyingsubscriber;
    _offerLike = offerLike;
}

  Offer.fromJson(dynamic json) {
    _id = json['id'];
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
    _offerviewcount = json['offerviewcount'];
    _offerfavoritecount = json['offerfavoritecount'];
    _offerstatus = json['offerstatus'];
    _offerresponses = json['offerresponses'];
    _offerservicepercentage = json['offerservicepercentage'];
    _offercopycount = json['offercopycount'];
    _computedRating = json['computed_rating'];
    _userRating = json['user_rating'];
    _offerincepted = json['offerincepted'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
    _slug = json['slug'];
    _subscribers = json['subscribers'];
    _category = json['category'];
    _segment = json['segment'];
    _subsegment = json['subsegment'];
    _confirmingsubscriber = json['confirmingsubscriber'];
    _offerfavouritingsubscriber = json['offerfavouritingsubscriber'];
    _offercopyingsubscriber = json['offercopyingsubscriber'];
    _offerLike = json['offerLike'];
  }
  num? _id;
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
  dynamic _offerexecuteend;
  bool? _offersignedoff;
  num? _offerviewcount;
  num? _offerfavoritecount;
  String? _offerstatus;
  num? _offerresponses;
  String? _offerservicepercentage;
  num? _offercopycount;
  String? _computedRating;
  String? _userRating;
  dynamic _offerincepted;
  String? _createdAt;
  String? _modified;
  String? _slug;
  num? _subscribers;
  num? _category;
  num? _segment;
  num? _subsegment;
  dynamic _confirmingsubscriber;
  dynamic _offerfavouritingsubscriber;
  dynamic _offercopyingsubscriber;
  dynamic _offerLike;
Offer copyWith({  num? id,
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
  dynamic offerexecuteend,
  bool? offersignedoff,
  num? offerviewcount,
  num? offerfavoritecount,
  String? offerstatus,
  num? offerresponses,
  String? offerservicepercentage,
  num? offercopycount,
  String? computedRating,
  String? userRating,
  dynamic offerincepted,
  String? createdAt,
  String? modified,
  String? slug,
  num? subscribers,
  num? category,
  num? segment,
  num? subsegment,
  dynamic confirmingsubscriber,
  dynamic offerfavouritingsubscriber,
  dynamic offercopyingsubscriber,
  dynamic offerLike,
}) => Offer(  id: id ?? _id,
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
  offerviewcount: offerviewcount ?? _offerviewcount,
  offerfavoritecount: offerfavoritecount ?? _offerfavoritecount,
  offerstatus: offerstatus ?? _offerstatus,
  offerresponses: offerresponses ?? _offerresponses,
  offerservicepercentage: offerservicepercentage ?? _offerservicepercentage,
  offercopycount: offercopycount ?? _offercopycount,
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
  confirmingsubscriber: confirmingsubscriber ?? _confirmingsubscriber,
  offerfavouritingsubscriber: offerfavouritingsubscriber ?? _offerfavouritingsubscriber,
  offercopyingsubscriber: offercopyingsubscriber ?? _offercopyingsubscriber,
  offerLike: offerLike ?? _offerLike,
);
  num? get id => _id;
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
  dynamic get offerexecuteend => _offerexecuteend;
  bool? get offersignedoff => _offersignedoff;
  num? get offerviewcount => _offerviewcount;
  num? get offerfavoritecount => _offerfavoritecount;
  String? get offerstatus => _offerstatus;
  num? get offerresponses => _offerresponses;
  String? get offerservicepercentage => _offerservicepercentage;
  num? get offercopycount => _offercopycount;
  String? get computedRating => _computedRating;
  String? get userRating => _userRating;
  dynamic get offerincepted => _offerincepted;
  String? get createdAt => _createdAt;
  String? get modified => _modified;
  String? get slug => _slug;
  num? get subscribers => _subscribers;
  num? get category => _category;
  num? get segment => _segment;
  num? get subsegment => _subsegment;
  dynamic get confirmingsubscriber => _confirmingsubscriber;
  dynamic get offerfavouritingsubscriber => _offerfavouritingsubscriber;
  dynamic get offercopyingsubscriber => _offercopyingsubscriber;
  dynamic get offerLike => _offerLike;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
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
    map['offerviewcount'] = _offerviewcount;
    map['offerfavoritecount'] = _offerfavoritecount;
    map['offerstatus'] = _offerstatus;
    map['offerresponses'] = _offerresponses;
    map['offerservicepercentage'] = _offerservicepercentage;
    map['offercopycount'] = _offercopycount;
    map['computed_rating'] = _computedRating;
    map['user_rating'] = _userRating;
    map['offerincepted'] = _offerincepted;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    map['slug'] = _slug;
    map['subscribers'] = _subscribers;
    map['category'] = _category;
    map['segment'] = _segment;
    map['subsegment'] = _subsegment;
    map['confirmingsubscriber'] = _confirmingsubscriber;
    map['offerfavouritingsubscriber'] = _offerfavouritingsubscriber;
    map['offercopyingsubscriber'] = _offercopyingsubscriber;
    map['offerLike'] = _offerLike;
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