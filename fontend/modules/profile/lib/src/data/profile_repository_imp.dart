import 'package:core/core.dart';
import 'package:auth/auth.dart';
import '../domain/profile_repository.dart';
import 'bean/profile_request_object/get_profile_request.dart';
import 'bean/profile_response_object/get_profile_response.dart';
import 'bean/profile_request_object/update_profile_request.dart';
import 'bean/profile_response_object/update_profile_response.dart';

class ProfileRepositoryImp implements ProfileRepository {
  Profile? _cached;

  @override
  Future<Profile?> getCurrentProfile() async {
    // Return cached if available
    if (_cached != null) return _cached;

    // Attempt to fetch from server if logged in
    final auth = GetIt.instance.get<AuthenticationRepository>();
    if (auth.currentUser == null) {
      return _cached; // stay null when not authenticated
    }

    final result = await NetworkExecutor.executed<GetProfileResponse, GetProfileResponse>(
      route: GetProfileRequest(),
      responseType: GetProfileResponse(),
    );

    return await result.map(
      success: (s) async {
        final res = s.data;
        final data = res.response;
        if (data == null) return _cached; // keep existing/null
        final profile = Profile(
          id: data.id ?? auth.currentUser!.id,
          username: data.username ?? auth.currentUser!.username,
          email: data.email ?? auth.currentUser!.email,
          avatarUrl: data.avatarUrl,
          phoneNumber: data.phoneNumber,
        );
        _cached = profile;
        return _cached;
      },
      failure: (f) async {
        // Keep previous cached (if any) on error
        return _cached;
      },
    );
  }

  @override
  Future<Profile> updateProfile({String? username, String? email, String? avatarUrl}) async {
    final auth = GetIt.instance.get<AuthenticationRepository>();
    final current = _cached ?? Profile(
      id: auth.currentUser?.id ?? 'local',
      username: auth.currentUser?.username ?? '',
      email: auth.currentUser?.email,
    );

    // Build request body merging provided fields with current values
    final req = UpdateProfileRequest(
      id: current.id,
      username: username ?? current.username,
      email: email ?? current.email,
      avatarUrl: avatarUrl ?? current.avatarUrl,
    );

    final result = await NetworkExecutor.executed<UpdateProfileResponse, UpdateProfileResponse>(
      route: req,
      responseType: UpdateProfileResponse(),
    );

    return await result.when(
      success: (res) async {
        final data = res.response;
        // If server doesn't return payload, fallback to local merged values
        final updated = Profile(
          id: data?.id ?? current.id,
          username: data?.username ?? (username ?? current.username),
          email: data?.email ?? (email ?? current.email),
          avatarUrl: data?.avatarUrl ?? (avatarUrl ?? current.avatarUrl),
          phoneNumber: current.phoneNumber,
        );
        _cached = updated;
        return updated;
      },
      failure: (error) async {
        // Surface error to caller for UI to handle
        throw Exception(error.localizedErrorMessage ?? 'Update profile failed');
      },
    );
  }
}
