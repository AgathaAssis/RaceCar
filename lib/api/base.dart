import 'package:http/http.dart' as http;

class BaseApi {
  static String url = "http://localhost:3030";
  static Future<bool> testConnection() async {  
    final res = await http.get(Uri.parse("$url/test"));
    if(res.statusCode == 200) {
      return true;
    }
    else {  
      return false;
    }
  }
}
