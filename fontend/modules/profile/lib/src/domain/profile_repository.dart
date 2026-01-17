class Profile {
  final String id;
  final String username;
  final String? email;
  final String? avatarUrl;
  final String? phoneNumber;

  const Profile({required this.id, required this.username, this.email, this.avatarUrl, this.phoneNumber});

  Profile copyWith({String? username, String? email, String? avatarUrl, String? phoneNumber}) =>
      Profile(
        id: id,
        username: username ?? this.username,
        email: email ?? this.email,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );
}

abstract class ProfileRepository {
  Future<Profile?> getCurrentProfile();
  Future<Profile> updateProfile({String? username, String? email, String? avatarUrl});

}
