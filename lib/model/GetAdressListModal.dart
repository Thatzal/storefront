/// status : "200"
/// message : "Address List"
/// result : [{"id":5,"name":"home","description_line_1":"11 First & Second Floor\r\nImali Complex Pipal Chowk Khajrana,","description_line_2":"","description_line_3":"","landmark":"khajara ganesh mandir","area":"khajarana","city":"indore","state":"mp","country":"India","pincode":"452001","geolocation":null,"user":4},{"id":6,"name":"Home","description_line_1":"11, floor","description_line_2":null,"description_line_3":null,"landmark":"khajarana","area":"khajarana","city":"indore","state":"mp","country":"india","pincode":"452001","geolocation":"","user":4}]

class GetAdressListModal {
  GetAdressListModal({
      String? status, 
      String? message, 
      List<GetAdressListResult>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetAdressListModal.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(GetAdressListResult.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<GetAdressListResult>? _result;
GetAdressListModal copyWith({  String? status,
  String? message,
  List<GetAdressListResult>? result,
}) => GetAdressListModal(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  List<GetAdressListResult>? get result => _result;

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

/// id : 5
/// name : "home"
/// description_line_1 : "11 First & Second Floor\r\nImali Complex Pipal Chowk Khajrana,"
/// description_line_2 : ""
/// description_line_3 : ""
/// landmark : "khajara ganesh mandir"
/// area : "khajarana"
/// city : "indore"
/// state : "mp"
/// country : "India"
/// pincode : "452001"
/// geolocation : null
/// user : 4

class GetAdressListResult {
  GetAdressListResult({
      num? id, 
      String? name, 
      String? descriptionLine1, 
      String? descriptionLine2, 
      String? descriptionLine3, 
      String? landmark, 
      String? area, 
      String? city, 
      String? state, 
      String? country, 
      String? pincode, 
      dynamic geolocation, 
      num? user,}){
    _id = id;
    _name = name;
    _descriptionLine1 = descriptionLine1;
    _descriptionLine2 = descriptionLine2;
    _descriptionLine3 = descriptionLine3;
    _landmark = landmark;
    _area = area;
    _city = city;
    _state = state;
    _country = country;
    _pincode = pincode;
    _geolocation = geolocation;
    _user = user;
}

  GetAdressListResult.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _descriptionLine1 = json['description_line_1'];
    _descriptionLine2 = json['description_line_2'];
    _descriptionLine3 = json['description_line_3'];
    _landmark = json['landmark'];
    _area = json['area'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _pincode = json['pincode'];
    _geolocation = json['geolocation'];
    _user = json['user'];
  }
  num? _id;
  String? _name;
  String? _descriptionLine1;
  String? _descriptionLine2;
  String? _descriptionLine3;
  String? _landmark;
  String? _area;
  String? _city;
  String? _state;
  String? _country;
  String? _pincode;
  dynamic _geolocation;
  num? _user;
GetAdressListResult copyWith({  num? id,
  String? name,
  String? descriptionLine1,
  String? descriptionLine2,
  String? descriptionLine3,
  String? landmark,
  String? area,
  String? city,
  String? state,
  String? country,
  String? pincode,
  dynamic geolocation,
  num? user,
}) => GetAdressListResult(  id: id ?? _id,
  name: name ?? _name,
  descriptionLine1: descriptionLine1 ?? _descriptionLine1,
  descriptionLine2: descriptionLine2 ?? _descriptionLine2,
  descriptionLine3: descriptionLine3 ?? _descriptionLine3,
  landmark: landmark ?? _landmark,
  area: area ?? _area,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  pincode: pincode ?? _pincode,
  geolocation: geolocation ?? _geolocation,
  user: user ?? _user,
);
  num? get id => _id;
  String? get name => _name;
  String? get descriptionLine1 => _descriptionLine1;
  String? get descriptionLine2 => _descriptionLine2;
  String? get descriptionLine3 => _descriptionLine3;
  String? get landmark => _landmark;
  String? get area => _area;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get pincode => _pincode;
  dynamic get geolocation => _geolocation;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description_line_1'] = _descriptionLine1;
    map['description_line_2'] = _descriptionLine2;
    map['description_line_3'] = _descriptionLine3;
    map['landmark'] = _landmark;
    map['area'] = _area;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['pincode'] = _pincode;
    map['geolocation'] = _geolocation;
    map['user'] = _user;
    return map;
  }

}