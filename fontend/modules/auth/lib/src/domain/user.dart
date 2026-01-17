class User {
  final String id;
  final String username;
  final String? email;
  final List<String> roles;
  final String token;
  final String? type; // e.g., Bearer
  final String? lastLogin;
  final int? tokenExpiryMillis; // epoch millis when token expires

  const User({
    required this.id,
    required this.username,
    required this.token,
    this.email,
    this.roles = const [],
    this.type,
    this.lastLogin,
    this.tokenExpiryMillis,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    List<String>? roles,
    String? token,
    String? type,
    String? lastLogin,
    int? tokenExpiryMillis,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      token: token ?? this.token,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      type: type ?? this.type,
      lastLogin: lastLogin ?? this.lastLogin,
      tokenExpiryMillis: tokenExpiryMillis ?? this.tokenExpiryMillis,
    );
  }
}
