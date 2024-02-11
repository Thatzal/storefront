/// id : 12
/// offer_item_conditions : {"id":140,"serviceperson":[{"id":107,"username":"sandeep","displayname":"Sandeep"}],"periodicity":"Weekends","fromperiod":"22-08-2023","toperiod":"04-09-2023","duration":"13 Days","fromperiodtime":"13:03:00","toperiodtime":"13:03:00","durationoftime":null,"fromlocation":"43, Khajrana Main Rd, Pipal Chowk, Khajrana Main Rd, Indore","tolocation":null,"atlocation":null,"priority":"PREMIUM","expiry":"21-08-2023 13:03","offer_item":12,"servicepersons":[107]}
/// item_media : [{"id":126,"media_type":"","media":"/media/offeritemsmedia/temp_WoGSfjk.jpg","offer_item":12}]
/// unit : {"id":6,"name":"liter"}
/// advance_unit : {"id":null,"name":null}
/// maintenance_unit : {"id":null,"name":null}
/// name : "refined oil"
/// desc : "description"
/// quantity : 3
/// price : 150.0
/// advance_price : null
/// maintenance_price : null
/// currency : "INR"
/// addon : false
/// required : true
/// toggle_state : false
/// offer : 189

class OfferItemConditionModel {
  OfferItemConditionModel({
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

  OfferItemConditionModel.fromJson(dynamic json) {
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
OfferItemConditionModel copyWith({  num? id,
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
}) => OfferItemConditionModel(  id: id ?? _id,
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

/// id : 126
/// media_type : ""
/// media : "/media/offeritemsmedia/temp_WoGSfjk.jpg"
/// offer_item : 12

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