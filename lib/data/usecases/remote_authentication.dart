import '../../domain/usecases/authentication.dart';
import '../../domain/helpers/helpers.dart';

import '../http/http.dart';

class RemoteAuthentication {
  HttpClient httpClient;
  String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    try {
      await httpClient.request(
          url: url,
          method: 'post',
          body: RemoteAuthenticationParams.fromDomain(params).toJson());
    } on HttpError {
      throw DomainError.unexpected;
    }
  }

  Future<void> token() async {
    await httpClient.request(url: url, method: 'get');
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
