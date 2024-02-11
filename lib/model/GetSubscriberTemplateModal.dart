// /// status : 200
// /// message : "Subscriber Template List"
// /// result : [{"id":3,"offer_conditions":{"id":3,"periodicity":"Daily","fromperiod":null,"toperiod":null,"duration":"","fromperiodtime":"17:25:00","toperiodtime":"17:25:00","durationoftime":"","fromlocation":"Ujjain","tolocation":"dewas","atlocation":"","priority":"NORMAL","expiry":"15-05-2023 13:00","offer":3,"servicepersons":1},"offer_items":[{"id":3,"item_media":[{"id":3,"media_type":"","media":"/media/offeritemsmedia/temp_8SRy3kn.png","offer_item":3}],"name":"item 1","desc":"demo offer","quantity":2,"unit":"3","price":100.0,"currency":"INR","addon":false,"required":false,"toggle_state":false,"offer":3}],"addres":"testing store new","offerareas":"test1, test2","privacy":"PUBLIC","tabactivity":"NEW","buyORsell":"SELL","offerconfirmed":false,"offerinform":false,"offertemplate":true,"offerevent":false,"offerexecutestart":"08-05-2023 17:25","offerexecuteend":"08-05-2023 17:25","offersignedoff":false,"offerviewcount":0,"offerfavoritecount":0,"offerstatus":"LIVE","offerresponses":0,"offerservicepercentage":"0.00","offercopycount":0,"computed_rating":"0.00","user_rating":"0.00","offerincepted":null,"created_at":"16-05-2023 13:25","modified":"17-05-2023 12:09","subscribers":{"id":4,"displayname":"kishore Patidar","phonenumber":"9988776655","username":"kishore Patidar","email":"kishorepatidar@gmail.com","profile_picture":"/media/profile/man_0HADR2A.png","page_picture":"/media/page/yellow-chrysanthemum_n7ykcjd.jpg","desc":"hello world","placeORperson":"place","businessORpublic":"public","classification":null,"movable":false,"addressORarea":"address","operatingaddress":null,"maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"15-05-2023 11:34","modified":"17-05-2023 11:23","followers":[5,6,8],"following":[5,6,8]},"category":{"id":1,"name":"Grocery"},"segment":{"id":2,"name":"Cosmetics","category":1},"subsegment":{"id":1,"name":"Toothbrush","segment":1}}]
//
// class GetSubscriberTemplateModal {
//   GetSubscriberTemplateModal({
//       num? status,
//       String? message,
//       List<GetTemplateOfferResult>? result,}){
//     _status = status;
//     _message = message;
//     _result = result;
// }
//
//   GetSubscriberTemplateModal.fromJson(dynamic json) {
//     _status = json['status'];
//     _message = json['message'];
//     if (json['result'] != null) {
//       _result = [];
//       json['result'].forEach((v) {
//         _result?.add(GetTemplateOfferResult.fromJson(v));
//       });
//     }
//   }
//   num? _status;
//   String? _message;
//   List<GetTemplateOfferResult>? _result;
// GetSubscriberTemplateModal copyWith({  num? status,
//   String? message,
//   List<GetTemplateOfferResult>? result,
// }) => GetSubscriberTemplateModal(  status: status ?? _status,
//   message: message ?? _message,
//   result: result ?? _result,
// );
//   num? get status => _status;
//   String? get message => _message;
//   List<GetTemplateOfferResult>? get result => _result;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['message'] = _message;
//     if (_result != null) {
//       map['result'] = _result?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// id : 3
// /// offer_conditions : {"id":3,"periodicity":"Daily","fromperiod":null,"toperiod":null,"duration":"","fromperiodtime":"17:25:00","toperiodtime":"17:25:00","durationoftime":"","fromlocation":"Ujjain","tolocation":"dewas","atlocation":"","priority":"NORMAL","expiry":"15-05-2023 13:00","offer":3,"servicepersons":1}
// /// offer_items : [{"id":3,"item_media":[{"id":3,"media_type":"","media":"/media/offeritemsmedia/temp_8SRy3kn.png","offer_item":3}],"name":"item 1","desc":"demo offer","quantity":2,"unit":"3","price":100.0,"currency":"INR","addon":false,"required":false,"toggle_state":false,"offer":3}]
// /// addres : "testing store new"
// /// offerareas : "test1, test2"
// /// privacy : "PUBLIC"
// /// tabactivity : "NEW"
// /// buyORsell : "SELL"
// /// offerconfirmed : false
// /// offerinform : false
// /// offertemplate : true
// /// offerevent : false
// /// offerexecutestart : "08-05-2023 17:25"
// /// offerexecuteend : "08-05-2023 17:25"
// /// offersignedoff : false
// /// offerviewcount : 0
// /// offerfavoritecount : 0
// /// offerstatus : "LIVE"
// /// offerresponses : 0
// /// offerservicepercentage : "0.00"
// /// offercopycount : 0
// /// computed_rating : "0.00"
// /// user_rating : "0.00"
// /// offerincepted : null
// /// created_at : "16-05-2023 13:25"
// /// modified : "17-05-2023 12:09"
// /// subscribers : {"id":4,"displayname":"kishore Patidar","phonenumber":"9988776655","username":"kishore Patidar","email":"kishorepatidar@gmail.com","profile_picture":"/media/profile/man_0HADR2A.png","page_picture":"/media/page/yellow-chrysanthemum_n7ykcjd.jpg","desc":"hello world","placeORperson":"place","businessORpublic":"public","classification":null,"movable":false,"addressORarea":"address","operatingaddress":null,"maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"15-05-2023 11:34","modified":"17-05-2023 11:23","followers":[5,6,8],"following":[5,6,8]}
// /// category : {"id":1,"name":"Grocery"}
// /// segment : {"id":2,"name":"Cosmetics","category":1}
// /// subsegment : {"id":1,"name":"Toothbrush","segment":1}
//
// class GetTemplateOfferResult {
//   GetTemplateOfferResult({
//       num? id,
//       OfferConditions? offerConditions,
//       List<OfferItems>? offerItems,
//       String? addres,
//       String? offerareas,
//       String? privacy,
//       String? tabactivity,
//       String? buyORsell,
//       bool? offerconfirmed,
//       bool? offerinform,
//       bool? offertemplate,
//       bool? offerevent,
//       String? offerexecutestart,
//       String? offerexecuteend,
//       bool? offersignedoff,
//       num? offerviewcount,
//       num? offerfavoritecount,
//       String? offerstatus,
//       num? offerresponses,
//       String? offerservicepercentage,
//       num? offercopycount,
//       String? computedRating,
//       String? userRating,
//       dynamic offerincepted,
//       String? createdAt,
//       String? modified,
//       Subscribers? subscribers,
//       Category? category,
//       Segment? segment,
//       Subsegment? subsegment,}){
//     _id = id;
//     _offerConditions = offerConditions;
//     _offerItems = offerItems;
//     _addres = addres;
//     _offerareas = offerareas;
//     _privacy = privacy;
//     _tabactivity = tabactivity;
//     _buyORsell = buyORsell;
//     _offerconfirmed = offerconfirmed;
//     _offerinform = offerinform;
//     _offertemplate = offertemplate;
//     _offerevent = offerevent;
//     _offerexecutestart = offerexecutestart;
//     _offerexecuteend = offerexecuteend;
//     _offersignedoff = offersignedoff;
//     _offerviewcount = offerviewcount;
//     _offerfavoritecount = offerfavoritecount;
//     _offerstatus = offerstatus;
//     _offerresponses = offerresponses;
//     _offerservicepercentage = offerservicepercentage;
//     _offercopycount = offercopycount;
//     _computedRating = computedRating;
//     _userRating = userRating;
//     _offerincepted = offerincepted;
//     _createdAt = createdAt;
//     _modified = modified;
//     _subscribers = subscribers;
//     _category = category;
//     _segment = segment;
//     _subsegment = subsegment;
// }
//
//   GetTemplateOfferResult.fromJson(dynamic json) {
//     _id = json['id'];
//     _offerConditions = json['offer_conditions'] != null ? OfferConditions.fromJson(json['offer_conditions']) : null;
//     if (json['offer_items'] != null) {
//       _offerItems = [];
//       json['offer_items'].forEach((v) {
//         _offerItems?.add(OfferItems.fromJson(v));
//       });
//     }
//     _addres = json['addres'];
//     _offerareas = json['offerareas'];
//     _privacy = json['privacy'];
//     _tabactivity = json['tabactivity'];
//     _buyORsell = json['buyORsell'];
//     _offerconfirmed = json['offerconfirmed'];
//     _offerinform = json['offerinform'];
//     _offertemplate = json['offertemplate'];
//     _offerevent = json['offerevent'];
//     _offerexecutestart = json['offerexecutestart'];
//     _offerexecuteend = json['offerexecuteend'];
//     _offersignedoff = json['offersignedoff'];
//     _offerviewcount = json['offerviewcount'];
//     _offerfavoritecount = json['offerfavoritecount'];
//     _offerstatus = json['offerstatus'];
//     _offerresponses = json['offerresponses'];
//     _offerservicepercentage = json['offerservicepercentage'];
//     _offercopycount = json['offercopycount'];
//     _computedRating = json['computed_rating'];
//     _userRating = json['user_rating'];
//     _offerincepted = json['offerincepted'];
//     _createdAt = json['created_at'];
//     _modified = json['modified'];
//     _subscribers = json['subscribers'] != null ? Subscribers.fromJson(json['subscribers']) : null;
//     _category = json['category'] != null ? Category.fromJson(json['category']) : null;
//     _segment = json['segment'] != null ? Segment.fromJson(json['segment']) : null;
//     _subsegment = json['subsegment'] != null ? Subsegment.fromJson(json['subsegment']) : null;
//   }
//   num? _id;
//   OfferConditions? _offerConditions;
//   List<OfferItems>? _offerItems;
//   String? _addres;
//   String? _offerareas;
//   String? _privacy;
//   String? _tabactivity;
//   String? _buyORsell;
//   bool? _offerconfirmed;
//   bool? _offerinform;
//   bool? _offertemplate;
//   bool? _offerevent;
//   String? _offerexecutestart;
//   String? _offerexecuteend;
//   bool? _offersignedoff;
//   num? _offerviewcount;
//   num? _offerfavoritecount;
//   String? _offerstatus;
//   num? _offerresponses;
//   String? _offerservicepercentage;
//   num? _offercopycount;
//   String? _computedRating;
//   String? _userRating;
//   dynamic _offerincepted;
//   String? _createdAt;
//   String? _modified;
//   Subscribers? _subscribers;
//   Category? _category;
//   Segment? _segment;
//   Subsegment? _subsegment;
// GetTemplateOfferResult copyWith({  num? id,
//   OfferConditions? offerConditions,
//   List<OfferItems>? offerItems,
//   String? addres,
//   String? offerareas,
//   String? privacy,
//   String? tabactivity,
//   String? buyORsell,
//   bool? offerconfirmed,
//   bool? offerinform,
//   bool? offertemplate,
//   bool? offerevent,
//   String? offerexecutestart,
//   String? offerexecuteend,
//   bool? offersignedoff,
//   num? offerviewcount,
//   num? offerfavoritecount,
//   String? offerstatus,
//   num? offerresponses,
//   String? offerservicepercentage,
//   num? offercopycount,
//   String? computedRating,
//   String? userRating,
//   dynamic offerincepted,
//   String? createdAt,
//   String? modified,
//   Subscribers? subscribers,
//   Category? category,
//   Segment? segment,
//   Subsegment? subsegment,
// }) => GetTemplateOfferResult(  id: id ?? _id,
//   offerConditions: offerConditions ?? _offerConditions,
//   offerItems: offerItems ?? _offerItems,
//   addres: addres ?? _addres,
//   offerareas: offerareas ?? _offerareas,
//   privacy: privacy ?? _privacy,
//   tabactivity: tabactivity ?? _tabactivity,
//   buyORsell: buyORsell ?? _buyORsell,
//   offerconfirmed: offerconfirmed ?? _offerconfirmed,
//   offerinform: offerinform ?? _offerinform,
//   offertemplate: offertemplate ?? _offertemplate,
//   offerevent: offerevent ?? _offerevent,
//   offerexecutestart: offerexecutestart ?? _offerexecutestart,
//   offerexecuteend: offerexecuteend ?? _offerexecuteend,
//   offersignedoff: offersignedoff ?? _offersignedoff,
//   offerviewcount: offerviewcount ?? _offerviewcount,
//   offerfavoritecount: offerfavoritecount ?? _offerfavoritecount,
//   offerstatus: offerstatus ?? _offerstatus,
//   offerresponses: offerresponses ?? _offerresponses,
//   offerservicepercentage: offerservicepercentage ?? _offerservicepercentage,
//   offercopycount: offercopycount ?? _offercopycount,
//   computedRating: computedRating ?? _computedRating,
//   userRating: userRating ?? _userRating,
//   offerincepted: offerincepted ?? _offerincepted,
//   createdAt: createdAt ?? _createdAt,
//   modified: modified ?? _modified,
//   subscribers: subscribers ?? _subscribers,
//   category: category ?? _category,
//   segment: segment ?? _segment,
//   subsegment: subsegment ?? _subsegment,
// );
//   num? get id => _id;
//   OfferConditions? get offerConditions => _offerConditions;
//   List<OfferItems>? get offerItems => _offerItems;
//   String? get addres => _addres;
//   String? get offerareas => _offerareas;
//   String? get privacy => _privacy;
//   String? get tabactivity => _tabactivity;
//   String? get buyORsell => _buyORsell;
//   bool? get offerconfirmed => _offerconfirmed;
//   bool? get offerinform => _offerinform;
//   bool? get offertemplate => _offertemplate;
//   bool? get offerevent => _offerevent;
//   String? get offerexecutestart => _offerexecutestart;
//   String? get offerexecuteend => _offerexecuteend;
//   bool? get offersignedoff => _offersignedoff;
//   num? get offerviewcount => _offerviewcount;
//   num? get offerfavoritecount => _offerfavoritecount;
//   String? get offerstatus => _offerstatus;
//   num? get offerresponses => _offerresponses;
//   String? get offerservicepercentage => _offerservicepercentage;
//   num? get offercopycount => _offercopycount;
//   String? get computedRating => _computedRating;
//   String? get userRating => _userRating;
//   dynamic get offerincepted => _offerincepted;
//   String? get createdAt => _createdAt;
//   String? get modified => _modified;
//   Subscribers? get subscribers => _subscribers;
//   Category? get category => _category;
//   Segment? get segment => _segment;
//   Subsegment? get subsegment => _subsegment;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     if (_offerConditions != null) {
//       map['offer_conditions'] = _offerConditions?.toJson();
//     }
//     if (_offerItems != null) {
//       map['offer_items'] = _offerItems?.map((v) => v.toJson()).toList();
//     }
//     map['addres'] = _addres;
//     map['offerareas'] = _offerareas;
//     map['privacy'] = _privacy;
//     map['tabactivity'] = _tabactivity;
//     map['buyORsell'] = _buyORsell;
//     map['offerconfirmed'] = _offerconfirmed;
//     map['offerinform'] = _offerinform;
//     map['offertemplate'] = _offertemplate;
//     map['offerevent'] = _offerevent;
//     map['offerexecutestart'] = _offerexecutestart;
//     map['offerexecuteend'] = _offerexecuteend;
//     map['offersignedoff'] = _offersignedoff;
//     map['offerviewcount'] = _offerviewcount;
//     map['offerfavoritecount'] = _offerfavoritecount;
//     map['offerstatus'] = _offerstatus;
//     map['offerresponses'] = _offerresponses;
//     map['offerservicepercentage'] = _offerservicepercentage;
//     map['offercopycount'] = _offercopycount;
//     map['computed_rating'] = _computedRating;
//     map['user_rating'] = _userRating;
//     map['offerincepted'] = _offerincepted;
//     map['created_at'] = _createdAt;
//     map['modified'] = _modified;
//     if (_subscribers != null) {
//       map['subscribers'] = _subscribers?.toJson();
//     }
//     if (_category != null) {
//       map['category'] = _category?.toJson();
//     }
//     if (_segment != null) {
//       map['segment'] = _segment?.toJson();
//     }
//     if (_subsegment != null) {
//       map['subsegment'] = _subsegment?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// id : 1
// /// name : "Toothbrush"
// /// segment : 1
//
// class Subsegment {
//   Subsegment({
//       num? id,
//       String? name,
//       num? segment,}){
//     _id = id;
//     _name = name;
//     _segment = segment;
// }
//
//   Subsegment.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _segment = json['segment'];
//   }
//   num? _id;
//   String? _name;
//   num? _segment;
// Subsegment copyWith({  num? id,
//   String? name,
//   num? segment,
// }) => Subsegment(  id: id ?? _id,
//   name: name ?? _name,
//   segment: segment ?? _segment,
// );
//   num? get id => _id;
//   String? get name => _name;
//   num? get segment => _segment;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['segment'] = _segment;
//     return map;
//   }
//
// }
//
// /// id : 2
// /// name : "Cosmetics"
// /// category : 1
//
// class Segment {
//   Segment({
//       num? id,
//       String? name,
//       num? category,}){
//     _id = id;
//     _name = name;
//     _category = category;
// }
//
//   Segment.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _category = json['category'];
//   }
//   num? _id;
//   String? _name;
//   num? _category;
// Segment copyWith({  num? id,
//   String? name,
//   num? category,
// }) => Segment(  id: id ?? _id,
//   name: name ?? _name,
//   category: category ?? _category,
// );
//   num? get id => _id;
//   String? get name => _name;
//   num? get category => _category;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['category'] = _category;
//     return map;
//   }
//
// }
//
// /// id : 1
// /// name : "Grocery"
//
// class Category {
//   Category({
//       num? id,
//       String? name,}){
//     _id = id;
//     _name = name;
// }
//
//   Category.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//   }
//   num? _id;
//   String? _name;
// Category copyWith({  num? id,
//   String? name,
// }) => Category(  id: id ?? _id,
//   name: name ?? _name,
// );
//   num? get id => _id;
//   String? get name => _name;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     return map;
//   }
//
// }
//
// /// id : 4
// /// displayname : "kishore Patidar"
// /// phonenumber : "9988776655"
// /// username : "kishore Patidar"
// /// email : "kishorepatidar@gmail.com"
// /// profile_picture : "/media/profile/man_0HADR2A.png"
// /// page_picture : "/media/page/yellow-chrysanthemum_n7ykcjd.jpg"
// /// desc : "hello world"
// /// placeORperson : "place"
// /// businessORpublic : "public"
// /// classification : null
// /// movable : false
// /// addressORarea : "address"
// /// operatingaddress : null
// /// maritalstatus : "single"
// /// passportnumber : null
// /// dateofissue : null
// /// nationality : null
// /// dateofbirth : null
// /// gender : "M"
// /// religion : null
// /// subreligion : null
// /// caste : null
// /// subsect : null
// /// search_page_position_preferences : "TRENDING OFFERS"
// /// Offering_area_preference : null
// /// Offer_Category_preference : null
// /// Offer_Segment_preference : null
// /// Offer_Sub_Segment_preference : null
// /// Current_Location : null
// /// Want_to_Buy : false
// /// Want_to_sell : false
// /// Opt_Delivery : false
// /// Close_Confirmed_Offers : false
// /// Ok_for_Current_location_Offers : false
// /// Offer_match_percentage : "0.00"
// /// mean_computed_rating : 0
// /// numberofcomputations : 0
// /// mean_user_rating : 0
// /// numberofusers_rating : 0
// /// blocked : "NO"
// /// blockedtime : null
// /// subscription_status : "FREE"
// /// payment_done : null
// /// payment_date : null
// /// created_at : "15-05-2023 11:34"
// /// modified : "17-05-2023 11:23"
// /// followers : [5,6,8]
// /// following : [5,6,8]
//
// class Subscribers {
//   Subscribers({
//       num? id,
//       String? displayname,
//       String? phonenumber,
//       String? username,
//       String? email,
//       String? profilePicture,
//       String? pagePicture,
//       String? desc,
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
//       String? searchPagePositionPreferences,
//       dynamic offeringAreaPreference,
//       dynamic offerCategoryPreference,
//       dynamic offerSegmentPreference,
//       dynamic offerSubSegmentPreference,
//       dynamic currentLocation,
//       bool? wantToBuy,
//       bool? wantToSell,
//       bool? optDelivery,
//       bool? closeConfirmedOffers,
//       bool? okForCurrentLocationOffers,
//       String? offerMatchPercentage,
//       num? meanComputedRating,
//       num? numberofcomputations,
//       num? meanUserRating,
//       num? numberofusersRating,
//       String? blocked,
//       dynamic blockedtime,
//       String? subscriptionStatus,
//       dynamic paymentDone,
//       dynamic paymentDate,
//       String? createdAt,
//       String? modified,
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
//     _searchPagePositionPreferences = searchPagePositionPreferences;
//     _offeringAreaPreference = offeringAreaPreference;
//     _offerCategoryPreference = offerCategoryPreference;
//     _offerSegmentPreference = offerSegmentPreference;
//     _offerSubSegmentPreference = offerSubSegmentPreference;
//     _currentLocation = currentLocation;
//     _wantToBuy = wantToBuy;
//     _wantToSell = wantToSell;
//     _optDelivery = optDelivery;
//     _closeConfirmedOffers = closeConfirmedOffers;
//     _okForCurrentLocationOffers = okForCurrentLocationOffers;
//     _offerMatchPercentage = offerMatchPercentage;
//     _meanComputedRating = meanComputedRating;
//     _numberofcomputations = numberofcomputations;
//     _meanUserRating = meanUserRating;
//     _numberofusersRating = numberofusersRating;
//     _blocked = blocked;
//     _blockedtime = blockedtime;
//     _subscriptionStatus = subscriptionStatus;
//     _paymentDone = paymentDone;
//     _paymentDate = paymentDate;
//     _createdAt = createdAt;
//     _modified = modified;
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
//     _searchPagePositionPreferences = json['search_page_position_preferences'];
//     _offeringAreaPreference = json['Offering_area_preference'];
//     _offerCategoryPreference = json['Offer_Category_preference'];
//     _offerSegmentPreference = json['Offer_Segment_preference'];
//     _offerSubSegmentPreference = json['Offer_Sub_Segment_preference'];
//     _currentLocation = json['Current_Location'];
//     _wantToBuy = json['Want_to_Buy'];
//     _wantToSell = json['Want_to_sell'];
//     _optDelivery = json['Opt_Delivery'];
//     _closeConfirmedOffers = json['Close_Confirmed_Offers'];
//     _okForCurrentLocationOffers = json['Ok_for_Current_location_Offers'];
//     _offerMatchPercentage = json['Offer_match_percentage'];
//     _meanComputedRating = json['mean_computed_rating'];
//     _numberofcomputations = json['numberofcomputations'];
//     _meanUserRating = json['mean_user_rating'];
//     _numberofusersRating = json['numberofusers_rating'];
//     _blocked = json['blocked'];
//     _blockedtime = json['blockedtime'];
//     _subscriptionStatus = json['subscription_status'];
//     _paymentDone = json['payment_done'];
//     _paymentDate = json['payment_date'];
//     _createdAt = json['created_at'];
//     _modified = json['modified'];
//     _followers = json['followers'] != null ? json['followers'].cast<num>() : [];
//     _following = json['following'] != null ? json['following'].cast<num>() : [];
//   }
//   num? _id;
//   String? _displayname;
//   String? _phonenumber;
//   String? _username;
//   String? _email;
//   String? _profilePicture;
//   String? _pagePicture;
//   String? _desc;
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
//   String? _searchPagePositionPreferences;
//   dynamic _offeringAreaPreference;
//   dynamic _offerCategoryPreference;
//   dynamic _offerSegmentPreference;
//   dynamic _offerSubSegmentPreference;
//   dynamic _currentLocation;
//   bool? _wantToBuy;
//   bool? _wantToSell;
//   bool? _optDelivery;
//   bool? _closeConfirmedOffers;
//   bool? _okForCurrentLocationOffers;
//   String? _offerMatchPercentage;
//   num? _meanComputedRating;
//   num? _numberofcomputations;
//   num? _meanUserRating;
//   num? _numberofusersRating;
//   String? _blocked;
//   dynamic _blockedtime;
//   String? _subscriptionStatus;
//   dynamic _paymentDone;
//   dynamic _paymentDate;
//   String? _createdAt;
//   String? _modified;
//   List<num>? _followers;
//   List<num>? _following;
// Subscribers copyWith({  num? id,
//   String? displayname,
//   String? phonenumber,
//   String? username,
//   String? email,
//   String? profilePicture,
//   String? pagePicture,
//   String? desc,
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
//   String? searchPagePositionPreferences,
//   dynamic offeringAreaPreference,
//   dynamic offerCategoryPreference,
//   dynamic offerSegmentPreference,
//   dynamic offerSubSegmentPreference,
//   dynamic currentLocation,
//   bool? wantToBuy,
//   bool? wantToSell,
//   bool? optDelivery,
//   bool? closeConfirmedOffers,
//   bool? okForCurrentLocationOffers,
//   String? offerMatchPercentage,
//   num? meanComputedRating,
//   num? numberofcomputations,
//   num? meanUserRating,
//   num? numberofusersRating,
//   String? blocked,
//   dynamic blockedtime,
//   String? subscriptionStatus,
//   dynamic paymentDone,
//   dynamic paymentDate,
//   String? createdAt,
//   String? modified,
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
//   searchPagePositionPreferences: searchPagePositionPreferences ?? _searchPagePositionPreferences,
//   offeringAreaPreference: offeringAreaPreference ?? _offeringAreaPreference,
//   offerCategoryPreference: offerCategoryPreference ?? _offerCategoryPreference,
//   offerSegmentPreference: offerSegmentPreference ?? _offerSegmentPreference,
//   offerSubSegmentPreference: offerSubSegmentPreference ?? _offerSubSegmentPreference,
//   currentLocation: currentLocation ?? _currentLocation,
//   wantToBuy: wantToBuy ?? _wantToBuy,
//   wantToSell: wantToSell ?? _wantToSell,
//   optDelivery: optDelivery ?? _optDelivery,
//   closeConfirmedOffers: closeConfirmedOffers ?? _closeConfirmedOffers,
//   okForCurrentLocationOffers: okForCurrentLocationOffers ?? _okForCurrentLocationOffers,
//   offerMatchPercentage: offerMatchPercentage ?? _offerMatchPercentage,
//   meanComputedRating: meanComputedRating ?? _meanComputedRating,
//   numberofcomputations: numberofcomputations ?? _numberofcomputations,
//   meanUserRating: meanUserRating ?? _meanUserRating,
//   numberofusersRating: numberofusersRating ?? _numberofusersRating,
//   blocked: blocked ?? _blocked,
//   blockedtime: blockedtime ?? _blockedtime,
//   subscriptionStatus: subscriptionStatus ?? _subscriptionStatus,
//   paymentDone: paymentDone ?? _paymentDone,
//   paymentDate: paymentDate ?? _paymentDate,
//   createdAt: createdAt ?? _createdAt,
//   modified: modified ?? _modified,
//   followers: followers ?? _followers,
//   following: following ?? _following,
// );
//   num? get id => _id;
//   String? get displayname => _displayname;
//   String? get phonenumber => _phonenumber;
//   String? get username => _username;
//   String? get email => _email;
//   String? get profilePicture => _profilePicture;
//   String? get pagePicture => _pagePicture;
//   String? get desc => _desc;
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
//   String? get searchPagePositionPreferences => _searchPagePositionPreferences;
//   dynamic get offeringAreaPreference => _offeringAreaPreference;
//   dynamic get offerCategoryPreference => _offerCategoryPreference;
//   dynamic get offerSegmentPreference => _offerSegmentPreference;
//   dynamic get offerSubSegmentPreference => _offerSubSegmentPreference;
//   dynamic get currentLocation => _currentLocation;
//   bool? get wantToBuy => _wantToBuy;
//   bool? get wantToSell => _wantToSell;
//   bool? get optDelivery => _optDelivery;
//   bool? get closeConfirmedOffers => _closeConfirmedOffers;
//   bool? get okForCurrentLocationOffers => _okForCurrentLocationOffers;
//   String? get offerMatchPercentage => _offerMatchPercentage;
//   num? get meanComputedRating => _meanComputedRating;
//   num? get numberofcomputations => _numberofcomputations;
//   num? get meanUserRating => _meanUserRating;
//   num? get numberofusersRating => _numberofusersRating;
//   String? get blocked => _blocked;
//   dynamic get blockedtime => _blockedtime;
//   String? get subscriptionStatus => _subscriptionStatus;
//   dynamic get paymentDone => _paymentDone;
//   dynamic get paymentDate => _paymentDate;
//   String? get createdAt => _createdAt;
//   String? get modified => _modified;
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
//     map['search_page_position_preferences'] = _searchPagePositionPreferences;
//     map['Offering_area_preference'] = _offeringAreaPreference;
//     map['Offer_Category_preference'] = _offerCategoryPreference;
//     map['Offer_Segment_preference'] = _offerSegmentPreference;
//     map['Offer_Sub_Segment_preference'] = _offerSubSegmentPreference;
//     map['Current_Location'] = _currentLocation;
//     map['Want_to_Buy'] = _wantToBuy;
//     map['Want_to_sell'] = _wantToSell;
//     map['Opt_Delivery'] = _optDelivery;
//     map['Close_Confirmed_Offers'] = _closeConfirmedOffers;
//     map['Ok_for_Current_location_Offers'] = _okForCurrentLocationOffers;
//     map['Offer_match_percentage'] = _offerMatchPercentage;
//     map['mean_computed_rating'] = _meanComputedRating;
//     map['numberofcomputations'] = _numberofcomputations;
//     map['mean_user_rating'] = _meanUserRating;
//     map['numberofusers_rating'] = _numberofusersRating;
//     map['blocked'] = _blocked;
//     map['blockedtime'] = _blockedtime;
//     map['subscription_status'] = _subscriptionStatus;
//     map['payment_done'] = _paymentDone;
//     map['payment_date'] = _paymentDate;
//     map['created_at'] = _createdAt;
//     map['modified'] = _modified;
//     map['followers'] = _followers;
//     map['following'] = _following;
//     return map;
//   }
//
// }
//
// /// id : 3
// /// item_media : [{"id":3,"media_type":"","media":"/media/offeritemsmedia/temp_8SRy3kn.png","offer_item":3}]
// /// name : "item 1"
// /// desc : "demo offer"
// /// quantity : 2
// /// unit : "3"
// /// price : 100.0
// /// currency : "INR"
// /// addon : false
// /// required : false
// /// toggle_state : false
// /// offer : 3
//
// class OfferItems {
//   OfferItems({
//       num? id,
//       List<ItemMedia>? itemMedia,
//       String? name,
//       String? desc,
//       num? quantity,
//       String? unit,
//       num? price,
//       String? currency,
//       bool? addon,
//       bool? required,
//       bool? toggleState,
//       num? offer,}){
//     _id = id;
//     _itemMedia = itemMedia;
//     _name = name;
//     _desc = desc;
//     _quantity = quantity;
//     _unit = unit;
//     _price = price;
//     _currency = currency;
//     _addon = addon;
//     _required = required;
//     _toggleState = toggleState;
//     _offer = offer;
// }
//
//   OfferItems.fromJson(dynamic json) {
//     _id = json['id'];
//     if (json['item_media'] != null) {
//       _itemMedia = [];
//       json['item_media'].forEach((v) {
//         _itemMedia?.add(ItemMedia.fromJson(v));
//       });
//     }
//     _name = json['name'];
//     _desc = json['desc'];
//     _quantity = json['quantity'];
//     _unit = json['unit'];
//     _price = json['price'];
//     _currency = json['currency'];
//     _addon = json['addon'];
//     _required = json['required'];
//     _toggleState = json['toggle_state'];
//     _offer = json['offer'];
//   }
//   num? _id;
//   List<ItemMedia>? _itemMedia;
//   String? _name;
//   String? _desc;
//   num? _quantity;
//   String? _unit;
//   num? _price;
//   String? _currency;
//   bool? _addon;
//   bool? _required;
//   bool? _toggleState;
//   num? _offer;
// OfferItems copyWith({  num? id,
//   List<ItemMedia>? itemMedia,
//   String? name,
//   String? desc,
//   num? quantity,
//   String? unit,
//   num? price,
//   String? currency,
//   bool? addon,
//   bool? required,
//   bool? toggleState,
//   num? offer,
// }) => OfferItems(  id: id ?? _id,
//   itemMedia: itemMedia ?? _itemMedia,
//   name: name ?? _name,
//   desc: desc ?? _desc,
//   quantity: quantity ?? _quantity,
//   unit: unit ?? _unit,
//   price: price ?? _price,
//   currency: currency ?? _currency,
//   addon: addon ?? _addon,
//   required: required ?? _required,
//   toggleState: toggleState ?? _toggleState,
//   offer: offer ?? _offer,
// );
//   num? get id => _id;
//   List<ItemMedia>? get itemMedia => _itemMedia;
//   String? get name => _name;
//   String? get desc => _desc;
//   num? get quantity => _quantity;
//   String? get unit => _unit;
//   num? get price => _price;
//   String? get currency => _currency;
//   bool? get addon => _addon;
//   bool? get required => _required;
//   bool? get toggleState => _toggleState;
//   num? get offer => _offer;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     if (_itemMedia != null) {
//       map['item_media'] = _itemMedia?.map((v) => v.toJson()).toList();
//     }
//     map['name'] = _name;
//     map['desc'] = _desc;
//     map['quantity'] = _quantity;
//     map['unit'] = _unit;
//     map['price'] = _price;
//     map['currency'] = _currency;
//     map['addon'] = _addon;
//     map['required'] = _required;
//     map['toggle_state'] = _toggleState;
//     map['offer'] = _offer;
//     return map;
//   }
//
// }
//
// /// id : 3
// /// media_type : ""
// /// media : "/media/offeritemsmedia/temp_8SRy3kn.png"
// /// offer_item : 3
//
// class ItemMedia {
//   ItemMedia({
//       num? id,
//       String? mediaType,
//       String? media,
//       num? offerItem,}){
//     _id = id;
//     _mediaType = mediaType;
//     _media = media;
//     _offerItem = offerItem;
// }
//
//   ItemMedia.fromJson(dynamic json) {
//     _id = json['id'];
//     _mediaType = json['media_type'];
//     _media = json['media'];
//     _offerItem = json['offer_item'];
//   }
//   num? _id;
//   String? _mediaType;
//   String? _media;
//   num? _offerItem;
// ItemMedia copyWith({  num? id,
//   String? mediaType,
//   String? media,
//   num? offerItem,
// }) => ItemMedia(  id: id ?? _id,
//   mediaType: mediaType ?? _mediaType,
//   media: media ?? _media,
//   offerItem: offerItem ?? _offerItem,
// );
//   num? get id => _id;
//   String? get mediaType => _mediaType;
//   String? get media => _media;
//   num? get offerItem => _offerItem;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['media_type'] = _mediaType;
//     map['media'] = _media;
//     map['offer_item'] = _offerItem;
//     return map;
//   }
//
// }
//
// /// id : 3
// /// periodicity : "Daily"
// /// fromperiod : null
// /// toperiod : null
// /// duration : ""
// /// fromperiodtime : "17:25:00"
// /// toperiodtime : "17:25:00"
// /// durationoftime : ""
// /// fromlocation : "Ujjain"
// /// tolocation : "dewas"
// /// atlocation : ""
// /// priority : "NORMAL"
// /// expiry : "15-05-2023 13:00"
// /// offer : 3
// /// servicepersons : 1
//
// class OfferConditions {
//   OfferConditions({
//       num? id,
//       String? periodicity,
//       dynamic fromperiod,
//       dynamic toperiod,
//       String? duration,
//       String? fromperiodtime,
//       String? toperiodtime,
//       String? durationoftime,
//       String? fromlocation,
//       String? tolocation,
//       String? atlocation,
//       String? priority,
//       String? expiry,
//       num? offer,
//       num? servicepersons,}){
//     _id = id;
//     _periodicity = periodicity;
//     _fromperiod = fromperiod;
//     _toperiod = toperiod;
//     _duration = duration;
//     _fromperiodtime = fromperiodtime;
//     _toperiodtime = toperiodtime;
//     _durationoftime = durationoftime;
//     _fromlocation = fromlocation;
//     _tolocation = tolocation;
//     _atlocation = atlocation;
//     _priority = priority;
//     _expiry = expiry;
//     _offer = offer;
//     _servicepersons = servicepersons;
// }
//
//   OfferConditions.fromJson(dynamic json) {
//     _id = json['id'];
//     _periodicity = json['periodicity'];
//     _fromperiod = json['fromperiod'];
//     _toperiod = json['toperiod'];
//     _duration = json['duration'];
//     _fromperiodtime = json['fromperiodtime'];
//     _toperiodtime = json['toperiodtime'];
//     _durationoftime = json['durationoftime'];
//     _fromlocation = json['fromlocation'];
//     _tolocation = json['tolocation'];
//     _atlocation = json['atlocation'];
//     _priority = json['priority'];
//     _expiry = json['expiry'];
//     _offer = json['offer'];
//     _servicepersons = json['servicepersons'];
//   }
//   num? _id;
//   String? _periodicity;
//   dynamic _fromperiod;
//   dynamic _toperiod;
//   String? _duration;
//   String? _fromperiodtime;
//   String? _toperiodtime;
//   String? _durationoftime;
//   String? _fromlocation;
//   String? _tolocation;
//   String? _atlocation;
//   String? _priority;
//   String? _expiry;
//   num? _offer;
//   num? _servicepersons;
// OfferConditions copyWith({  num? id,
//   String? periodicity,
//   dynamic fromperiod,
//   dynamic toperiod,
//   String? duration,
//   String? fromperiodtime,
//   String? toperiodtime,
//   String? durationoftime,
//   String? fromlocation,
//   String? tolocation,
//   String? atlocation,
//   String? priority,
//   String? expiry,
//   num? offer,
//   num? servicepersons,
// }) => OfferConditions(  id: id ?? _id,
//   periodicity: periodicity ?? _periodicity,
//   fromperiod: fromperiod ?? _fromperiod,
//   toperiod: toperiod ?? _toperiod,
//   duration: duration ?? _duration,
//   fromperiodtime: fromperiodtime ?? _fromperiodtime,
//   toperiodtime: toperiodtime ?? _toperiodtime,
//   durationoftime: durationoftime ?? _durationoftime,
//   fromlocation: fromlocation ?? _fromlocation,
//   tolocation: tolocation ?? _tolocation,
//   atlocation: atlocation ?? _atlocation,
//   priority: priority ?? _priority,
//   expiry: expiry ?? _expiry,
//   offer: offer ?? _offer,
//   servicepersons: servicepersons ?? _servicepersons,
// );
//   num? get id => _id;
//   String? get periodicity => _periodicity;
//   dynamic get fromperiod => _fromperiod;
//   dynamic get toperiod => _toperiod;
//   String? get duration => _duration;
//   String? get fromperiodtime => _fromperiodtime;
//   String? get toperiodtime => _toperiodtime;
//   String? get durationoftime => _durationoftime;
//   String? get fromlocation => _fromlocation;
//   String? get tolocation => _tolocation;
//   String? get atlocation => _atlocation;
//   String? get priority => _priority;
//   String? get expiry => _expiry;
//   num? get offer => _offer;
//   num? get servicepersons => _servicepersons;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['periodicity'] = _periodicity;
//     map['fromperiod'] = _fromperiod;
//     map['toperiod'] = _toperiod;
//     map['duration'] = _duration;
//     map['fromperiodtime'] = _fromperiodtime;
//     map['toperiodtime'] = _toperiodtime;
//     map['durationoftime'] = _durationoftime;
//     map['fromlocation'] = _fromlocation;
//     map['tolocation'] = _tolocation;
//     map['atlocation'] = _atlocation;
//     map['priority'] = _priority;
//     map['expiry'] = _expiry;
//     map['offer'] = _offer;
//     map['servicepersons'] = _servicepersons;
//     return map;
//   }
//
// }