import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:collector/data/persistence/access_user_credentials.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_cubit_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(const UserProfileState());

  Future<void> loadUser() async {
    final user = await AccessUserCredentials().readUserProfile();
    final idToken = await AccessUserCredentials().readUserCredentialsIdToken();
    emit(
      state.copyWith(
        user: user,
        idToken: idToken,
      ),
    );
  }
}
