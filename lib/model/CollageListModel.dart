/// status : 200
/// message : "Colleges List"
/// result : [{"id":6,"college_name":"DAVV","college_address":"Indore","degreeequivalent":"M. Tech","subject":"CS","ClassNo":"1st Year","yearofpassing":"01-06-2024","user":4}]

class CollegeListModel {
  CollegeListModel({
      num? status, 
      String? message, 
      List<CollegeListData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  CollegeListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(CollegeListData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<CollegeListData>? _result;
CollegeListModel copyWith({  num? status,
  String? message,
  List<CollegeListData>? result,
}) => CollegeListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<CollegeListData>? get result => _result;

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

/// id : 6
/// college_name : "DAVV"
/// college_address : "Indore"
/// degreeequivalent : "M. Tech"
/// subject : "CS"
/// ClassNo : "1st Year"
/// yearofpassing : "01-06-2024"
/// user : 4

class CollegeListData {
  CollegeListData({
      num? id, 
      String? collegeName, 
      String? collegeAddress, 
      String? degreeequivalent, 
      String? subject, 
      String? classNo, 
      String? yearofpassing, 
      num? user,}){
    _id = id;
    _collegeName = collegeName;
    _collegeAddress = collegeAddress;
    _degreeequivalent = degreeequivalent;
    _subject = subject;
    _classNo = classNo;
    _yearofpassing = yearofpassing;
    _user = user;
}

  CollegeListData.fromJson(dynamic json) {
    _id = json['id'];
    _collegeName = json['college_name'];
    _collegeAddress = json['college_address'];
    _degreeequivalent = json['degreeequivalent'];
    _subject = json['subject'];
    _classNo = json['Class'];
    _yearofpassing = json['yearofpassing'];
    _user = json['user'];
  }
  num? _id;
  String? _collegeName;
  String? _collegeAddress;
  String? _degreeequivalent;
  String? _subject;
  String? _classNo;
  String? _yearofpassing;
  num? _user;
CollegeListData copyWith({  num? id,
  String? collegeName,
  String? collegeAddress,
  String? degreeequivalent,
  String? subject,
  String? classNo,
  String? yearofpassing,
  num? user,
}) => CollegeListData(  id: id ?? _id,
  collegeName: collegeName ?? _collegeName,
  collegeAddress: collegeAddress ?? _collegeAddress,
  degreeequivalent: degreeequivalent ?? _degreeequivalent,
  subject: subject ?? _subject,
  classNo: classNo ?? _classNo,
  yearofpassing: yearofpassing ?? _yearofpassing,
  user: user ?? _user,
);
  num? get id => _id;
  String? get collegeName => _collegeName;
  String? get collegeAddress => _collegeAddress;
  String? get degreeequivalent => _degreeequivalent;
  String? get subject => _subject;
  String? get classNo => _classNo;
  String? get yearofpassing => _yearofpassing;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['college_name'] = _collegeName;
    map['college_address'] = _collegeAddress;
    map['degreeequivalent'] = _degreeequivalent;
    map['subject'] = _subject;
    map['Class'] = _classNo;
    map['yearofpassing'] = _yearofpassing;
    map['user'] = _user;
    return map;
  }

}