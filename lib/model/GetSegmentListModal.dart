/// status : 200
/// message : "Segment List"
/// result : [{"id":16,"name":"Food and Beverage","category":5},{"id":17,"name":"Food and Beverage","category":5}]

class GetSegmentListModal {
  GetSegmentListModal({
      num? status, 
      String? message, 
      List<SegmentResult>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetSegmentListModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(SegmentResult.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<SegmentResult>? _result;
GetSegmentListModal copyWith({  num? status,
  String? message,
  List<SegmentResult>? result,
}) => GetSegmentListModal(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<SegmentResult>? get result => _result;

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

/// id : 16
/// name : "Food and Beverage"
/// category : 5

class SegmentResult {
  SegmentResult({
      num? id, 
      String? name, 
      num? category,}){
    _id = id;
    _name = name;
    _category = category;
}

  SegmentResult.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _category = json['category'];
  }
  num? _id;
  String? _name;
  num? _category;
SegmentResult copyWith({  num? id,
  String? name,
  num? category,
}) => SegmentResult(  id: id ?? _id,
  name: name ?? _name,
  category: category ?? _category,
);
  num? get id => _id;
  String? get name => _name;
  num? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['category'] = _category;
    return map;
  }

}