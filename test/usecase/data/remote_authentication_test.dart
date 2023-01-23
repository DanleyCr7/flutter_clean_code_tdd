import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';

//domain
import 'package:flutter_tdd/domain/usecases/authentication.dart';

// data layer
import 'package:flutter_tdd/data/http/http.dart';
import 'package:flutter_tdd/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct URL', () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());

    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

  test('Should call HttpClient with correct Method', () async {
    await sut.token();

    verify(httpClient.request(url: url, method: 'get'));
  });
}