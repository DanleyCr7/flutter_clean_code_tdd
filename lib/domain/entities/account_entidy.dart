class AccountEntidy {
  final String token;
  AccountEntidy(this.token);

  factory AccountEntidy.fromJson(Map json) =>
      AccountEntidy(json['access_token']);
}
