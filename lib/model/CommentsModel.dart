/// status : "200"
/// message : "Offer comments List"
/// result : [{"id":1,"user":{"id":2,"username":"dharam","displayname":"Dharmendra Patidar","profile_picture":"/media/profile/user1.png"},"comment":"testing comment","created_at":"21-07-2023 12:32","updated_at":"21-07-2023 12:32","offer":116},{"id":2,"user":{"id":2,"username":"dharam","displayname":"Dharmendra Patidar","profile_picture":"/media/profile/user1.png"},"comment":"testing comment","created_at":"27-07-2023 18:43","updated_at":"27-07-2023 18:43","offer":116}]

class CommentsModel {
  CommentsModel({
      String? status, 
      String? message, 
      List<CommentsDataList>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  CommentsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(CommentsDataList.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<CommentsDataList>? _result;
CommentsModel copyWith({  String? status,
  String? message,
  List<CommentsDataList>? result,
}) => CommentsModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  List<CommentsDataList>? get result => _result;

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

/// id : 1
/// user : {"id":2,"username":"dharam","displayname":"Dharmendra Patidar","profile_picture":"/media/profile/user1.png"}
/// comment : "testing comment"
/// created_at : "21-07-2023 12:32"
/// updated_at : "21-07-2023 12:32"
/// offer : 116

class CommentsDataList {
  CommentsDataList({
      num? id, 
      CommentsUser? user,
      String? comment, 
      String? createdAt, 
      String? updatedAt, 
      num? offer,}){
    _id = id;
    _user = user;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _offer = offer;
}

  CommentsDataList.fromJson(dynamic json) {
    _id = json['id'];
    _user = json['user'] != null ? CommentsUser.fromJson(json['user']) : null;
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _offer = json['offer'];
  }
  num? _id;
  CommentsUser? _user;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;
  num? _offer;
CommentsDataList copyWith({  num? id,
  CommentsUser? user,
  String? comment,
  String? createdAt,
  String? updatedAt,
  num? offer,
}) => CommentsDataList(  id: id ?? _id,
  user: user ?? _user,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  offer: offer ?? _offer,
);
  num? get id => _id;
  CommentsUser? get user => _user;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get offer => _offer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['offer'] = _offer;
    return map;
  }

}

/// id : 2
/// username : "dharam"
/// displayname : "Dharmendra Patidar"
/// profile_picture : "/media/profile/user1.png"

class CommentsUser {
  CommentsUser({
      num? id, 
      String? username, 
      String? displayname, 
      String? profilePicture,}){
    _id = id;
    _username = username;
    _displayname = displayname;
    _profilePicture = profilePicture;
}

  CommentsUser.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _displayname = json['displayname'];
    _profilePicture = json['profile_picture'];
  }
  num? _id;
  String? _username;
  String? _displayname;
  String? _profilePicture;
CommentsUser copyWith({  num? id,
  String? username,
  String? displayname,
  String? profilePicture,
}) => CommentsUser(  id: id ?? _id,
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