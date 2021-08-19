import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant {
  ///gets the json decoded data
  static Future<dynamic> getRequest(String apiUrl) async {
    http.Response _response = await http.get(Uri.parse(apiUrl));
    try {
      if (_response.statusCode == 200) {
        String _jsonResponseData = _response.body;
        var _decodedData=jsonDecode(_jsonResponseData);
        return _decodedData;
      }
      else
        {
          return "Failed";
        }
    } on Exception catch (e) {
      print( "Failed, No Response: $e");
      return "Failed";
    }
  }
}
