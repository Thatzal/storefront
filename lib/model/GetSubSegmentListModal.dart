/// status : 200
/// message : "Sub Segment List"
/// result : [{"id":1,"name":"Painting","segment":1},{"id":2,"name":"Sculpture","segment":1},{"id":3,"name":"Animation","segment":1},{"id":4,"name":"Dance","segment":1}]

class GetSubSegmentListModal {
  GetSubSegmentListModal({
      num? status, 
      String? message, 
      List<SubSegmentResult>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetSubSegmentListModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(SubSegmentResult.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<SubSegmentResult>? _result;
GetSubSegmentListModal copyWith({  num? status,
  String? message,
  List<SubSegmentResult>? result,
}) => GetSubSegmentListModal(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<SubSegmentResult>? get result => _result;

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
/// name : "Painting"
/// segment : 1

class SubSegmentResult {
  SubSegmentResult({
      num? id, 
      String? name, 
      num? segment,}){
    _id = id;
    _name = name;
    _segment = segment;
}

  SubSegmentResult.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _segment = json['segment'];
  }
  num? _id;
  String? _name;
  num? _segment;
SubSegmentResult copyWith({  num? id,
  String? name,
  num? segment,
}) => SubSegmentResult(  id: id ?? _id,
  name: name ?? _name,
  segment: segment ?? _segment,
);
  num? get id => _id;
  String? get name => _name;
  num? get segment => _segment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['segment'] = _segment;
    return map;
  }

}