import 'package:core/libs.dart';
import '../../domain/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onLoadRequested);
    on<ProfileUpdateRequested>(_onUpdateRequested);
    on<ProfileAvatarUpdateRequested>(_onAvatarUpdateRequested);
  }

  final ProfileRepository _profileRepository;

  Future<void> _onLoadRequested(
      ProfileLoadRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadInProgress());
    try {
      final p = await _profileRepository.getCurrentProfile();
      // If null (not loaded yet), create a default shell profile to show in UI.
      final profile = p ?? const Profile(id: 'local', username: '');
      emit(ProfileLoadSuccess(profile));
    } catch (e) {
      emit(const ProfileUpdateFailure('Failed to load profile'));
    }
  }

  Future<void> _onUpdateRequested(
      ProfileUpdateRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateInProgress());
    try {
      final updated = await _profileRepository.updateProfile(
        username: event.username,
        email: event.email,
      );
      // TODO: When integrating real API, map status/message from response
      emit(ProfileUpdateSuccess(updated, status: 'success', message: 'Cập nhật hồ sơ thành công'));
      // Also reflect as loaded state for UI continuity
      emit(ProfileLoadSuccess(updated));
    } catch (e) {
      emit(const ProfileUpdateFailure('Failed to update profile'));
    }
  }

  Future<void> _onAvatarUpdateRequested(ProfileAvatarUpdateRequested event,
      Emitter<ProfileState> emit) async {
    emit(ProfileUpdateInProgress());
    try {
      final updated = await _profileRepository.updateProfile(
        avatarUrl: event.avatarUrl,
      );
      emit(ProfileUpdateSuccess(updated, status: 'success', message: 'Cập nhật avatar thành công'));
      emit(ProfileLoadSuccess(updated));
    } catch (e) {
      emit(const ProfileUpdateFailure('Failed to update avatar'));
    }
  }
}
