part of 'user_profile_cubit_cubit.dart';

class UserProfileState extends Equatable {
  const UserProfileState({this.user, this.idToken});

  final UserProfile? user;
  final String? idToken;

  UserProfileState copyWith({UserProfile? user, String? idToken}) =>
      UserProfileState(user: user ?? this.user, idToken: idToken ?? this.idToken);

  @override
  List<dynamic> get props => [user, idToken];
}
