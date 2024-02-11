/// status : 200
/// message : "Preference List"
/// result : [{"id":2,"user":{"id":19,"username":"dipak","displayname":"Deepak Giri Goswami"},"area_of_offering":"","category":{"id":4,"name":"Electronics"},"segment":{"id":47,"name":"mobile","category":4},"subsegment":{"id":56,"name":"5g","segment":47}},{"id":3,"user":{"id":19,"username":"dipak","displayname":"Deepak Giri Goswami"},"area_of_offering":"","category":{"id":57,"name":"Grocery"},"segment":{"id":12,"name":"Organic","category":1},"subsegment":{"id":37,"name":"coconut oil","segment":12}}]

class PrefChoiseCategories {
  PrefChoiseCategories({
      num? status, 
      String? message, 
      List<PrefChoiseCategoriesData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  PrefChoiseCategories.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(PrefChoiseCategoriesData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<PrefChoiseCategoriesData>? _result;
PrefChoiseCategories copyWith({  num? status,
  String? message,
  List<PrefChoiseCategoriesData>? result,
}) => PrefChoiseCategories(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<PrefChoiseCategoriesData>? get result => _result;

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

/// id : 2
/// user : {"id":19,"username":"dipak","displayname":"Deepak Giri Goswami"}
/// area_of_offering : ""
/// category : {"id":4,"name":"Electronics"}
/// segment : {"id":47,"name":"mobile","category":4}
/// subsegment : {"id":56,"name":"5g","segment":47}

class PrefChoiseCategoriesData {
  PrefChoiseCategoriesData({
      num? id, 
      User? user, 
      String? areaOfOffering, 
      Category? category, 
      Segment? segment, 
      Subsegment? subsegment,}){
    _id = id;
    _user = user;
    _areaOfOffering = areaOfOffering;
    _category = category;
    _segment = segment;
    _subsegment = subsegment;
}

  PrefChoiseCategoriesData.fromJson(dynamic json) {
    _id = json['id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _areaOfOffering = json['area_of_offering'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _segment = json['segment'] != null ? Segment.fromJson(json['segment']) : null;
    _subsegment = json['subsegment'] != null ? Subsegment.fromJson(json['subsegment']) : null;
  }
  num? _id;
  User? _user;
  String? _areaOfOffering;
  Category? _category;
  Segment? _segment;
  Subsegment? _subsegment;
PrefChoiseCategoriesData copyWith({  num? id,
  User? user,
  String? areaOfOffering,
  Category? category,
  Segment? segment,
  Subsegment? subsegment,
}) => PrefChoiseCategoriesData(  id: id ?? _id,
  user: user ?? _user,
  areaOfOffering: areaOfOffering ?? _areaOfOffering,
  category: category ?? _category,
  segment: segment ?? _segment,
  subsegment: subsegment ?? _subsegment,
);
  num? get id => _id;
  User? get user => _user;
  String? get areaOfOffering => _areaOfOffering;
  Category? get category => _category;
  Segment? get segment => _segment;
  Subsegment? get subsegment => _subsegment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['area_of_offering'] = _areaOfOffering;
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

/// id : 56
/// name : "5g"
/// segment : 47

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

/// id : 47
/// name : "mobile"
/// category : 4

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

/// id : 4
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

/// id : 19
/// username : "dipak"
/// displayname : "Deepak Giri Goswami"

class User {
  User({
      num? id, 
      String? username, 
      String? displayname,}){
    _id = id;
    _username = username;
    _displayname = displayname;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _displayname = json['displayname'];
  }
  num? _id;
  String? _username;
  String? _displayname;
User copyWith({  num? id,
  String? username,
  String? displayname,
}) => User(  id: id ?? _id,
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