import 'package:http/http.dart' as http;

class Network {
  static final Network _singleton = Network._internal();

  static http.Client client;

  factory Network() {
    return _singleton;
  }

  Network._internal();

  getHttpClient() {
    if (client == null) {
      client = new http.Client();
    }
    return client;
  }

}