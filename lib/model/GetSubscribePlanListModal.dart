/// status : 200
/// message : "Subscription Plan List"
/// result : [{"id":1,"type":"MONTHLY","title":"Monthly Subscription","sub_title":"Renewable every month","desc":"Full access rights with order postings as well as new business pages creation and also countering all existing orders with your answers and counter offers and more! Create more pages accommodating your diverse business needs in one App to start rolling out your products!","image":"/media/plans/pana.png","price":"99.00","duration":1,"created_at":"06-05-2023 11:50","modified":"08-05-2023 10:51"},{"id":2,"type":"YEARLY","title":"Annual Subscription","sub_title":"Renewable every year.","desc":"Full access rights with order postings as well as new business pages creation and also countering all existing orders with your answers and counter offers and more! Create more pages accommodating your diverse business needs in one App to start rolling out your products!","image":"/media/plans/pana_wJeyJmo.png","price":"999.00","duration":365,"created_at":"06-05-2023 11:52","modified":"08-05-2023 10:45"},{"id":3,"type":"FREE","title":"Free For Now","sub_title":"Free subscription for 30 Days!","desc":"As a buyer/consumer,counter any order posted with your queries and counter offers and buy / avail as much products and services as possible.","image":"/media/plans/pana_42vFGFR.png","price":"0.00","duration":28,"created_at":"06-05-2023 12:00","modified":"08-05-2023 10:41"},{"id":4,"type":"MONTHLY","title":"Half Yearly","sub_title":"Renewable every  6 month.","desc":"Full access rights with order postings as well as new business pages creation and also countering all existing orders with your answers and counter offers and more! Create more pages accommodating your diverse business needs in one App to start rolling out your products!","image":"/media/plans/pana_BI7vRna.png","price":"599.00","duration":6,"created_at":"06-05-2023 13:49","modified":"08-05-2023 10:50"}]

class GetSubscribePlanListApi {
  GetSubscribePlanListApi({
      num? status, 
      String? message, 
      List<SubcriptionResult>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetSubscribePlanListApi.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(SubcriptionResult.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<SubcriptionResult>? _result;
GetSubscribePlanListApi copyWith({  num? status,
  String? message,
  List<SubcriptionResult>? result,
}) => GetSubscribePlanListApi(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<SubcriptionResult>? get result => _result;

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
/// type : "MONTHLY"
/// title : "Monthly Subscription"
/// sub_title : "Renewable every month"
/// desc : "Full access rights with order postings as well as new business pages creation and also countering all existing orders with your answers and counter offers and more! Create more pages accommodating your diverse business needs in one App to start rolling out your products!"
/// image : "/media/plans/pana.png"
/// price : "99.00"
/// duration : 1
/// created_at : "06-05-2023 11:50"
/// modified : "08-05-2023 10:51"

class SubcriptionResult {
  SubcriptionResult({
      num? id, 
      String? type, 
      String? title, 
      String? subTitle, 
      String? desc, 
      String? image, 
      String? price, 
      num? duration, 
      String? createdAt, 
      String? modified,}){
    _id = id;
    _type = type;
    _title = title;
    _subTitle = subTitle;
    _desc = desc;
    _image = image;
    _price = price;
    _duration = duration;
    _createdAt = createdAt;
    _modified = modified;
}

  SubcriptionResult.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _title = json['title'];
    _subTitle = json['sub_title'];
    _desc = json['desc'];
    _image = json['image'];
    _price = json['price'];
    _duration = json['duration'];
    _createdAt = json['created_at'];
    _modified = json['modified'];
  }
  num? _id;
  String? _type;
  String? _title;
  String? _subTitle;
  String? _desc;
  String? _image;
  String? _price;
  num? _duration;
  String? _createdAt;
  String? _modified;
SubcriptionResult copyWith({  num? id,
  String? type,
  String? title,
  String? subTitle,
  String? desc,
  String? image,
  String? price,
  num? duration,
  String? createdAt,
  String? modified,
}) => SubcriptionResult(  id: id ?? _id,
  type: type ?? _type,
  title: title ?? _title,
  subTitle: subTitle ?? _subTitle,
  desc: desc ?? _desc,
  image: image ?? _image,
  price: price ?? _price,
  duration: duration ?? _duration,
  createdAt: createdAt ?? _createdAt,
  modified: modified ?? _modified,
);
  num? get id => _id;
  String? get type => _type;
  String? get title => _title;
  String? get subTitle => _subTitle;
  String? get desc => _desc;
  String? get image => _image;
  String? get price => _price;
  num? get duration => _duration;
  String? get createdAt => _createdAt;
  String? get modified => _modified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['title'] = _title;
    map['sub_title'] = _subTitle;
    map['desc'] = _desc;
    map['image'] = _image;
    map['price'] = _price;
    map['duration'] = _duration;
    map['created_at'] = _createdAt;
    map['modified'] = _modified;
    return map;
  }

}