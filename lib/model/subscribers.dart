//
//
// class Subscribers {
//   Subscribers({
//       num? id,
//       String? displayname,
//       String? phonenumber,
//       String? username,
//       dynamic email,
//       String? profilePicture,
//       String? pagePicture,
//       dynamic desc,
//       String? placeORperson,
//       String? businessORpublic,
//       dynamic classification,
//       bool? movable,
//       String? addressORarea,
//       dynamic operatingaddress,
//       String? maritalstatus,
//       dynamic passportnumber,
//       dynamic dateofissue,
//       dynamic nationality,
//       dynamic dateofbirth,
//       String? gender,
//       dynamic religion,
//       dynamic subreligion,
//       dynamic caste,
//       dynamic subsect,
//       dynamic searchPagePreferences,
//       dynamic offeringAreaPreference,
//       dynamic offerCategoryPreference,
//       dynamic offerSegmentPreference,
//       dynamic offerSubSegmentPreference,
//       dynamic currentLocation,
//       bool? wantToBuy,
//       bool? wantToSell,
//       bool? optDelivery,
//       bool? notOfferingReminder,
//       bool? closeConfirmedOffers,
//       bool? okForCurrentLocationOffers,
//       String? offerMatchPercentage,
//       num? meanComputedRating,
//       num? numberofcomputations,
//       dynamic deafaultOfferDuration,
//       num? meanUserRating,
//       num? numberofusersRating,
//       String? blocked,
//       dynamic blockedtime,
//       String? subscriptionStatus,
//       dynamic paymentDone,
//       dynamic paymentDate,
//       String? deviceToken,
//       String? createdAt,
//       String? modified,
//       bool? isDeleted,
//       dynamic deleteDate,
//       List<num>? followers,
//       List<num>? following,}){
//     _id = id;
//     _displayname = displayname;
//     _phonenumber = phonenumber;
//     _username = username;
//     _email = email;
//     _profilePicture = profilePicture;
//     _pagePicture = pagePicture;
//     _desc = desc;
//     _placeORperson = placeORperson;
//     _businessORpublic = businessORpublic;
//     _classification = classification;
//     _movable = movable;
//     _addressORarea = addressORarea;
//     _operatingaddress = operatingaddress;
//     _maritalstatus = maritalstatus;
//     _passportnumber = passportnumber;
//     _dateofissue = dateofissue;
//     _nationality = nationality;
//     _dateofbirth = dateofbirth;
//     _gender = gender;
//     _religion = religion;
//     _subreligion = subreligion;
//     _caste = caste;
//     _subsect = subsect;
//     _searchPagePreferences = searchPagePreferences;
//     _offeringAreaPreference = offeringAreaPreference;
//     _offerCategoryPreference = offerCategoryPreference;
//     _offerSegmentPreference = offerSegmentPreference;
//     _offerSubSegmentPreference = offerSubSegmentPreference;
//     _currentLocation = currentLocation;
//     _wantToBuy = wantToBuy;
//     _wantToSell = wantToSell;
//     _optDelivery = optDelivery;
//     _notOfferingReminder = notOfferingReminder;
//     _closeConfirmedOffers = closeConfirmedOffers;
//     _okForCurrentLocationOffers = okForCurrentLocationOffers;
//     _offerMatchPercentage = offerMatchPercentage;
//     _meanComputedRating = meanComputedRating;
//     _numberofcomputations = numberofcomputations;
//     _deafaultOfferDuration = deafaultOfferDuration;
//     _meanUserRating = meanUserRating;
//     _numberofusersRating = numberofusersRating;
//     _blocked = blocked;
//     _blockedtime = blockedtime;
//     _subscriptionStatus = subscriptionStatus;
//     _paymentDone = paymentDone;
//     _paymentDate = paymentDate;
//     _deviceToken = deviceToken;
//     _createdAt = createdAt;
//     _modified = modified;
//     _isDeleted = isDeleted;
//     _deleteDate = deleteDate;
//     _followers = followers;
//     _following = following;
// }
//
//   Subscribers.fromJson(dynamic json) {
//     _id = json['id'];
//     _displayname = json['displayname'];
//     _phonenumber = json['phonenumber'];
//     _username = json['username'];
//     _email = json['email'];
//     _profilePicture = json['profile_picture'];
//     _pagePicture = json['page_picture'];
//     _desc = json['desc'];
//     _placeORperson = json['placeORperson'];
//     _businessORpublic = json['businessORpublic'];
//     _classification = json['classification'];
//     _movable = json['movable'];
//     _addressORarea = json['addressORarea'];
//     _operatingaddress = json['operatingaddress'];
//     _maritalstatus = json['maritalstatus'];
//     _passportnumber = json['passportnumber'];
//     _dateofissue = json['dateofissue'];
//     _nationality = json['nationality'];
//     _dateofbirth = json['dateofbirth'];
//     _gender = json['gender'];
//     _religion = json['religion'];
//     _subreligion = json['subreligion'];
//     _caste = json['caste'];
//     _subsect = json['subsect'];
//     _searchPagePreferences = json['search_page_preferences'];
//     _offeringAreaPreference = json['Offering_area_preference'];
//     _offerCategoryPreference = json['Offer_Category_preference'];
//     _offerSegmentPreference = json['Offer_Segment_preference'];
//     _offerSubSegmentPreference = json['Offer_Sub_Segment_preference'];
//     _currentLocation = json['Current_Location'];
//     _wantToBuy = json['Want_to_Buy'];
//     _wantToSell = json['Want_to_sell'];
//     _optDelivery = json['Opt_Delivery'];
//     _notOfferingReminder = json['not_offering_reminder'];
//     _closeConfirmedOffers = json['Close_Confirmed_Offers'];
//     _okForCurrentLocationOffers = json['Ok_for_Current_location_Offers'];
//     _offerMatchPercentage = json['Offer_match_percentage'];
//     _meanComputedRating = json['mean_computed_rating'];
//     _numberofcomputations = json['numberofcomputations'];
//     _deafaultOfferDuration = json['deafault_offer_duration'];
//     _meanUserRating = json['mean_user_rating'];
//     _numberofusersRating = json['numberofusers_rating'];
//     _blocked = json['blocked'];
//     _blockedtime = json['blockedtime'];
//     _subscriptionStatus = json['subscription_status'];
//     _paymentDone = json['payment_done'];
//     _paymentDate = json['payment_date'];
//     _deviceToken = json['deviceToken'];
//     _createdAt = json['created_at'];
//     _modified = json['modified'];
//     _isDeleted = json['is_deleted'];
//     _deleteDate = json['delete_date'];
//     _followers = json['followers'] != null ? json['followers'].cast<num>() : [];
//     _following = json['following'] != null ? json['following'].cast<num>() : [];
//   }
//   num? _id;
//   String? _displayname;
//   String? _phonenumber;
//   String? _username;
//   dynamic _email;
//   String? _profilePicture;
//   String? _pagePicture;
//   dynamic _desc;
//   String? _placeORperson;
//   String? _businessORpublic;
//   dynamic _classification;
//   bool? _movable;
//   String? _addressORarea;
//   dynamic _operatingaddress;
//   String? _maritalstatus;
//   dynamic _passportnumber;
//   dynamic _dateofissue;
//   dynamic _nationality;
//   dynamic _dateofbirth;
//   String? _gender;
//   dynamic _religion;
//   dynamic _subreligion;
//   dynamic _caste;
//   dynamic _subsect;
//   dynamic _searchPagePreferences;
//   dynamic _offeringAreaPreference;
//   dynamic _offerCategoryPreference;
//   dynamic _offerSegmentPreference;
//   dynamic _offerSubSegmentPreference;
//   dynamic _currentLocation;
//   bool? _wantToBuy;
//   bool? _wantToSell;
//   bool? _optDelivery;
//   bool? _notOfferingReminder;
//   bool? _closeConfirmedOffers;
//   bool? _okForCurrentLocationOffers;
//   String? _offerMatchPercentage;
//   num? _meanComputedRating;
//   num? _numberofcomputations;
//   dynamic _deafaultOfferDuration;
//   num? _meanUserRating;
//   num? _numberofusersRating;
//   String? _blocked;
//   dynamic _blockedtime;
//   String? _subscriptionStatus;
//   dynamic _paymentDone;
//   dynamic _paymentDate;
//   String? _deviceToken;
//   String? _createdAt;
//   String? _modified;
//   bool? _isDeleted;
//   dynamic _deleteDate;
//   List<num>? _followers;
//   List<num>? _following;
// Subscribers copyWith({  num? id,
//   String? displayname,
//   String? phonenumber,
//   String? username,
//   dynamic email,
//   String? profilePicture,
//   String? pagePicture,
//   dynamic desc,
//   String? placeORperson,
//   String? businessORpublic,
//   dynamic classification,
//   bool? movable,
//   String? addressORarea,
//   dynamic operatingaddress,
//   String? maritalstatus,
//   dynamic passportnumber,
//   dynamic dateofissue,
//   dynamic nationality,
//   dynamic dateofbirth,
//   String? gender,
//   dynamic religion,
//   dynamic subreligion,
//   dynamic caste,
//   dynamic subsect,
//   dynamic searchPagePreferences,
//   dynamic offeringAreaPreference,
//   dynamic offerCategoryPreference,
//   dynamic offerSegmentPreference,
//   dynamic offerSubSegmentPreference,
//   dynamic currentLocation,
//   bool? wantToBuy,
//   bool? wantToSell,
//   bool? optDelivery,
//   bool? notOfferingReminder,
//   bool? closeConfirmedOffers,
//   bool? okForCurrentLocationOffers,
//   String? offerMatchPercentage,
//   num? meanComputedRating,
//   num? numberofcomputations,
//   dynamic deafaultOfferDuration,
//   num? meanUserRating,
//   num? numberofusersRating,
//   String? blocked,
//   dynamic blockedtime,
//   String? subscriptionStatus,
//   dynamic paymentDone,
//   dynamic paymentDate,
//   String? deviceToken,
//   String? createdAt,
//   String? modified,
//   bool? isDeleted,
//   dynamic deleteDate,
//   List<num>? followers,
//   List<num>? following,
// }) => Subscribers(  id: id ?? _id,
//   displayname: displayname ?? _displayname,
//   phonenumber: phonenumber ?? _phonenumber,
//   username: username ?? _username,
//   email: email ?? _email,
//   profilePicture: profilePicture ?? _profilePicture,
//   pagePicture: pagePicture ?? _pagePicture,
//   desc: desc ?? _desc,
//   placeORperson: placeORperson ?? _placeORperson,
//   businessORpublic: businessORpublic ?? _businessORpublic,
//   classification: classification ?? _classification,
//   movable: movable ?? _movable,
//   addressORarea: addressORarea ?? _addressORarea,
//   operatingaddress: operatingaddress ?? _operatingaddress,
//   maritalstatus: maritalstatus ?? _maritalstatus,
//   passportnumber: passportnumber ?? _passportnumber,
//   dateofissue: dateofissue ?? _dateofissue,
//   nationality: nationality ?? _nationality,
//   dateofbirth: dateofbirth ?? _dateofbirth,
//   gender: gender ?? _gender,
//   religion: religion ?? _religion,
//   subreligion: subreligion ?? _subreligion,
//   caste: caste ?? _caste,
//   subsect: subsect ?? _subsect,
//   searchPagePreferences: searchPagePreferences ?? _searchPagePreferences,
//   offeringAreaPreference: offeringAreaPreference ?? _offeringAreaPreference,
//   offerCategoryPreference: offerCategoryPreference ?? _offerCategoryPreference,
//   offerSegmentPreference: offerSegmentPreference ?? _offerSegmentPreference,
//   offerSubSegmentPreference: offerSubSegmentPreference ?? _offerSubSegmentPreference,
//   currentLocation: currentLocation ?? _currentLocation,
//   wantToBuy: wantToBuy ?? _wantToBuy,
//   wantToSell: wantToSell ?? _wantToSell,
//   optDelivery: optDelivery ?? _optDelivery,
//   notOfferingReminder: notOfferingReminder ?? _notOfferingReminder,
//   closeConfirmedOffers: closeConfirmedOffers ?? _closeConfirmedOffers,
//   okForCurrentLocationOffers: okForCurrentLocationOffers ?? _okForCurrentLocationOffers,
//   offerMatchPercentage: offerMatchPercentage ?? _offerMatchPercentage,
//   meanComputedRating: meanComputedRating ?? _meanComputedRating,
//   numberofcomputations: numberofcomputations ?? _numberofcomputations,
//   deafaultOfferDuration: deafaultOfferDuration ?? _deafaultOfferDuration,
//   meanUserRating: meanUserRating ?? _meanUserRating,
//   numberofusersRating: numberofusersRating ?? _numberofusersRating,
//   blocked: blocked ?? _blocked,
//   blockedtime: blockedtime ?? _blockedtime,
//   subscriptionStatus: subscriptionStatus ?? _subscriptionStatus,
//   paymentDone: paymentDone ?? _paymentDone,
//   paymentDate: paymentDate ?? _paymentDate,
//   deviceToken: deviceToken ?? _deviceToken,
//   createdAt: createdAt ?? _createdAt,
//   modified: modified ?? _modified,
//   isDeleted: isDeleted ?? _isDeleted,
//   deleteDate: deleteDate ?? _deleteDate,
//   followers: followers ?? _followers,
//   following: following ?? _following,
// );
//   num? get id => _id;
//   String? get displayname => _displayname;
//   String? get phonenumber => _phonenumber;
//   String? get username => _username;
//   dynamic get email => _email;
//   String? get profilePicture => _profilePicture;
//   String? get pagePicture => _pagePicture;
//   dynamic get desc => _desc;
//   String? get placeORperson => _placeORperson;
//   String? get businessORpublic => _businessORpublic;
//   dynamic get classification => _classification;
//   bool? get movable => _movable;
//   String? get addressORarea => _addressORarea;
//   dynamic get operatingaddress => _operatingaddress;
//   String? get maritalstatus => _maritalstatus;
//   dynamic get passportnumber => _passportnumber;
//   dynamic get dateofissue => _dateofissue;
//   dynamic get nationality => _nationality;
//   dynamic get dateofbirth => _dateofbirth;
//   String? get gender => _gender;
//   dynamic get religion => _religion;
//   dynamic get subreligion => _subreligion;
//   dynamic get caste => _caste;
//   dynamic get subsect => _subsect;
//   dynamic get searchPagePreferences => _searchPagePreferences;
//   dynamic get offeringAreaPreference => _offeringAreaPreference;
//   dynamic get offerCategoryPreference => _offerCategoryPreference;
//   dynamic get offerSegmentPreference => _offerSegmentPreference;
//   dynamic get offerSubSegmentPreference => _offerSubSegmentPreference;
//   dynamic get currentLocation => _currentLocation;
//   bool? get wantToBuy => _wantToBuy;
//   bool? get wantToSell => _wantToSell;
//   bool? get optDelivery => _optDelivery;
//   bool? get notOfferingReminder => _notOfferingReminder;
//   bool? get closeConfirmedOffers => _closeConfirmedOffers;
//   bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
//   String? get offerMatchPercentage => _offerMatchPercentage;
//   num? get meanComputedRating => _meanComputedRating;
//   num? get numberofcomputations => _numberofcomputations;
//   dynamic get deafaultOfferDuration => _deafaultOfferDuration;
//   num? get meanUserRating => _meanUserRating;
//   num? get numberofusersRating => _numberofusersRating;
//   String? get blocked => _blocked;
//   dynamic get blockedtime => _blockedtime;
//   String? get subscriptionStatus => _subscriptionStatus;
//   dynamic get paymentDone => _paymentDone;
//   dynamic get paymentDate => _paymentDate;
//   String? get deviceToken => _deviceToken;
//   String? get createdAt => _createdAt;
//   String? get modified => _modified;
//   bool? get isDeleted => _isDeleted;
//   dynamic get deleteDate => _deleteDate;
//   List<num>? get followers => _followers;
//   List<num>? get following => _following;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['displayname'] = _displayname;
//     map['phonenumber'] = _phonenumber;
//     map['username'] = _username;
//     map['email'] = _email;
//     map['profile_picture'] = _profilePicture;
//     map['page_picture'] = _pagePicture;
//     map['desc'] = _desc;
//     map['placeORperson'] = _placeORperson;
//     map['businessORpublic'] = _businessORpublic;
//     map['classification'] = _classification;
//     map['movable'] = _movable;
//     map['addressORarea'] = _addressORarea;
//     map['operatingaddress'] = _operatingaddress;
//     map['maritalstatus'] = _maritalstatus;
//     map['passportnumber'] = _passportnumber;
//     map['dateofissue'] = _dateofissue;
//     map['nationality'] = _nationality;
//     map['dateofbirth'] = _dateofbirth;
//     map['gender'] = _gender;
//     map['religion'] = _religion;
//     map['subreligion'] = _subreligion;
//     map['caste'] = _caste;
//     map['subsect'] = _subsect;
//     map['search_page_preferences'] = _searchPagePreferences;
//     map['Offering_area_preference'] = _offeringAreaPreference;
//     map['Offer_Category_preference'] = _offerCategoryPreference;
//     map['Offer_Segment_preference'] = _offerSegmentPreference;
//     map['Offer_Sub_Segment_preference'] = _offerSubSegmentPreference;
//     map['Current_Location'] = _currentLocation;
//     map['Want_to_Buy'] = _wantToBuy;
//     map['Want_to_sell'] = _wantToSell;
//     map['Opt_Delivery'] = _optDelivery;
//     map['not_offering_reminder'] = _notOfferingReminder;
//     map['Close_Confirmed_Offers'] = _closeConfirmedOffers;
//     map['Ok_for_Current_location_Offers'] = _okForCurrentLocationOffers;
//     map['Offer_match_percentage'] = _offerMatchPercentage;
//     map['mean_computed_rating'] = _meanComputedRating;
//     map['numberofcomputations'] = _numberofcomputations;
//     map['deafault_offer_duration'] = _deafaultOfferDuration;
//     map['mean_user_rating'] = _meanUserRating;
//     map['numberofusers_rating'] = _numberofusersRating;
//     map['blocked'] = _blocked;
//     map['blockedtime'] = _blockedtime;
//     map['subscription_status'] = _subscriptionStatus;
//     map['payment_done'] = _paymentDone;
//     map['payment_date'] = _paymentDate;
//     map['deviceToken'] = _deviceToken;
//     map['created_at'] = _createdAt;
//     map['modified'] = _modified;
//     map['is_deleted'] = _isDeleted;
//     map['delete_date'] = _deleteDate;
//     map['followers'] = _followers;
//     map['following'] = _following;
//     return map;
//   }
//
// }