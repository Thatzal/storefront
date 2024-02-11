/// status : 200
/// message : "Work List"
/// result : [{"id":3,"firm_name":"EIPLc","firm_address":"Indore","designation":"Senior developer","job_role":"Full stack developer","skillset":"python,flutter","fromperiod":"01-01-2020","toperiod":"30-12-2022","user":4}]

class WorkExperiencesListModel {
  WorkExperiencesListModel({
      num? status, 
      String? message, 
      List<WorkExperiencesListData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  WorkExperiencesListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(WorkExperiencesListData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<WorkExperiencesListData>? _result;
WorkExperiencesListModel copyWith({  num? status,
  String? message,
  List<WorkExperiencesListData>? result,
}) => WorkExperiencesListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<WorkExperiencesListData>? get result => _result;

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
/// firm_name : "EIPLc"
/// firm_address : "Indore"
/// designation : "Senior developer"
/// job_role : "Full stack developer"
/// skillset : "python,flutter"
/// fromperiod : "01-01-2020"
/// toperiod : "30-12-2022"
/// user : 4

class WorkExperiencesListData {
  WorkExperiencesListData({
      num? id, 
      String? firmName, 
      String? firmAddress, 
      String? designation, 
      String? jobRole, 
      String? skillset, 
      String? fromperiod, 
      String? toperiod, 
      num? user,}){
    _id = id;
    _firmName = firmName;
    _firmAddress = firmAddress;
    _designation = designation;
    _jobRole = jobRole;
    _skillset = skillset;
    _fromperiod = fromperiod;
    _toperiod = toperiod;
    _user = user;
}

  WorkExperiencesListData.fromJson(dynamic json) {
    _id = json['id'];
    _firmName = json['firm_name'];
    _firmAddress = json['firm_address'];
    _designation = json['designation'];
    _jobRole = json['job_role'];
    _skillset = json['skillset'];
    _fromperiod = json['fromperiod'];
    _toperiod = json['toperiod'];
    _user = json['user'];
  }
  num? _id;
  String? _firmName;
  String? _firmAddress;
  String? _designation;
  String? _jobRole;
  String? _skillset;
  String? _fromperiod;
  String? _toperiod;
  num? _user;
WorkExperiencesListData copyWith({  num? id,
  String? firmName,
  String? firmAddress,
  String? designation,
  String? jobRole,
  String? skillset,
  String? fromperiod,
  String? toperiod,
  num? user,
}) => WorkExperiencesListData(  id: id ?? _id,
  firmName: firmName ?? _firmName,
  firmAddress: firmAddress ?? _firmAddress,
  designation: designation ?? _designation,
  jobRole: jobRole ?? _jobRole,
  skillset: skillset ?? _skillset,
  fromperiod: fromperiod ?? _fromperiod,
  toperiod: toperiod ?? _toperiod,
  user: user ?? _user,
);
  num? get id => _id;
  String? get firmName => _firmName;
  String? get firmAddress => _firmAddress;
  String? get designation => _designation;
  String? get jobRole => _jobRole;
  String? get skillset => _skillset;
  String? get fromperiod => _fromperiod;
  String? get toperiod => _toperiod;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firm_name'] = _firmName;
    map['firm_address'] = _firmAddress;
    map['designation'] = _designation;
    map['job_role'] = _jobRole;
    map['skillset'] = _skillset;
    map['fromperiod'] = _fromperiod;
    map['toperiod'] = _toperiod;
    map['user'] = _user;
    return map;
  }

}