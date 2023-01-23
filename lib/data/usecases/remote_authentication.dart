import '../../domain/usecases/authentication.dart';

import '../http/http.dart';

class RemoteAuthentication {
  HttpClient httpClient;
  String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    await httpClient.request(url: url, method: 'post', body: params.toJson());
  }

  Future<void> token() async {
    await httpClient.request(url: url, method: 'get');
  }
}
