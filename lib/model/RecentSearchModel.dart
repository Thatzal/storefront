/// status : "200"
/// message : "Recent Searches"
/// result : [{"id":1,"search_text":"alert","history_timestamp":"29-07-2023 10:27","subscriber":2},{"id":2,"search_text":"grocery","history_timestamp":"29-07-2023 10:27","subscriber":2},{"id":7,"search_text":"g","history_timestamp":"29-07-2023 11:00","subscriber":2},{"id":8,"search_text":"gi","history_timestamp":"29-07-2023 11:00","subscriber":2},{"id":9,"search_text":"gir","history_timestamp":"29-07-2023 11:00","subscriber":2}]

class RecentSearchModel {
  RecentSearchModel({
      String? status, 
      String? message, 
      List<RecentSearchData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  RecentSearchModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(RecentSearchData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<RecentSearchData>? _result;
RecentSearchModel copyWith({  String? status,
  String? message,
  List<RecentSearchData>? result,
}) => RecentSearchModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  List<RecentSearchData>? get result => _result;

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
/// search_text : "alert"
/// history_timestamp : "29-07-2023 10:27"
/// subscriber : 2

class RecentSearchData {
  RecentSearchData({
      num? id, 
      String? searchText, 
      String? historyTimestamp, 
      num? subscriber,}){
    _id = id;
    _searchText = searchText;
    _historyTimestamp = historyTimestamp;
    _subscriber = subscriber;
}

  RecentSearchData.fromJson(dynamic json) {
    _id = json['id'];
    _searchText = json['search_text'];
    _historyTimestamp = json['history_timestamp'];
    _subscriber = json['subscriber'];
  }
  num? _id;
  String? _searchText;
  String? _historyTimestamp;
  num? _subscriber;
RecentSearchData copyWith({  num? id,
  String? searchText,
  String? historyTimestamp,
  num? subscriber,
}) => RecentSearchData(  id: id ?? _id,
  searchText: searchText ?? _searchText,
  historyTimestamp: historyTimestamp ?? _historyTimestamp,
  subscriber: subscriber ?? _subscriber,
);
  num? get id => _id;
  String? get searchText => _searchText;
  String? get historyTimestamp => _historyTimestamp;
  num? get subscriber => _subscriber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['search_text'] = _searchText;
    map['history_timestamp'] = _historyTimestamp;
    map['subscriber'] = _subscriber;
    return map;
  }

}