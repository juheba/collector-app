import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:collector/data/persistence/secure_storage.dart';

const userCredentialsKeyPrefix = 'user_credentials_';
const userCredentialsUserProfileKeyPrefix = '${userCredentialsKeyPrefix}userprofile_';

enum UserCredentialsKeys {
  idToken('${userCredentialsKeyPrefix}idToken'),
  accessToken('${userCredentialsKeyPrefix}accessToken'),
  expiresAt('${userCredentialsKeyPrefix}expiresAt'),
  tokenType('${userCredentialsKeyPrefix}tokenType'),
  userProfileSub('${userCredentialsUserProfileKeyPrefix}sub'),
  userProfileName('${userCredentialsUserProfileKeyPrefix}name'),
  userProfileEmail('${userCredentialsUserProfileKeyPrefix}email'),
  userProfilePicture('${userCredentialsUserProfileKeyPrefix}picture');

  const UserCredentialsKeys(this.key);
  final String key;
}

/// AccessUserCredentials is defined as Singleton.
/// Access (read and write) user credentials in SecretStore.
class AccessUserCredentials {
  factory AccessUserCredentials() => _instance;

  AccessUserCredentials._internal();
  static final AccessUserCredentials _instance = AccessUserCredentials._internal();

  Future<void> writeUserCredentials(Credentials credentials) async {
    await SecureStorage().write(UserCredentialsKeys.idToken.key, credentials.idToken);
    await SecureStorage().write(UserCredentialsKeys.accessToken.key, credentials.accessToken);
    await SecureStorage().write(UserCredentialsKeys.expiresAt.key, credentials.expiresAt.toIso8601String());
    await SecureStorage().write(UserCredentialsKeys.tokenType.key, credentials.tokenType);
    await SecureStorage().write(UserCredentialsKeys.userProfileSub.key, credentials.user.sub);
    await SecureStorage().write(UserCredentialsKeys.userProfileName.key, credentials.user.name ?? '');
    await SecureStorage().write(UserCredentialsKeys.userProfileEmail.key, credentials.user.email ?? '');
    await SecureStorage().write(UserCredentialsKeys.userProfilePicture.key, credentials.user.pictureUrl.toString());
  }

  Future<Credentials> readUserCredentials() async {
    final credentialKeys = <String>[
      UserCredentialsKeys.idToken.key,
      UserCredentialsKeys.accessToken.key,
      UserCredentialsKeys.expiresAt.key,
      UserCredentialsKeys.tokenType.key,
    ];

    final user = await readUserProfile();

    return SecureStorage().readKeys(credentialKeys).then(
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
    final userProfileKeys = <String>[
      UserCredentialsKeys.userProfileSub.key,
      UserCredentialsKeys.userProfileName.key,
      UserCredentialsKeys.userProfileEmail.key,
      UserCredentialsKeys.userProfilePicture.key,
    ];

    return SecureStorage().readKeys(userProfileKeys).then(
          (keyValueMap) => UserProfile(
            sub: keyValueMap[UserCredentialsKeys.userProfileSub.key] ?? '',
            name: keyValueMap[UserCredentialsKeys.userProfileName.key],
            email: keyValueMap[UserCredentialsKeys.userProfileEmail.key],
            pictureUrl: Uri.parse(
              keyValueMap[UserCredentialsKeys.userProfilePicture.key] ?? '',
            ),
          ),
        );
  }

  Future<String?> readUserCredentialsIdToken() async {
    return SecureStorage().read(UserCredentialsKeys.idToken.key);
  }

  Future<String?> readUserCredentialsUserProfileSub() async {
    return SecureStorage().read(UserCredentialsKeys.userProfileSub.key);
  }

  Future<bool> isUserPresent() async {
    final sub = await readUserCredentialsUserProfileSub();
    return sub != null && sub.isNotEmpty;
  }

  Future<void> removeUserCredentials() async {
    await SecureStorage().deleteAll();
  }
}
