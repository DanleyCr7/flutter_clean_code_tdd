import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

import '../http/http.dart';
import '../models/models.dart';

class RemoteAuthentication implements Authentication {
  HttpClient httpClient;
  String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<AccountEntidy> auth(AuthenticationParams params) async {
    try {
      final httpResponse = await httpClient.request(
          url: url,
          method: 'post',
          body: RemoteAuthenticationParams.fromDomain(params).toJson());
      return RemoteAccountModel.fromJson(httpResponse ?? {}).toEntidy();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredential
          : DomainError.unexpected;
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
