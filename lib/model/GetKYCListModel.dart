/// status : 200
/// message : "KYC List"
/// result : [{"id":4,"phone_number_otp":"9630705280","kyc_name":"Pan Card","kyc_id":"GHXGJ966G","kyc_image_front":"/media/kyc_doc/Fortune-Sunlite-Refined-Sunflower-Oil-300x300.jpg","kyc_image_back":"/media/kyc_doc/fortune_rice.jpg","user":4}]

class GetKycListModel {
  GetKycListModel({
      num? status, 
      String? message, 
      List<KYCDocData>? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  GetKycListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(KYCDocData.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<KYCDocData>? _result;
GetKycListModel copyWith({  num? status,
  String? message,
  List<KYCDocData>? result,
}) => GetKycListModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  num? get status => _status;
  String? get message => _message;
  List<KYCDocData>? get result => _result;

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
/// phone_number_otp : "9630705280"
/// kyc_name : "Pan Card"
/// kyc_id : "GHXGJ966G"
/// kyc_image_front : "/media/kyc_doc/Fortune-Sunlite-Refined-Sunflower-Oil-300x300.jpg"
/// kyc_image_back : "/media/kyc_doc/fortune_rice.jpg"
/// user : 4

class KYCDocData {
  KYCDocData({
      num? id, 
      String? phoneNumberOtp, 
      String? kycName, 
      String? kycId, 
      String? kycImageFront, 
      String? kycImageBack, 
      num? user,}){
    _id = id;
    _phoneNumberOtp = phoneNumberOtp;
    _kycName = kycName;
    _kycId = kycId;
    _kycImageFront = kycImageFront;
    _kycImageBack = kycImageBack;
    _user = user;
}

  KYCDocData.fromJson(dynamic json) {
    _id = json['id'];
    _phoneNumberOtp = json['phone_number_otp'];
    _kycName = json['kyc_name'];
    _kycId = json['kyc_id'];
    _kycImageFront = json['kyc_image_front'];
    _kycImageBack = json['kyc_image_back'];
    _user = json['user'];
  }
  num? _id;
  String? _phoneNumberOtp;
  String? _kycName;
  String? _kycId;
  String? _kycImageFront;
  String? _kycImageBack;
  num? _user;
KYCDocData copyWith({  num? id,
  String? phoneNumberOtp,
  String? kycName,
  String? kycId,
  String? kycImageFront,
  String? kycImageBack,
  num? user,
}) => KYCDocData(  id: id ?? _id,
  phoneNumberOtp: phoneNumberOtp ?? _phoneNumberOtp,
  kycName: kycName ?? _kycName,
  kycId: kycId ?? _kycId,
  kycImageFront: kycImageFront ?? _kycImageFront,
  kycImageBack: kycImageBack ?? _kycImageBack,
  user: user ?? _user,
);
  num? get id => _id;
  String? get phoneNumberOtp => _phoneNumberOtp;
  String? get kycName => _kycName;
  String? get kycId => _kycId;
  String? get kycImageFront => _kycImageFront;
  String? get kycImageBack => _kycImageBack;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone_number_otp'] = _phoneNumberOtp;
    map['kyc_name'] = _kycName;
    map['kyc_id'] = _kycId;
    map['kyc_image_front'] = _kycImageFront;
    map['kyc_image_back'] = _kycImageBack;
    map['user'] = _user;
    return map;
  }

}