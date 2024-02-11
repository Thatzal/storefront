/// status : 200
/// message : "Unit List"
/// result : [{"id":1,"name":"Gram"},{"id":2,"name":"Kilo Gram"}]

class UnitListModel {
  UnitListModel({
      num? status, 
      String? message, 
      List<UnitListData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  UnitListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(UnitListData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<UnitListData>? _result;
UnitListModel copyWith({  num? status,
  String? message,
  List<UnitListData>? result,
}) => UnitListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<UnitListData>? get result => _result;

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
/// name : "Gram"

class UnitListData {
  UnitListData({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  UnitListData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
UnitListData copyWith({  num? id,
  String? name,
}) => UnitListData(  id: id ?? _id,
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