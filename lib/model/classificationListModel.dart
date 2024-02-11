/// id : 1
/// type_of : "business"
/// name : "Software development"

class ClassificationListModel {
  ClassificationListModel({
      num? id, 
      String? typeOf, 
      String? name,}){
    _id = id;
    _typeOf = typeOf;
    _name = name;
}

  ClassificationListModel.fromJson(dynamic json) {
    _id = json['id'];
    _typeOf = json['type_of'];
    _name = json['name'];
  }
  num? _id;
  String? _typeOf;
  String? _name;
ClassificationListModel copyWith({  num? id,
  String? typeOf,
  String? name,
}) => ClassificationListModel(  id: id ?? _id,
  typeOf: typeOf ?? _typeOf,
  name: name ?? _name,
);
  num? get id => _id;
  String? get typeOf => _typeOf;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type_of'] = _typeOf;
    map['name'] = _name;
    return map;
  }

}