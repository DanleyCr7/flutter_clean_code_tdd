import 'package:flutter_tdd/domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;
  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) =>
      RemoteAccountModel(json['access_token']);

  AccountEntidy toEntidy() => AccountEntidy(accessToken);
}
