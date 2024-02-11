/// status : 200
/// message : "Notification List"
/// result : [{"id":3,"from_user":{"id":2,"username":"dharam","displayname":"Dharmendra Patidar","profile_picture":"/media/profile/image_cropper_1694517227541.jpg"},"to_user":{"id":4,"username":"kishore","displayname":"Kishore Patidar","profile_picture":"/media/profile/image_cropper_1692860507555.jpg"},"type":"Like","Entity_id":null,"Entity_field_id":null,"Entity_value":null,"Entity_field_value":null,"Notifying_message":" Liked your Offer","Notifying_timestamp":"12-09-2023 18:29","offer":null,"counter_offer":null}]

class GetNotificationsModal {
  GetNotificationsModal({
      num? status, 
      String? message, 
      List<NotificationListModel>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetNotificationsModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(NotificationListModel.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<NotificationListModel>? _result;
GetNotificationsModal copyWith({  num? status,
  String? message,
  List<NotificationListModel>? result,
}) => GetNotificationsModal(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<NotificationListModel>? get result => _result;

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

/// id : 3
/// from_user : {"id":2,"username":"dharam","displayname":"Dharmendra Patidar","profile_picture":"/media/profile/image_cropper_1694517227541.jpg"}
/// to_user : {"id":4,"username":"kishore","displayname":"Kishore Patidar","profile_picture":"/media/profile/image_cropper_1692860507555.jpg"}
/// type : "Like"
/// Entity_id : null
/// Entity_field_id : null
/// Entity_value : null
/// Entity_field_value : null
/// Notifying_message : " Liked your Offer"
/// Notifying_timestamp : "12-09-2023 18:29"
/// offer : null
/// counter_offer : null

class NotificationListModel {
  NotificationListModel({
      num? id, 
      FromUser? fromUser, 
      ToUser? toUser, 
      String? type, 
      dynamic entityId, 
      dynamic entityFieldId, 
      dynamic entityValue, 
      dynamic entityFieldValue, 
      String? notifyingMessage, 
      String? notifyingTimestamp, 
      dynamic offer, 
      dynamic counterOffer,}){
    _id = id;
    _fromUser = fromUser;
    _toUser = toUser;
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

  NotificationListModel.fromJson(dynamic json) {
    _id = json['id'];
    _fromUser = json['from_user'] != null ? FromUser.fromJson(json['from_user']) : null;
    _toUser = json['to_user'] != null ? ToUser.fromJson(json['to_user']) : null;
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
  FromUser? _fromUser;
  ToUser? _toUser;
  String? _type;
  dynamic _entityId;
  dynamic _entityFieldId;
  dynamic _entityValue;
  dynamic _entityFieldValue;
  String? _notifyingMessage;
  String? _notifyingTimestamp;
  dynamic _offer;
  dynamic _counterOffer;
NotificationListModel copyWith({  num? id,
  FromUser? fromUser,
  ToUser? toUser,
  String? type,
  dynamic entityId,
  dynamic entityFieldId,
  dynamic entityValue,
  dynamic entityFieldValue,
  String? notifyingMessage,
  String? notifyingTimestamp,
  dynamic offer,
  dynamic counterOffer,
}) => NotificationListModel(  id: id ?? _id,
  fromUser: fromUser ?? _fromUser,
  toUser: toUser ?? _toUser,
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
  FromUser? get
  fromUser => _fromUser;
  ToUser? get toUser => _toUser;
  String? get type => _type;
  dynamic get entityId => _entityId;
  dynamic get entityFieldId => _entityFieldId;
  dynamic get entityValue => _entityValue;
  dynamic get entityFieldValue => _entityFieldValue;
  String? get notifyingMessage => _notifyingMessage;
  String? get notifyingTimestamp => _notifyingTimestamp;
  dynamic get offer => _offer;
  dynamic get counterOffer => _counterOffer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_fromUser != null) {
      map['from_user'] = _fromUser?.toJson();
    }
    if (_toUser != null) {
      map['to_user'] = _toUser?.toJson();
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

/// id : 4
/// username : "kishore"
/// displayname : "Kishore Patidar"
/// profile_picture : "/media/profile/image_cropper_1692860507555.jpg"

class ToUser {
  ToUser({
    dynamic id,
      String? username, 
      String? displayname, 
      String? profilePicture,}){
    _id = id;
    _username = username;
    _displayname = displayname;
    _profilePicture = profilePicture;
}

  ToUser.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _displayname = json['displayname'];
    _profilePicture = json['profile_picture'];
  }
  dynamic _id;
  String? _username;
  String? _displayname;
  String? _profilePicture;
ToUser copyWith({  dynamic id,
  String? username,
  String? displayname,
  String? profilePicture,
}) => ToUser(  id: id ?? _id,
  username: username ?? _username,
  displayname: displayname ?? _displayname,
  profilePicture: profilePicture ?? _profilePicture,
);
  dynamic get id => _id;
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

/// id : 2
/// username : "dharam"
/// displayname : "Dharmendra Patidar"
/// profile_picture : "/media/profile/image_cropper_1694517227541.jpg"

class FromUser {
  FromUser({
      dynamic id,
      String? username, 
      String? displayname, 
      String? profilePicture,}){
    _id = id;
    _username = username;
    _displayname = displayname;
    _profilePicture = profilePicture;
}

  FromUser.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _displayname = json['displayname'];
    _profilePicture = json['profile_picture'];
  }
  dynamic _id;
  String? _username;
  String? _displayname;
  String? _profilePicture;
FromUser copyWith({  dynamic id,
  String? username,
  String? displayname,
  String? profilePicture,
}) => FromUser(  id: id ?? _id,
  username: username ?? _username,
  displayname: displayname ?? _displayname,
  profilePicture: profilePicture ?? _profilePicture,
);
  dynamic get id => _id;
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