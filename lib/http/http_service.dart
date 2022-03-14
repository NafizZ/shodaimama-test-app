import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  final String dataURL = "https://picsum.photos/v2/list?page=pageNumber&limit=20";

  Future<List> getData() async {
    Response res = await get(Uri.parse(dataURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve images.";
    }
  }
}