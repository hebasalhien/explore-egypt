import 'package:explore_egypt/core/constants/storage_constants.dart';
import 'package:explore_egypt/core/local_db/hive_service.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/core/user/local/user_model_hive.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final HiveService _hiveService;
  late UserRepository _userRepository;

  SessionCubit(this._hiveService) : super(SessionCubitInitial());

  void setUserRepository(UserRepository repo) {
    _userRepository = repo;
  }

  Future<void> startSession(Map<String, dynamic> data) async {
    final token = data[StorageConstants.userToken];
    await SharedPrefHelper.setSecureString(StorageConstants.userToken, token);
    // fetch user after login
    final user = await _userRepository.getUserData();
    // cache user
    await _hiveService.saveUser(
      UserModelHive()
        ..username = user.name
        ..imageUrl = user.imageURL ?? '',
    );
    emit(SessionAuthenticated(token, user.name, user.imageURL));
  }

  Future<void> restoreSession() async {
        final seen = await SharedPrefHelper.getBool(StorageConstants.seenOnboarding) ?? false;
    if (!seen) {
      emit(SessionNeedsOnboarding());
      return;
    }
    try {
      final token = await SharedPrefHelper.getSecuredString('accessToken');
      if (token == null) {
        emit(SessionUnauthenticated());
        return;
      }

      // validate token + get fresh data
      final user = await _userRepository.getUserData();

      emit(SessionAuthenticated(token, user.name, user.imageURL));
    } catch (e) {
      // token invalid or API failed → try cache
      final cached = await _hiveService.getUser();
      if (cached != null) {
        final token = await SharedPrefHelper.getSecuredString('accessToken');
        emit(SessionAuthenticated(token!, cached.username, cached.imageUrl));
      } else {
        await endSession();
      }
    }
  }

  Future<void> updateUser({String? username, String? imageUrl}) async {
    final current = state;
    if (current is! SessionAuthenticated) return;

    final newUsername = username ?? current.username;
    final newImageUrl = imageUrl ?? current.imageUrl;

    // update cache
    await _hiveService.saveUser(
      UserModelHive()
        ..username = newUsername
        ..imageUrl = newImageUrl ?? '',
    );

    emit(SessionAuthenticated(current.token, newUsername, newImageUrl));
  }

  Future<void> endSession() async {
    try {
      await SharedPrefHelper.removeSecureData(StorageConstants.userToken);
      await ApiService.instance.cookieJar.deleteAll();
      await _hiveService.clearUser();
      await _hiveService.clearAllTrips();
      debugPrint('session ended, local data cleared');
      emit(SessionUnauthenticated());
    } catch (e) {
      throw ('An unexpected error occurred $e');
    }
  }

  Future<void> completeOnboarding() async {
  await SharedPrefHelper.setData(StorageConstants.seenOnboarding  , true);
  emit(SessionUnauthenticated()); // proceed to login
}
}
