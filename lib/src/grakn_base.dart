library grakn_base;

import "dart:async";
import "dart:io";
import "dart:convert";
import "package:logging/logging.dart" as logging;


const String DEFAULT_HOST = 'localhost';
const int DEFAULT_PORT = 4567;
const String DEFAULT_KEYSPACE = 'grakn';

class Grakn {
  static logging.Logger _log = new logging.Logger("grakn");

  String host;
  int port;
  String keyspace;

  Map defaultParams = {
    'infer': "true",
    'materialise': "false",
    'defineAllVars': "false",
    'loading': "false",
    'txType': 'WRITE'
  };

  Grakn(
      {this.host = DEFAULT_HOST,
        this.port = DEFAULT_PORT,
        this.keyspace = DEFAULT_KEYSPACE});

  String get queryEndpoint {
    return "/kb/${this.keyspace}/graql";
  }

  Future<String> execute(String query, [Map params]) async {
    try {
      HttpClient client = new HttpClient();

      Map finalParams = new Map.from(defaultParams);
      if(params != null){
        finalParams.addAll(params);
      }


      Uri uri = new Uri(
          scheme: "http",
          host: this.host,
          port: this.port,
          path: this.queryEndpoint,
          queryParameters: finalParams);
      HttpClientRequest request = await client.postUrl(uri);
      request.headers.set("Accept", "application/graql+json");
      request.write(query);
      HttpClientResponse response = await request.close();
      String result = "";
      await for(String part in response.transform(LATIN1.decoder)){
        result += part;
      }
      return result;
    } catch (e, s) {
      _log.warning(e);
      _log.warning(s);
      return null;
    }
  }
}
