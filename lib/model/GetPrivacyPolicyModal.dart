

class GetPrivacyPolicyModal {
  GetPrivacyPolicyModal({
      num? id, 
      String? name, 
      String? content,}){
    _id = id;
    _name = name;
    _content = content;
}

  GetPrivacyPolicyModal.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _content = json['content'];
  }
  num? _id;
  String? _name;
  String? _content;
GetPrivacyPolicyModal copyWith({  num? id,
  String? name,
  String? content,
}) => GetPrivacyPolicyModal(  id: id ?? _id,
  name: name ?? _name,
  content: content ?? _content,
);
  num? get id => _id;
  String? get name => _name;
  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['content'] = _content;
    return map;
  }

}