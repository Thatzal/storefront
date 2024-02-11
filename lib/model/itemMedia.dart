/// id : "c628929b-0b32-4c4b-9987-829e85ebbcf8"
/// file : "https://drawaura-bucket.s3.amazonaws.com/media/files/image_cropper_1702377005389.jpg"
/// name : "image_cropper_1702377005389.jpg"

class ItemMedia {
  ItemMedia({
    String? id,
    String? file,
    String? name,}){
    _id = id;
    _file = file;
    _name = name;
  }

  ItemMedia.fromJson(dynamic json) {
    _id = json['id'];
    _file = json['file'];
    _name = json['name'];
  }
  String? _id;
  String? _file;
  String? _name;
  ItemMedia copyWith({  String? id,
    String? file,
    String? name,
  }) => ItemMedia(  id: id ?? _id,
    file: file ?? _file,
    name: name ?? _name,
  );
  String? get id => _id;
  String? get file => _file;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['file'] = _file;
    map['name'] = _name;
    return map;
  }

}