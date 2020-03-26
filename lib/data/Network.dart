import 'package:http/http.dart' as http;

class Network {
  static http.Client client;

  static getHttpClient() {
    if (client == null) {
      client = new http.Client();
    }
    return client;
  }

}