// /// status : 200
// /// message : "Subscriber Offers List"
// /// result : [{"id":7,"offer_conditions":{"id":6,"servicepersons":[],"periodicity":"Today","fromperiod":"08-05-2023","toperiod":"08-05-2023","duration":"","fromperiodtime":"17:25:00","toperiodtime":"17:25:00","durationoftime":"","fromlocation":"indore","tolocation":"dewas","atlocation":"","priority":"NORMAL","expiry":"15-05-2023 13:00","offer":7},"offer_items":[{"id":6,"offer_item_conditions":null,"item_media":[{"id":6,"media_type":"","media":"/media/offeritemsmedia/temp_xYWv5rX.png","offer_item":6}],"name":"item 1","desc":"demo offer","quantity":2,"unit":"3","price":100.0,"currency":"INR","addon":false,"required":false,"toggle_state":false,"offer":7}],"offerfavoritecount":0,"offercopycount":0,"addres":"testing store","offerareas":"test1, test2","privacy":"PUBLIC","tabactivity":"NEW","buyORsell":"BUY","offerconfirmed":false,"offerinform":false,"offertemplate":false,"offerevent":false,"offerexecutestart":"08-05-2023 17:25","offerexecuteend":"08-05-2023 17:25","offersignedoff":false,"offerviewcount":0,"offerstatus":"LIVE","offerresponses":0,"offerservicepercentage":"0.00","computed_rating":"0.00","user_rating":"0.00","offerincepted":null,"created_at":"30-05-2023 13:07","modified":"30-05-2023 13:07","bid1":"False","bid2":"False","subscribers":{"id":1,"displayname":null,"phonenumber":"3698521477","username":"b'Tm9uZQ=='","email":null,"profile_picture":null,"page_picture":null,"desc":null,"placeORperson":"person","businessORpublic":"public","classification":null,"movable":false,"addressORarea":"address","operatingaddress":null,"maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"14-05-2023 09:56","modified":"14-05-2023 09:56","followers":[3],"following":[3]},"category":{"id":2,"name":"cheak"},"segment":{"id":1,"name":"Cosmetics Dental","category":1},"subsegment":{"id":1,"name":"Toothbrush","segment":1}}]
//
// class GetSubscriberOfferModal {
//   GetSubscriberOfferModal({
//       num? status,
//       String? message,
//       List<GetSubscriberResult>? result,}){
//     _status = status;
//     _message = message;
//     _result = result;
// }
//
//   GetSubscriberOfferModal.fromJson(dynamic json) {
//     _status = json['status'];
//     _message = json['message'];
//     if (json['result'] != null) {
//       _result = [];
//       json['result'].forEach((v) {
//         _result?.add(GetSubscriberResult.fromJson(v));
//       });
//     }
//   }
//   num? _status;
//   String? _message;
//   List<GetSubscriberResult>? _result;
// GetSubscriberOfferModal copyWith({  num? status,
//   String? message,
//   List<GetSubscriberResult>? result,
// }) => GetSubscriberOfferModal(  status: status ?? _status,
//   message: message ?? _message,
//   result: result ?? _result,
// );
//   num? get status => _status;
//   String? get message => _message;
//   List<GetSubscriberResult>? get result => _result;
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
// /// id : 7
// /// offer_conditions : {"id":6,"servicepersons":[],"periodicity":"Today","fromperiod":"08-05-2023","toperiod":"08-05-2023","duration":"","fromperiodtime":"17:25:00","toperiodtime":"17:25:00","durationoftime":"","fromlocation":"indore","tolocation":"dewas","atlocation":"","priority":"NORMAL","expiry":"15-05-2023 13:00","offer":7}
// /// offer_items : [{"id":6,"offer_item_conditions":null,"item_media":[{"id":6,"media_type":"","media":"/media/offeritemsmedia/temp_xYWv5rX.png","offer_item":6}],"name":"item 1","desc":"demo offer","quantity":2,"unit":"3","price":100.0,"currency":"INR","addon":false,"required":false,"toggle_state":false,"offer":7}]
// /// offerfavoritecount : 0
// /// offercopycount : 0
// /// addres : "testing store"
// /// offerareas : "test1, test2"
// /// privacy : "PUBLIC"
// /// tabactivity : "NEW"
// /// buyORsell : "BUY"
// /// offerconfirmed : false
// /// offerinform : false
// /// offertemplate : false
// /// offerevent : false
// /// offerexecutestart : "08-05-2023 17:25"
// /// offerexecuteend : "08-05-2023 17:25"
// /// offersignedoff : false
// /// offerviewcount : 0
// /// offerstatus : "LIVE"
// /// offerresponses : 0
// /// offerservicepercentage : "0.00"
// /// computed_rating : "0.00"
// /// user_rating : "0.00"
// /// offerincepted : null
// /// created_at : "30-05-2023 13:07"
// /// modified : "30-05-2023 13:07"
// /// bid1 : "False"
// /// bid2 : "False"
// /// subscribers : {"id":1,"displayname":null,"phonenumber":"3698521477","username":"b'Tm9uZQ=='","email":null,"profile_picture":null,"page_picture":null,"desc":null,"placeORperson":"person","businessORpublic":"public","classification":null,"movable":false,"addressORarea":"address","operatingaddress":null,"maritalstatus":"single","passportnumber":null,"dateofissue":null,"nationality":null,"dateofbirth":null,"gender":"M","religion":null,"subreligion":null,"caste":null,"subsect":null,"search_page_position_preferences":"TRENDING OFFERS","Offering_area_preference":null,"Offer_Category_preference":null,"Offer_Segment_preference":null,"Offer_Sub_Segment_preference":null,"Current_Location":null,"Want_to_Buy":false,"Want_to_sell":false,"Opt_Delivery":false,"Close_Confirmed_Offers":false,"Ok_for_Current_location_Offers":false,"Offer_match_percentage":"0.00","mean_computed_rating":0,"numberofcomputations":0,"mean_user_rating":0,"numberofusers_rating":0,"blocked":"NO","blockedtime":null,"subscription_status":"FREE","payment_done":null,"payment_date":null,"created_at":"14-05-2023 09:56","modified":"14-05-2023 09:56","followers":[3],"following":[3]}
// /// category : {"id":2,"name":"cheak"}
// /// segment : {"id":1,"name":"Cosmetics Dental","category":1}
// /// subsegment : {"id":1,"name":"Toothbrush","segment":1}
//
// class GetSubscriberResult {
//   GetSubscriberResult({
//       num? id,
//       OfferConditions? offerConditions,
//       List<OfferItems>? offerItems,
//       num? offerfavoritecount,
//       num? offercopycount,
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
//       String? offerstatus,
//       num? offerresponses,
//       String? offerservicepercentage,
//       String? computedRating,
//       String? userRating,
//       dynamic offerincepted,
//       String? createdAt,
//       String? modified,
//       String? bid1,
//       String? bid2,
//       Subscribers? subscribers,
//       Category? category,
//       Segment? segment,
//       Subsegment? subsegment,}){
//     _id = id;
//     _offerConditions = offerConditions;
//     _offerItems = offerItems;
//     _offerfavoritecount = offerfavoritecount;
//     _offercopycount = offercopycount;
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
//     _offerstatus = offerstatus;
//     _offerresponses = offerresponses;
//     _offerservicepercentage = offerservicepercentage;
//     _computedRating = computedRating;
//     _userRating = userRating;
//     _offerincepted = offerincepted;
//     _createdAt = createdAt;
//     _modified = modified;
//     _bid1 = bid1;
//     _bid2 = bid2;
//     _subscribers = subscribers;
//     _category = category;
//     _segment = segment;
//     _subsegment = subsegment;
// }
//
//   GetSubscriberResult.fromJson(dynamic json) {
//     _id = json['id'];
//     _offerConditions = json['offer_conditions'] != null ? OfferConditions.fromJson(json['offer_conditions']) : null;
//     if (json['offer_items'] != null) {
//       _offerItems = [];
//       json['offer_items'].forEach((v) {
//         _offerItems?.add(OfferItems.fromJson(v));
//       });
//     }
//     _offerfavoritecount = json['offerfavoritecount'];
//     _offercopycount = json['offercopycount'];
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
//     _offerstatus = json['offerstatus'];
//     _offerresponses = json['offerresponses'];
//     _offerservicepercentage = json['offerservicepercentage'];
//     _computedRating = json['computed_rating'];
//     _userRating = json['user_rating'];
//     _offerincepted = json['offerincepted'];
//     _createdAt = json['created_at'];
//     _modified = json['modified'];
//     _bid1 = json['bid1'];
//     _bid2 = json['bid2'];
//     _subscribers = json['subscribers'] != null ? Subscribers.fromJson(json['subscribers']) : null;
//     _category = json['category'] != null ? Category.fromJson(json['category']) : null;
//     _segment = json['segment'] != null ? Segment.fromJson(json['segment']) : null;
//     _subsegment = json['subsegment'] != null ? Subsegment.fromJson(json['subsegment']) : null;
//   }
//   num? _id;
//   OfferConditions? _offerConditions;
//   List<OfferItems>? _offerItems;
//   num? _offerfavoritecount;
//   num? _offercopycount;
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
//   String? _offerstatus;
//   num? _offerresponses;
//   String? _offerservicepercentage;
//   String? _computedRating;
//   String? _userRating;
//   dynamic _offerincepted;
//   String? _createdAt;
//   String? _modified;
//   String? _bid1;
//   String? _bid2;
//   Subscribers? _subscribers;
//   Category? _category;
//   Segment? _segment;
//   Subsegment? _subsegment;
// GetSubscriberResult copyWith({  num? id,
//   OfferConditions? offerConditions,
//   List<OfferItems>? offerItems,
//   num? offerfavoritecount,
//   num? offercopycount,
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
//   String? offerstatus,
//   num? offerresponses,
//   String? offerservicepercentage,
//   String? computedRating,
//   String? userRating,
//   dynamic offerincepted,
//   String? createdAt,
//   String? modified,
//   String? bid1,
//   String? bid2,
//   Subscribers? subscribers,
//   Category? category,
//   Segment? segment,
//   Subsegment? subsegment,
// }) => GetSubscriberResult(  id: id ?? _id,
//   offerConditions: offerConditions ?? _offerConditions,
//   offerItems: offerItems ?? _offerItems,
//   offerfavoritecount: offerfavoritecount ?? _offerfavoritecount,
//   offercopycount: offercopycount ?? _offercopycount,
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
//   offerstatus: offerstatus ?? _offerstatus,
//   offerresponses: offerresponses ?? _offerresponses,
//   offerservicepercentage: offerservicepercentage ?? _offerservicepercentage,
//   computedRating: computedRating ?? _computedRating,
//   userRating: userRating ?? _userRating,
//   offerincepted: offerincepted ?? _offerincepted,
//   createdAt: createdAt ?? _createdAt,
//   modified: modified ?? _modified,
//   bid1: bid1 ?? _bid1,
//   bid2: bid2 ?? _bid2,
//   subscribers: subscribers ?? _subscribers,
//   category: category ?? _category,
//   segment: segment ?? _segment,
//   subsegment: subsegment ?? _subsegment,
// );
//   num? get id => _id;
//   OfferConditions? get offerConditions => _offerConditions;
//   List<OfferItems>? get offerItems => _offerItems;
//   num? get offerfavoritecount => _offerfavoritecount;
//   num? get offercopycount => _offercopycount;
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
//   String? get offerstatus => _offerstatus;
//   num? get offerresponses => _offerresponses;
//   String? get offerservicepercentage => _offerservicepercentage;
//   String? get computedRating => _computedRating;
//   String? get userRating => _userRating;
//   dynamic get offerincepted => _offerincepted;
//   String? get createdAt => _createdAt;
//   String? get modified => _modified;
//   String? get bid1 => _bid1;
//   String? get bid2 => _bid2;
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
//     map['offerfavoritecount'] = _offerfavoritecount;
//     map['offercopycount'] = _offercopycount;
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
//     map['offerstatus'] = _offerstatus;
//     map['offerresponses'] = _offerresponses;
//     map['offerservicepercentage'] = _offerservicepercentage;
//     map['computed_rating'] = _computedRating;
//     map['user_rating'] = _userRating;
//     map['offerincepted'] = _offerincepted;
//     map['created_at'] = _createdAt;
//     map['modified'] = _modified;
//     map['bid1'] = _bid1;
//     map['bid2'] = _bid2;
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
// /// id : 1
// /// name : "Cosmetics Dental"
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
// /// id : 2
// /// name : "cheak"
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
// /// id : 1
// /// displayname : null
// /// phonenumber : "3698521477"
// /// username : "b'Tm9uZQ=='"
// /// email : null
// /// profile_picture : null
// /// page_picture : null
// /// desc : null
// /// placeORperson : "person"
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
// /// created_at : "14-05-2023 09:56"
// /// modified : "14-05-2023 09:56"
// /// followers : [3]
// /// following : [3]
//
// class Subscribers {
//   Subscribers({
//       num? id,
//       dynamic displayname,
//       String? phonenumber,
//       String? username,
//       dynamic email,
//       dynamic profilePicture,
//       dynamic pagePicture,
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
//   dynamic _displayname;
//   String? _phonenumber;
//   String? _username;
//   dynamic _email;
//   dynamic _profilePicture;
//   dynamic _pagePicture;
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
//   dynamic displayname,
//   String? phonenumber,
//   String? username,
//   dynamic email,
//   dynamic profilePicture,
//   dynamic pagePicture,
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
//   dynamic get displayname => _displayname;
//   String? get phonenumber => _phonenumber;
//   String? get username => _username;
//   dynamic get email => _email;
//   dynamic get profilePicture => _profilePicture;
//   dynamic get pagePicture => _pagePicture;
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
// /// id : 6
// /// offer_item_conditions : null
// /// item_media : [{"id":6,"media_type":"","media":"/media/offeritemsmedia/temp_xYWv5rX.png","offer_item":6}]
// /// name : "item 1"
// /// desc : "demo offer"
// /// quantity : 2
// /// unit : "3"
// /// price : 100.0
// /// currency : "INR"
// /// addon : false
// /// required : false
// /// toggle_state : false
// /// offer : 7
//
// class OfferItems {
//   OfferItems({
//       num? id,
//       dynamic offerItemConditions,
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
//     _offerItemConditions = offerItemConditions;
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
//     _offerItemConditions = json['offer_item_conditions'];
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
//   dynamic _offerItemConditions;
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
//   dynamic offerItemConditions,
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
//   offerItemConditions: offerItemConditions ?? _offerItemConditions,
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
//   dynamic get offerItemConditions => _offerItemConditions;
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
//     map['offer_item_conditions'] = _offerItemConditions;
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
// /// id : 6
// /// media_type : ""
// /// media : "/media/offeritemsmedia/temp_xYWv5rX.png"
// /// offer_item : 6
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
// /// id : 6
// /// servicepersons : []
// /// periodicity : "Today"
// /// fromperiod : "08-05-2023"
// /// toperiod : "08-05-2023"
// /// duration : ""
// /// fromperiodtime : "17:25:00"
// /// toperiodtime : "17:25:00"
// /// durationoftime : ""
// /// fromlocation : "indore"
// /// tolocation : "dewas"
// /// atlocation : ""
// /// priority : "NORMAL"
// /// expiry : "15-05-2023 13:00"
// /// offer : 7
//
// class OfferConditions {
//   OfferConditions({
//       num? id,
//       List<dynamic>? servicepersons,
//       String? periodicity,
//       String? fromperiod,
//       String? toperiod,
//       String? duration,
//       String? fromperiodtime,
//       String? toperiodtime,
//       String? durationoftime,
//       String? fromlocation,
//       String? tolocation,
//       String? atlocation,
//       String? priority,
//       String? expiry,
//       num? offer,}){
//     _id = id;
//     _servicepersons = servicepersons;
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
// }
//
//   OfferConditions.fromJson(dynamic json) {
//     _id = json['id'];
//     if (json['servicepersons'] != null) {
//       _servicepersons = [];
//       json['servicepersons'].forEach((v) {
//         _servicepersons?.add(v);
//       });
//     }
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
//   }
//   num? _id;
//   List<dynamic>? _servicepersons;
//   String? _periodicity;
//   String? _fromperiod;
//   String? _toperiod;
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
// OfferConditions copyWith({  num? id,
//   List<dynamic>? servicepersons,
//   String? periodicity,
//   String? fromperiod,
//   String? toperiod,
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
// }) => OfferConditions(  id: id ?? _id,
//   servicepersons: servicepersons ?? _servicepersons,
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
// );
//   num? get id => _id;
//   List<dynamic>? get servicepersons => _servicepersons;
//   String? get periodicity => _periodicity;
//   String? get fromperiod => _fromperiod;
//   String? get toperiod => _toperiod;
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
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     if (_servicepersons != null) {
//       map['servicepersons'] = _servicepersons?.map((v) => v.toJson()).toList();
//     }
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
//     return map;
//   }
//
// }