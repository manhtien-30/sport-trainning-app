import 'package:core/libs.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileUpdateRequested extends ProfileEvent {
  const ProfileUpdateRequested({this.username, this.email});
  final String? username;
  final String? email;
  @override
  List<Object?> get props => [username, email];
}

class ProfileAvatarUpdateRequested extends ProfileEvent {
  const ProfileAvatarUpdateRequested(this.avatarUrl);
  final String avatarUrl;
  @override
  List<Object?> get props => [avatarUrl];
}