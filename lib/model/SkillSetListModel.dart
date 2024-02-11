/// status : 200
/// message : "Skills List"
/// result : [{"id":1,"project_name":"drawaura","company_name":"evolve","experience":"python,django,flutter","user":4}]

class SkillSetListModel {
  SkillSetListModel({
      num? status, 
      String? message, 
      List<SkillSetData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  SkillSetListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(SkillSetData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<SkillSetData>? _result;
SkillSetListModel copyWith({  num? status,
  String? message,
  List<SkillSetData>? result,
}) => SkillSetListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<SkillSetData>? get result => _result;

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
/// project_name : "drawaura"
/// company_name : "evolve"
/// experience : "python,django,flutter"
/// user : 4

class SkillSetData {
  SkillSetData({
      num? id, 
      String? projectName, 
      String? companyName, 
      String? experience, 
      num? user,}){
    _id = id;
    _projectName = projectName;
    _companyName = companyName;
    _experience = experience;
    _user = user;
}

  SkillSetData.fromJson(dynamic json) {
    _id = json['id'];
    _projectName = json['project_name'];
    _companyName = json['company_name'];
    _experience = json['experience'];
    _user = json['user'];
  }
  num? _id;
  String? _projectName;
  String? _companyName;
  String? _experience;
  num? _user;
SkillSetData copyWith({  num? id,
  String? projectName,
  String? companyName,
  String? experience,
  num? user,
}) => SkillSetData(  id: id ?? _id,
  projectName: projectName ?? _projectName,
  companyName: companyName ?? _companyName,
  experience: experience ?? _experience,
  user: user ?? _user,
);
  num? get id => _id;
  String? get projectName => _projectName;
  String? get companyName => _companyName;
  String? get experience => _experience;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['project_name'] = _projectName;
    map['company_name'] = _companyName;
    map['experience'] = _experience;
    map['user'] = _user;
    return map;
  }

}