import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialapps/Apis/urls.dart';
import 'package:socialapps/constant/constatnt.dart';


class ThatZalApis{

  static Future<dynamic> getOfferData({Endpoint}) async {
    final client = http.Client();
    http.Response ?response ;
    try {
      response = await client.get(Uri.parse("$Endpoint"),
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(utf8.decode(response!.bodyBytes));

    if (response.statusCode == 200) {
      return responseBody;
    }else{
      Constants.showToast(responseBody["message"]);
      return ;
    }
  }

  static Future<dynamic> fromDataPost({Endpoint,BodyParam}) async {
    final client = http.Client();
    http.Response ?response ;
    try {
      response = await client.post(Uri.parse("$Endpoint"),
        body:BodyParam,
      );
    } catch(e){
      print(e);
    }
    Map<String, dynamic> responseBody = json.decode(utf8.decode(response!.bodyBytes));

    if (response.statusCode == 200) {
      return responseBody;
    }else{
      Constants.showToast(responseBody["message"]);
      return ;
    }
  }

  static Future UploadFile({file}) async {
    var request = http.MultipartRequest('POST', Uri.parse("${ApiUrls.uploadFile}"));
    file==null?null: request.files.add(await http.MultipartFile.fromPath("file",file));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    try{
      var model ;
      if(response.statusCode==200){
        model=  jsonDecode(res.body);
        return model;
      }else{
         return model;
      }
    }catch(e){
      print(e.hashCode);
    }
  }

  static Future UploadFileAssets({file}) async {
    var request = http.MultipartRequest('POST', Uri.parse("${ApiUrls.uploadFile}"));
    file==null?null: request.files.add(await http.MultipartFile.fromBytes("file",file));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);
    try{
      var model ;
      if(response.statusCode==200){
        model=  jsonDecode(res.body);
        return model;
      }else{
        return model;
      }
    }catch(e){
      print(e.hashCode);
    }
  }






}