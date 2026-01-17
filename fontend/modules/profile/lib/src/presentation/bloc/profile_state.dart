import 'package:core/libs.dart';
import '../../domain/profile_repository.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  const ProfileLoadSuccess(this.profile);
  final Profile profile;
  @override
  List<Object?> get props => [profile];
}

class ProfileUpdateInProgress extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess(this.profile, {this.status, this.message});
  final Profile profile;
  final String? status;
  final String? message;
  @override
  List<Object?> get props => [profile, status, message];
}

class ProfileUpdateFailure extends ProfileState {
  const ProfileUpdateFailure([this.message]);
  final String? message;
  @override
  List<Object?> get props => [message];
}