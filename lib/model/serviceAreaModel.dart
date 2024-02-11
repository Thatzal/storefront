/// Address : "ghfghfghhghbn gfhh ghdfhdfh "

class ServiceAreaModel {
  ServiceAreaModel({
      String? address,}){
    _address = address;
}

  ServiceAreaModel.fromJson(dynamic json) {
    _address = json['Address'];
  }
  String? _address;
ServiceAreaModel copyWith({  String? address,
}) => ServiceAreaModel(  address: address ?? _address,
);
  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Address'] = _address;
    return map;
  }

}