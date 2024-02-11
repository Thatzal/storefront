/// id : 825
/// subscriber : {"id":19,"username":"dipak","displayname":"Deepak Giri Goswami","profile_picture":"/media/profile/image_cropper_1692257863671.jpg"}
/// type : "ItemSelected"
/// Entity_id : null
/// Entity_field_id : null
/// Entity_value : null
/// Entity_field_value : null
/// Notifying_message : "kishore Checked Raider"
/// Notifying_timestamp : "28-08-2023 17:23"
/// offer : 203
/// counter_offer : 215

class CounterNotifyModel {
  CounterNotifyModel({
      num? id, 
      Subscriber? subscriber, 
      String? type, 
      dynamic entityId, 
      dynamic entityFieldId, 
      dynamic entityValue, 
      dynamic entityFieldValue, 
      String? notifyingMessage, 
      String? notifyingTimestamp, 
      num? offer, 
      num? counterOffer,}){
    _id = id;
    _subscriber = subscriber;
    _type = type;
    _entityId = entityId;
    _entityFieldId = entityFieldId;
    _entityValue = entityValue;
    _entityFieldValue = entityFieldValue;
    _notifyingMessage = notifyingMessage;
    _notifyingTimestamp = notifyingTimestamp;
    _offer = offer;
    _counterOffer = counterOffer;
}

  CounterNotifyModel.fromJson(dynamic json) {
    _id = json['id'];
    _subscriber = json['subscriber'] != null ? Subscriber.fromJson(json['subscriber']) : null;
    _type = json['type'];
    _entityId = json['Entity_id'];
    _entityFieldId = json['Entity_field_id'];
    _entityValue = json['Entity_value'];
    _entityFieldValue = json['Entity_field_value'];
    _notifyingMessage = json['Notifying_message'];
    _notifyingTimestamp = json['Notifying_timestamp'];
    _offer = json['offer'];
    _counterOffer = json['counter_offer'];
  }
  num? _id;
  Subscriber? _subscriber;
  String? _type;
  dynamic _entityId;
  dynamic _entityFieldId;
  dynamic _entityValue;
  dynamic _entityFieldValue;
  String? _notifyingMessage;
  String? _notifyingTimestamp;
  num? _offer;
  num? _counterOffer;
CounterNotifyModel copyWith({  num? id,
  Subscriber? subscriber,
  String? type,
  dynamic entityId,
  dynamic entityFieldId,
  dynamic entityValue,
  dynamic entityFieldValue,
  String? notifyingMessage,
  String? notifyingTimestamp,
  num? offer,
  num? counterOffer,
}) => CounterNotifyModel(  id: id ?? _id,
  subscriber: subscriber ?? _subscriber,
  type: type ?? _type,
  entityId: entityId ?? _entityId,
  entityFieldId: entityFieldId ?? _entityFieldId,
  entityValue: entityValue ?? _entityValue,
  entityFieldValue: entityFieldValue ?? _entityFieldValue,
  notifyingMessage: notifyingMessage ?? _notifyingMessage,
  notifyingTimestamp: notifyingTimestamp ?? _notifyingTimestamp,
  offer: offer ?? _offer,
  counterOffer: counterOffer ?? _counterOffer,
);
  num? get id => _id;
  Subscriber? get subscriber => _subscriber;
  String? get type => _type;
  dynamic get entityId => _entityId;
  dynamic get entityFieldId => _entityFieldId;
  dynamic get entityValue => _entityValue;
  dynamic get entityFieldValue => _entityFieldValue;
  String? get notifyingMessage => _notifyingMessage;
  String? get notifyingTimestamp => _notifyingTimestamp;
  num? get offer => _offer;
  num? get counterOffer => _counterOffer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_subscriber != null) {
      map['subscriber'] = _subscriber?.toJson();
    }
    map['type'] = _type;
    map['Entity_id'] = _entityId;
    map['Entity_field_id'] = _entityFieldId;
    map['Entity_value'] = _entityValue;
    map['Entity_field_value'] = _entityFieldValue;
    map['Notifying_message'] = _notifyingMessage;
    map['Notifying_timestamp'] = _notifyingTimestamp;
    map['offer'] = _offer;
    map['counter_offer'] = _counterOffer;
    return map;
  }

}

/// id : 19
/// username : "dipak"
/// displayname : "Deepak Giri Goswami"
/// profile_picture : "/media/profile/image_cropper_1692257863671.jpg"

class Subscriber {
  Subscriber({
      num? id, 
      String? username, 
      String? displayname, 
      String? profilePicture,}){
    _id = id;
    _username = username;
    _displayname = displayname;
    _profilePicture = profilePicture;
}

  Subscriber.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _displayname = json['displayname'];
    _profilePicture = json['profile_picture'];
  }
  num? _id;
  String? _username;
  String? _displayname;
  String? _profilePicture;
Subscriber copyWith({  num? id,
  String? username,
  String? displayname,
  String? profilePicture,
}) => Subscriber(  id: id ?? _id,
  username: username ?? _username,
  displayname: displayname ?? _displayname,
  profilePicture: profilePicture ?? _profilePicture,
);
  num? get id => _id;
  String? get username => _username;
  String? get displayname => _displayname;
  String? get profilePicture => _profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['displayname'] = _displayname;
    map['profile_picture'] = _profilePicture;
    return map;
  }

}