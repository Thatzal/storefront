/// status : 200
/// message : "Subscribers Certification List"
/// result : [{"id":4,"institution_name":"EIPL","institution_address":"Indore","certificate":"Experience","subject":"Flutter","ClassNo":"etc","fromperiod":"01-07-2020","toperiod":"30-12-2020","user":4}]

class CertificationListModel {
  CertificationListModel({
      num? status, 
      String? message, 
      List<CertificationDataList>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  CertificationListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(CertificationDataList.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<CertificationDataList>? _result;
CertificationListModel copyWith({  num? status,
  String? message,
  List<CertificationDataList>? result,
}) => CertificationListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<CertificationDataList>? get result => _result;

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

/// id : 4
/// institution_name : "EIPL"
/// institution_address : "Indore"
/// certificate : "Experience"
/// subject : "Flutter"
/// ClassNo : "etc"
/// fromperiod : "01-07-2020"
/// toperiod : "30-12-2020"
/// user : 4

class CertificationDataList {
  CertificationDataList({
      num? id, 
      String? institutionName, 
      String? institutionAddress, 
      String? certificate, 
      String? subject, 
      String? classNo, 
      String? fromperiod, 
      String? toperiod, 
      num? user,}){
    _id = id;
    _institutionName = institutionName;
    _institutionAddress = institutionAddress;
    _certificate = certificate;
    _subject = subject;
    _classNo = classNo;
    _fromperiod = fromperiod;
    _toperiod = toperiod;
    _user = user;
}

  CertificationDataList.fromJson(dynamic json) {
    _id = json['id'];
    _institutionName = json['institution_name'];
    _institutionAddress = json['institution_address'];
    _certificate = json['certificate'];
    _subject = json['subject'];
    _classNo = json['Class'];
    _fromperiod = json['fromperiod'];
    _toperiod = json['toperiod'];
    _user = json['user'];
  }
  num? _id;
  String? _institutionName;
  String? _institutionAddress;
  String? _certificate;
  String? _subject;
  String? _classNo;
  String? _fromperiod;
  String? _toperiod;
  num? _user;
CertificationDataList copyWith({  num? id,
  String? institutionName,
  String? institutionAddress,
  String? certificate,
  String? subject,
  String? classNo,
  String? fromperiod,
  String? toperiod,
  num? user,
}) => CertificationDataList(  id: id ?? _id,
  institutionName: institutionName ?? _institutionName,
  institutionAddress: institutionAddress ?? _institutionAddress,
  certificate: certificate ?? _certificate,
  subject: subject ?? _subject,
  classNo: classNo ?? _classNo,
  fromperiod: fromperiod ?? _fromperiod,
  toperiod: toperiod ?? _toperiod,
  user: user ?? _user,
);
  num? get id => _id;
  String? get institutionName => _institutionName;
  String? get institutionAddress => _institutionAddress;
  String? get certificate => _certificate;
  String? get subject => _subject;
  String? get classNo => _classNo;
  String? get fromperiod => _fromperiod;
  String? get toperiod => _toperiod;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['institution_name'] = _institutionName;
    map['institution_address'] = _institutionAddress;
    map['certificate'] = _certificate;
    map['subject'] = _subject;
    map['Class'] = _classNo;
    map['fromperiod'] = _fromperiod;
    map['toperiod'] = _toperiod;
    map['user'] = _user;
    return map;
  }

}