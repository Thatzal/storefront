/// name : "Khajrana Main Road"
/// icon : "Khajrana Main Rd"
/// FormattedAddress : "dfgdfgfh"

class AddressModel {
  AddressModel({
      String? name, 
      String? icon, 
      String? formattedAddress,
      String ? lat,
      String ? long,

  }){
    _name = name;
    _icon = icon;
    _formattedAddress = formattedAddress;
    _lat = lat;
    _long = long;
}

  AddressModel.fromJson(dynamic json) {
    _name = json['name'];
    _icon = json['icon'];
    _formattedAddress = json['vicinity'];
    _lat = json["lat"];
    _long = json["long"];
  }
  String? _name;
  String? _icon;
  String? _formattedAddress;
  String? _lat;
  String? _long;
AddressModel copyWith({
  String? name,
  String? icon,
  String? formattedAddress,
  String ?lat,
  String ? long,
}) => AddressModel(
  name: name ?? _name,
  icon: icon ?? _icon,
  formattedAddress: formattedAddress ?? _formattedAddress,
  lat: lat ?? _lat,
  long: long?? _long
);
  String? get name => _name;
  String? get icon => _icon;
  String? get formattedAddress => _formattedAddress;
  String ? get lat => _lat;
  String ? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['icon'] = _icon;
    map['vicinity'] = _formattedAddress;
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }

}