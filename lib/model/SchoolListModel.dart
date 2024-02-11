/// status : 200
/// message : "Schools List"
/// result : [{"id":2,"school_name":"Evolve","school_address":"Imli complex Indore","standard_form":"12th","grade":"8","yearofpassing":"01-06-2022","user":4}]

class SchoolListModel {
  SchoolListModel({
      num? status, 
      String? message, 
      List<SchoolListData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  SchoolListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(SchoolListData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<SchoolListData>? _result;
SchoolListModel copyWith({  num? status,
  String? message,
  List<SchoolListData>? result,
}) => SchoolListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<SchoolListData>? get result => _result;

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
/// school_name : "Evolve"
/// school_address : "Imli complex Indore"
/// standard_form : "12th"
/// grade : "8"
/// yearofpassing : "01-06-2022"
/// user : 4

class SchoolListData {
  SchoolListData({
      num? id, 
      String? schoolName, 
      String? schoolAddress, 
      String? standardForm, 
      String? grade, 
      String? yearofpassing, 
      num? user,}){
    _id = id;
    _schoolName = schoolName;
    _schoolAddress = schoolAddress;
    _standardForm = standardForm;
    _grade = grade;
    _yearofpassing = yearofpassing;
    _user = user;
}

  SchoolListData.fromJson(dynamic json) {
    _id = json['id'];
    _schoolName = json['school_name'];
    _schoolAddress = json['school_address'];
    _standardForm = json['standard_form'];
    _grade = json['grade'];
    _yearofpassing = json['yearofpassing'];
    _user = json['user'];
  }
  num? _id;
  String? _schoolName;
  String? _schoolAddress;
  String? _standardForm;
  String? _grade;
  String? _yearofpassing;
  num? _user;
SchoolListData copyWith({  num? id,
  String? schoolName,
  String? schoolAddress,
  String? standardForm,
  String? grade,
  String? yearofpassing,
  num? user,
}) => SchoolListData(  id: id ?? _id,
  schoolName: schoolName ?? _schoolName,
  schoolAddress: schoolAddress ?? _schoolAddress,
  standardForm: standardForm ?? _standardForm,
  grade: grade ?? _grade,
  yearofpassing: yearofpassing ?? _yearofpassing,
  user: user ?? _user,
);
  num? get id => _id;
  String? get schoolName => _schoolName;
  String? get schoolAddress => _schoolAddress;
  String? get standardForm => _standardForm;
  String? get grade => _grade;
  String? get yearofpassing => _yearofpassing;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['school_name'] = _schoolName;
    map['school_address'] = _schoolAddress;
    map['standard_form'] = _standardForm;
    map['grade'] = _grade;
    map['yearofpassing'] = _yearofpassing;
    map['user'] = _user;
    return map;
  }

}