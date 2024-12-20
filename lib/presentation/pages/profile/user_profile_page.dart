import 'package:collector/auth/auth_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/profile/state_management/user_profile_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPageWidget extends StatelessWidget {
  const UserPageWidget({super.key});

  static const routeName = 'user';
  static const routePath = '/user';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return BlocProvider(
      create: (context) => UserProfileCubit()..loadUser(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          final pictureUrl = state.user?.pictureUrl;
          return ScaffoldPage(
            title: l10n.user_profile_page_title,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pictureUrl != null)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CircleAvatar(
                          radius: 56,
                          child: ClipOval(
                            child: Image.network(pictureUrl.toString()),
                          ),
                        ),
                      ),
                    ),
                  Card(
                    child: Column(
                      children: [
                        UserEntryWidget(propertyName: l10n.user_profile_id, propertyValue: state.user?.sub),
                        UserEntryWidget(propertyName: l10n.user_profile_name, propertyValue: state.user?.name),
                        UserEntryWidget(propertyName: l10n.user_profile_email, propertyValue: state.user?.email),
                      ],
                    ),
                  ),
                  // only for deubg purposes
                  /*
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () => copyToken(context),
                          child: Text(l10n.user_profile_copy_token),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SelectableText(state.idToken ?? ''),
                        ),
                      ],
                    ),
                  ),*/
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => AuthService().logout(),
                      child: Text(l10n.common_log_out),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void copyToken(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Token copied to clipboard.'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Clipboard.setData(ClipboardData(text: context.read<UserProfileCubit>().state.idToken ?? ''));
  }
}

class UserEntryWidget extends StatelessWidget {
  const UserEntryWidget({
    required this.propertyName,
    required this.propertyValue,
    super.key,
  });
  final String propertyName;
  final String? propertyValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(propertyName),
          Text(propertyValue ?? ''),
        ],
      ),
    );
  }
}
