import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:collector/secure_storage.dart';

const userCredentialsKeyPrefix = 'user_credentials_';
const userCredentialsUserProfileKeyPrefix =
    '${userCredentialsKeyPrefix}userprofile_';

enum UserCredentialsKeys {
  idToken('${userCredentialsKeyPrefix}idToken'),
  accessToken('${userCredentialsKeyPrefix}accessToken'),
  expiresAt('${userCredentialsKeyPrefix}expiresAt'),
  tokenType('${userCredentialsKeyPrefix}tokenType'),
  userProfileSub('${userCredentialsUserProfileKeyPrefix}sub'),
  userProfileName('${userCredentialsUserProfileKeyPrefix}name'),
  userProfileEmail('${userCredentialsUserProfileKeyPrefix}email'),
  userProfilePicture('${userCredentialsUserProfileKeyPrefix}picture');

  final String key;
  const UserCredentialsKeys(this.key);
}

/// AccessUserCredentials is defined as Singleton.
/// Access (read and write) user credentials in SecretStore.
class AccessUserCredentials {
  static final AccessUserCredentials _instance =
      AccessUserCredentials._internal();
  factory AccessUserCredentials() => _instance;

  AccessUserCredentials._internal();

  void writeUserCredentials(Credentials credentials) {
    SecureStorage().write(UserCredentialsKeys.idToken.key, credentials.idToken);
    SecureStorage()
        .write(UserCredentialsKeys.accessToken.key, credentials.accessToken);
    SecureStorage().write(UserCredentialsKeys.expiresAt.key,
        credentials.expiresAt.toIso8601String());
    SecureStorage()
        .write(UserCredentialsKeys.tokenType.key, credentials.tokenType);
    SecureStorage()
        .write(UserCredentialsKeys.userProfileSub.key, credentials.user.sub);
    SecureStorage()
        .write(UserCredentialsKeys.userProfileName.key, credentials.user.name ?? '');
    SecureStorage()
        .write(UserCredentialsKeys.userProfileEmail.key, credentials.user.email ?? '');
    SecureStorage().write(
        UserCredentialsKeys.userProfilePicture.key, credentials.user.pictureUrl.toString());
  }

  Future<Credentials> readUserCredentials() async {
    List<String> credentialKeys = [
      UserCredentialsKeys.idToken.key,
      UserCredentialsKeys.accessToken.key,
      UserCredentialsKeys.expiresAt.key,
      UserCredentialsKeys.tokenType.key,
    ];

    UserProfile user = await readUserProfile();

    return await SecureStorage().readKeys(credentialKeys).then(
          (keyValueMap) => Credentials(
            idToken: keyValueMap[UserCredentialsKeys.idToken.key] ?? '',
            accessToken: keyValueMap[UserCredentialsKeys.accessToken.key] ?? '',
            expiresAt: DateTime.parse(keyValueMap[UserCredentialsKeys.expiresAt.key] ?? ''),
            tokenType: keyValueMap[UserCredentialsKeys.tokenType.key] ?? '',
            user: user,
            ),
          );
  }

  Future<UserProfile> readUserProfile() async {
    List<String> userProfileKeys = [
      UserCredentialsKeys.userProfileSub.key,
      UserCredentialsKeys.userProfileName.key,
      UserCredentialsKeys.userProfileEmail.key,
      UserCredentialsKeys.userProfilePicture.key,
    ];

    return await SecureStorage().readKeys(userProfileKeys).then(
          (keyValueMap) => UserProfile(
            sub: keyValueMap[UserCredentialsKeys.userProfileSub.key] ?? '',
            name: keyValueMap[UserCredentialsKeys.userProfileName.key],
            email: keyValueMap[UserCredentialsKeys.userProfileEmail.key],
            profileUrl: Uri.parse(
              keyValueMap[UserCredentialsKeys.userProfilePicture.key] as String,
            ),
          ),
        );
  }

  Future<String?> readUserCredentialsIdToken() async {
    return await SecureStorage().read(UserCredentialsKeys.idToken.key);
  }

  Future<String?> readUserCredentialsUserProfileSub() async {
    return await SecureStorage().read(UserCredentialsKeys.userProfileSub.key);
  }

  Future<bool> isUserPresent() async {
    String? sub = await SecureStorage().read(UserCredentialsKeys.userProfileSub.key);
    return sub != null && sub.isNotEmpty;
  }

  Future<void> removeUserCredentials() async {
    await SecureStorage().deleteAll();
  }

}
