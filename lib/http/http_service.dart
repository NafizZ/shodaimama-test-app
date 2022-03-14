import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  final String _dataURL = "https://picsum.photos/v2/list?";

  Future<List> getData(int pageNumber) async {
    Response res = await get(Uri.parse("${_dataURL}page=$pageNumber&limit=20"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve images.";
    }
  }
}