/// status : 200
/// message : "username List"
/// result : [null,null,null,null,"demo","pdharam"]

class GetAvailableUserNameListModel {
  GetAvailableUserNameListModel({
      num? status, 
      String? message, 
      List<dynamic>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetAvailableUserNameListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(v);
      });
    }
  }
  num? _status;
  String? _message;
  List<dynamic>? _result;
GetAvailableUserNameListModel copyWith({  num? status,
  String? message,
  List<dynamic>? result,
}) => GetAvailableUserNameListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<dynamic>? get result => _result;

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