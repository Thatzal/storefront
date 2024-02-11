import 'package:socialapps/model/serviceAreaModel.dart';

/// offer_conditions : {"servicepersons":null,"periodicity":"Once","fromperiod":"21-07-2023","toperiod":null,"duration":"00:00:5","fromperiodtime":"23:14:00","toperiodtime":null,"durationoftime":null,"fromlocation":"GRACE SUPERMARKET, Chennai","tolocation":null,"atlocation":null,"priority":"NORMAL","expiry":"21-07-2023 23:15"}
/// offer_items : [{"offer_item_conditions":{"servicepersons":null,"periodicity":"Once","fromperiod":"21-07-2023","toperiod":null,"duration":"00:00:5","fromperiodtime":"23:14:00","toperiodtime":null,"durationoftime":null,"fromlocation":"GRACE SUPERMARKET, Chennai","tolocation":null,"atlocation":null,"priority":"NORMAL","expiry":"21-07-2023 23:15"},"item_media":[{"media":"/media/offeritemsmedia/temp_Kp0CmB0.jpg"}],"name":"Organic sugar","desc":"Not normal sugar","quantity":2,"unit":"500g","price":250.0,"addon":false,"required":true,"toggle_state":false}]
/// offer_bids : [{"comments":"abc"}]
/// addres : "Select Address"
/// offerareas : "[{\"Address\":\"\"}]"
/// tabactivity : "NEW"
/// buyORsell : "BUY"
/// category : {"id":1,"name":"Grocery"}
/// segment : {"id":1,"name":"Cosmetics Dental","category":1}
/// subsegment : {"id":1,"name":"Toothbrush","segment":1}

class PrefillOfferDataModel {
  PrefillOfferDataModel({

      PrefillOfferConditions? offerConditions,
      List<PrefillOfferItems>? offerItems,
      List<PrefillOfferBids>? offerBids,
      String? addres,
      List<ServiceAreaModel>?  offerareas,
      String? tabactivity,
      String? buyORsell,
      FillCategory? category,
      FillSegment? segment,
      FillSubsegment? subsegment,
      String ? privacy,
      String ? offerId,
  }){
    _offerConditions = offerConditions;
    _offerItems = offerItems;
    _offerBids = offerBids;
    _addres = addres;
    _offerareas = offerareas;
    _tabactivity = tabactivity;
    _buyORsell = buyORsell;
    _category = category;
    _segment = segment;
    _subsegment = subsegment;
    _privacy = privacy;
    _offerId = offerId;
}

  PrefillOfferDataModel.fromJson(dynamic json) {
    _offerConditions = json['offer_conditions'] != null ? PrefillOfferConditions.fromJson(json['offer_conditions']) : null;
    if (json['offer_items'] != null) {
      _offerItems = [];
      json['offer_items'].forEach((v) {
        _offerItems?.add(PrefillOfferItems.fromJson(v));
      });
    }
    if (json['offer_bids'] != null) {
      _offerBids = [];
      json['offer_bids'].forEach((v) {
        _offerBids?.add(PrefillOfferBids.fromJson(v));
      });
    }
    if (json['offerareas'] != null) {
      _offerareas = [];
      json['offerareas'].forEach((v) {
        _offerareas?.add(ServiceAreaModel.fromJson(v));
      });
    }
    _addres = json['addres'];
    _tabactivity = json['tabactivity'];
    _buyORsell = json['buyORsell'];
    _category = json['category'] != null ? FillCategory.fromJson(json['category']) : null;
    _segment = json['segment'] != null ? FillSegment.fromJson(json['segment']) : null;
    _subsegment = json['subsegment'] != null ? FillSubsegment.fromJson(json['subsegment']) : null;
    _privacy = json['privacy'];
    _offerId = json['offerId'];
  }
  PrefillOfferConditions? _offerConditions;
  List<PrefillOfferItems>? _offerItems;
  List<PrefillOfferBids>? _offerBids;
  String? _addres;
  List<ServiceAreaModel>? _offerareas;
  String? _tabactivity;
  String? _buyORsell;
  FillCategory? _category;
  FillSegment? _segment;
  FillSubsegment? _subsegment;
  String ? _privacy;
  String ? _offerId;
  PrefillOfferDataModel copyWith({
    PrefillOfferConditions? offerConditions,
  List<PrefillOfferItems>? offerItems,
  List<PrefillOfferBids>? offerBids,
  String? addres,
    List<ServiceAreaModel>? offerareas,
  String? tabactivity,
  String? buyORsell,
  FillCategory? category,
  FillSegment? segment,
  FillSubsegment? subsegment,
    String ?privacy,
    String ?offerId,

}) => PrefillOfferDataModel(  offerConditions: offerConditions ?? _offerConditions,
  offerItems: offerItems ?? _offerItems,
  offerBids: offerBids ?? _offerBids,
  addres: addres ?? _addres,
  offerareas: offerareas ?? _offerareas,
  tabactivity: tabactivity ?? _tabactivity,
  buyORsell: buyORsell ?? _buyORsell,
  category: category ?? _category,
  segment: segment ?? _segment,
  subsegment: subsegment ?? _subsegment,
      privacy:privacy ??_privacy,
    offerId:offerId ??_offerId,
);
  PrefillOfferConditions? get offerConditions => _offerConditions;
  List<PrefillOfferItems>? get offerItems => _offerItems;
  List<PrefillOfferBids>? get offerBids => _offerBids;
  List<ServiceAreaModel>? get offerareas => _offerareas;
  String? get tabactivity => _tabactivity;
  String? get buyORsell => _buyORsell;
  String? get addres => _addres;
  FillCategory? get category => _category;
  FillSegment? get segment => _segment;
  FillSubsegment? get subsegment => _subsegment;
  String? get privacy => _privacy;
  String? get offerId => _offerId;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_offerConditions != null) {
      map['offer_conditions'] = _offerConditions?.toJson();
    }
    if (_offerItems != null) {
      map['offer_items'] = _offerItems?.map((v) => v.toJson()).toList();
    }
    if (_offerBids != null) {
      map['offer_bids'] = _offerBids?.map((v) => v.toJson()).toList();
    }
    map['addres'] = _addres;

    if (_offerareas != null) {
      map['offerareas'] = _offerareas?.map((v) => v.toJson()).toList();
    }
    map['tabactivity'] = _tabactivity;
    map['buyORsell'] = _buyORsell;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_segment != null) {
      map['segment'] = _segment?.toJson();
    }
    if (_subsegment != null) {
      map['subsegment'] = _subsegment?.toJson();
    }
    map['privacy'] = _privacy;
    map['offerId'] = _offerId;
    return map;
  }

}

/// id : 1
/// name : "Toothbrush"
/// segment : 1

class FillSubsegment {
  FillSubsegment({
      num? id,
      String? name,
      num? segment,}){
    _id = id;
    _name = name;
    _segment = segment;
}

  FillSubsegment.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _segment = json['segment'];
  }
  num? _id;
  String? _name;
  num? _segment;
FillSubsegment copyWith({  num? id,
  String? name,
  num? segment,
}) => FillSubsegment(  id: id ?? _id,
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

class FillSegment {
  FillSegment({
      num? id,
      String? name,
      num? category,}){
    _id = id;
    _name = name;
    _category = category;
}

  FillSegment.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _category = json['category'];
  }
  num? _id;
  String? _name;
  num? _category;
FillSegment copyWith({  num? id,
  String? name,
  num? category,
}) => FillSegment(  id: id ?? _id,
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

class FillCategory {
  FillCategory({
      num? id,
      String? name,}){
    _id = id;
    _name = name;
}

  FillCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
FillCategory copyWith({  num? id,
  String? name,
}) => FillCategory(  id: id ?? _id,
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

/// comments : "abc"

class PrefillOfferBids {
  PrefillOfferBids({
      String ?id,
      String? comments,
  }){
    _id = id;
    _comments = comments;
}

  PrefillOfferBids.fromJson(dynamic json) {
    _id = json['id'];
    _comments = json['comments'];
  }
  String? _id;
  String? _comments;
PrefillOfferBids copyWith({
  String? id,
  String? comments,
}) => PrefillOfferBids(
  id: id ?? _id,
  comments: comments ?? _comments,
);
  String? get id => _id;
  String? get comments => _comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['comments'] = _comments;
    return map;
  }
}

/// offer_item_conditions : {"servicepersons":null,"periodicity":"Once","fromperiod":"21-07-2023","toperiod":null,"duration":"00:00:5","fromperiodtime":"23:14:00","toperiodtime":null,"durationoftime":null,"fromlocation":"GRACE SUPERMARKET, Chennai","tolocation":null,"atlocation":null,"priority":"NORMAL","expiry":"21-07-2023 23:15"}
/// item_media : [{"media":"/media/offeritemsmedia/temp_Kp0CmB0.jpg"}]
/// name : "Organic sugar"
/// desc : "Not normal sugar"
/// quantity : 2
/// unit : "500g"
/// price : 250.0
/// addon : false
/// required : true
/// toggle_state : false
class PrefillOfferItems {
  PrefillOfferItems({
    num? id,
    PrefillOfferItemConditions? offerItemConditions,
    List<dynamic>? itemMedia,
    PrefillUnit? unit,
    FillAdvanceUnit? advanceUnit,
    FillMaintenanceUnit? maintenanceUnit,
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
    _offer = offer;
    _counterOffer = counterOffer;
    _user = user;
    _createdAt = createdAt;

  }

  PrefillOfferItems.fromJson(dynamic json) {
    _id = json['id'];
    _offerItemConditions = json['offer_item_conditions'] != null ? PrefillOfferItemConditions.fromJson(json['offer_item_conditions']) : null;

    if (json['item_media'] != null) {
      _itemMedia = [];
      json['item_media'].forEach((v) {
        _itemMedia?.add((v));
      });
    }
    _unit = json['unit'] != null ? PrefillUnit.fromJson(json['unit']) : null;
    _advanceUnit = json['advance_unit'] != null ? FillAdvanceUnit.fromJson(json['advance_unit']) : null;
    _maintenanceUnit = json['maintenance_unit'] != null ? FillMaintenanceUnit.fromJson(json['maintenance_unit']) : null;
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
    _counterOffer = json['counter_offer'];
    _user = json['user'];
    _createdAt = json['create_date'];


  }
  num? _id;
  PrefillOfferItemConditions? _offerItemConditions;
  List<dynamic>? _itemMedia;
  PrefillUnit? _unit;
  FillAdvanceUnit? _advanceUnit;
  FillMaintenanceUnit? _maintenanceUnit;
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
  num? _counterOffer;
  num? _user;
  String? _createdAt;

  PrefillOfferItems copyWith({  num? id,
    PrefillOfferItemConditions? offerItemConditions,
    List<dynamic>? itemMedia,
    PrefillUnit? unit,
    FillAdvanceUnit? advanceUnit,
    FillMaintenanceUnit? maintenanceUnit,
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
    num? counterOffer,
    num? user,
    String? createdAt,

  }) => PrefillOfferItems(  id: id ?? _id,
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
    counterOffer: counterOffer ?? _counterOffer,
    user: user ?? _user,
    createdAt: createdAt ?? _createdAt,

  );
  num? get id => _id;
  PrefillOfferItemConditions? get offerItemConditions => _offerItemConditions;
  List<dynamic>? get itemMedia => _itemMedia;
  PrefillUnit? get unit => _unit;
  FillAdvanceUnit? get advanceUnit => _advanceUnit;
  FillMaintenanceUnit? get maintenanceUnit => _maintenanceUnit;
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
    map['counter_offer'] = _counterOffer;
    map['user'] = _user;
    map['create_date'] = _createdAt;

    return map;
  }

}


// class PreFillItemMedia {
//   PreFillItemMedia({
//
//     String? file,
//     String? name,
//    }){
//
//     _name = name;
//     _file = file;
//
//   }
//
//   PreFillItemMedia.fromJson(dynamic json) {
//     _file = json['file'];
//     _name = json['name'];
//
//
//   }
//
//   String? _file;
//   String? _name;
//
//   PreFillItemMedia copyWith({
//
//     String? file,
//     String? name,
//
//   }) => PreFillItemMedia(
//
//     file: file ?? _file,
//     name: name ?? _name,
//   );
//
//   String? get name => _name;
//   String? get file => _file;
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//
//     map['file'] = _file;
//     map['name'] = _name;
//
//     return map;
//   }
//
// }
/// id : null
/// name : null

class FillMaintenanceUnit {
  FillMaintenanceUnit({
    dynamic id,
    dynamic name,}){
    _id = id;
    _name = name;
  }

  FillMaintenanceUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  dynamic _id;
  dynamic _name;
  FillMaintenanceUnit copyWith({  dynamic id,
    dynamic name,
  }) => FillMaintenanceUnit(  id: id ?? _id,
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

class FillAdvanceUnit {
  FillAdvanceUnit({
    dynamic id,
    dynamic name,}){
    _id = id;
    _name = name;
  }

  FillAdvanceUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  dynamic _id;
  dynamic _name;
  FillAdvanceUnit copyWith({  dynamic id,
    dynamic name,
  }) => FillAdvanceUnit(  id: id ?? _id,
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

class PrefillUnit {
  PrefillUnit({
    num? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  PrefillUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  PrefillUnit copyWith({  num? id,
    String? name,
  }) => PrefillUnit(  id: id ?? _id,
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

/// id : 126
/// media_type : ""
/// media : "/media/offeritemsmedia/temp_WoGSfjk.jpg"
/// offer_item : 12

// class ItemMedia {
//   ItemMedia({
//     String? media,}){
//     _media = media;
//   }
//
//   ItemMedia.fromJson(dynamic json) {
//     _media = json['media'];
//   }
//   String? _media;
//   ItemMedia copyWith({  String? media,
//   }) => ItemMedia(  media: media ?? _media,
//   );
//   String? get media => _media;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['media'] = _media;
//     return map;
//   }
//
// }

/// id : 140
/// serviceperson : [{"id":107,"username":"sandeep","displayname":"Sandeep"}]
/// periodicity : "Weekends"
/// fromperiod : "22-08-2023"
/// toperiod : "04-09-2023"
/// duration : "13 Days"
/// fromperiodtime : "13:03:00"
/// toperiodtime : "13:03:00"
/// durationoftime : null
/// fromlocation : "43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore"
/// tolocation : null
/// atlocation : null
/// priority : "PREMIUM"
/// expiry : "21-08-2023 13:03"
/// offer_item : 12
/// servicepersons : [107]

class PrefillOfferItemConditions {
  PrefillOfferItemConditions({
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
    String? timePeriod,
    num? offerItem,

    List<dynamic>? servicepersons,
  }){
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
    _timePeriod = timePeriod;
    _servicepersons = servicepersons;
  }

  PrefillOfferItemConditions.fromJson(dynamic json) {
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
    _timePeriod = json["timePeriod"];
    _servicepersons = json['servicepersons'] != null ? json['servicepersons'].cast<dynamic>() : [];
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
  String? _timePeriod;
  List<dynamic>? _servicepersons;
  PrefillOfferItemConditions copyWith({  num? id,
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
    String? timePeriod,
    List<dynamic>? servicepersons,
  }) => PrefillOfferItemConditions(  id: id ?? _id,
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
    timePeriod: timePeriod ?? _timePeriod,
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
  String? get timePeriod => _timePeriod;
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
    map['priority'] = _priority;
    map['expiry'] = _expiry;
    map['timePeriod'] = _timePeriod;
    map['offer_item'] = _offerItem;
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

class PrefillOfferConditions {
  PrefillOfferConditions({
      dynamic servicepersons,
      String? periodicity,
      String? duration,
      String? timePeriod,
      dynamic fromPeriod,
      dynamic toPeriod,
      dynamic fromPeriodTime,
      dynamic toPeriodTime,
      String? fromlocation,
      dynamic tolocation,
      dynamic atlocation,
      String? priority,
      String? expiry,
      String? id,
  }){
    _servicepersons = servicepersons;
    _periodicity = periodicity;
   _timePeriod = timePeriod;
   _fromPeriod = fromPeriod;
   _toPeriod = toPeriod;
   _fromPeriodTime = fromPeriodTime;
   _toPeriodTime = toPeriodTime;
    _duration = duration;
    _fromlocation = fromlocation;
    _tolocation = tolocation;
    _atlocation = atlocation;
    _priority = priority;
    _expiry = expiry;
    _id = id;
}

  PrefillOfferConditions.fromJson(dynamic json) {
    _servicepersons = json['servicepersons'];
    _periodicity = json['periodicity'];
    _duration = json['duration'];
    _timePeriod = json["timePeriod"];
    _fromlocation = json['fromlocation'];
    _tolocation = json['tolocation'];
    _atlocation = json['atlocation'];
    _priority = json['priority'];
    _expiry = json['expiry'];
    _fromPeriod = json["fromPeriod"];
    _toPeriod = json["toPeriod"];
    _fromPeriodTime = json["fromPeriodTime"];
    _toPeriodTime = json["toPeriodTime"];
    _id = json["id"];
  }
  dynamic _servicepersons;
  String? _periodicity;
  String? _duration;
  String? _timePeriod;
  String? _fromlocation;
  dynamic _tolocation;
  dynamic _atlocation;
  String? _priority;
  String? _expiry;
  dynamic _fromPeriod;
  dynamic _toPeriod;
  dynamic _fromPeriodTime;
  dynamic _toPeriodTime;
  String? _id;
  PrefillOfferConditions copyWith({  dynamic servicepersons,
  String? periodicity,
  String? duration,
  String? timePeriod,
  String? fromlocation,
  dynamic tolocation,
  dynamic atlocation,
  String? priority,
  String? expiry,
    dynamic fromPeriod,
    dynamic toPeriod,
    dynamic fromPeriodTime,
    dynamic toPeriodTime,
    String? id,
  }) => PrefillOfferConditions(  servicepersons: servicepersons ?? _servicepersons,
  periodicity: periodicity ?? _periodicity,
  duration: duration ?? _duration,
  timePeriod: timePeriod ?? _timePeriod,
  fromlocation: fromlocation ?? _fromlocation,
  tolocation: tolocation ?? _tolocation,
  atlocation: atlocation ?? _atlocation,
  priority: priority ?? _priority,
  expiry: expiry ?? _expiry,
    fromPeriod: fromPeriod ?? _fromPeriod,
    toPeriod: toPeriod ?? _toPeriod,
    fromPeriodTime: fromPeriodTime ?? _fromPeriodTime,
    toPeriodTime: toPeriodTime ?? _toPeriodTime,
    id: id ?? _id,
);
  dynamic get servicepersons => _servicepersons;
  String? get periodicity => _periodicity;
  String? get duration => _duration;
  String? get timePeriod => _timePeriod;
  String? get fromlocation => _fromlocation;
  dynamic get tolocation => _tolocation;
  dynamic get atlocation => _atlocation;
  String? get priority => _priority;
  String? get expiry => _expiry;
  dynamic get fromPeriod => _fromPeriod;
  dynamic get toPeriod => _toPeriod;
  dynamic get fromPeriodTime => _fromPeriodTime;
  dynamic get toPeriodTime => _toPeriodTime;
  String? get id => _id;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['servicepersons'] = _servicepersons;
    map['periodicity'] = _periodicity;
    map['duration'] = _duration;
    map['timePeriod'] = _timePeriod;
    map['fromlocation'] = _fromlocation;
    map['tolocation'] = _tolocation;
    map['atlocation'] = _atlocation;
    map['priority'] = _priority;
    map['expiry'] = _expiry;
    map['fromPeriod'] = _fromPeriod;
    map['toPeriod'] = _toPeriod;
    map['fromPeriodTime'] = _fromPeriodTime;
    map['toPeriodTime'] = _toPeriodTime;
    map['id'] = _id;
    return map;
  }

}