/// status : 200
/// message : "Category List"
/// result : [{"id":1,"name":"Arts"},{"id":2,"name":"Finance"},{"id":3,"name":"Grocery"},{"id":4,"name":"Restaurant"},{"id":5,"name":"Hospitality"},{"id":6,"name":"AutoMobile"},{"id":7,"name":"Stationary"}]

class GetCategoryList {
  GetCategoryList({
      num? status, 
      String? message, 
      List<CategoryData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetCategoryList.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(CategoryData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<CategoryData>? _result;
GetCategoryList copyWith({  num? status,
  String? message,
  List<CategoryData>? result,
}) => GetCategoryList(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<CategoryData>? get result => _result;

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
/// name : "Arts"

class CategoryData {
  CategoryData({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  CategoryData copyWith({  num? id,
  String? name,
}) => CategoryData(  id: id ?? _id,
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