import 'package:collector/auth/auth_service.dart';
import 'package:collector/middleware/cubit/user/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPageWidget extends StatelessWidget {
  const UserPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()..loadUser(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          final pictureUrl = state.user?.pictureUrl;
          return Scaffold(
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
                        UserEntryWidget(propertyName: 'Id', propertyValue: state.user?.sub),
                        UserEntryWidget(propertyName: 'Name', propertyValue: state.user?.name),
                        UserEntryWidget(propertyName: 'Email', propertyValue: state.user?.email),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () => copyToken(context),
                          child: const Text('Copy Token'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SelectableText(state.idToken ?? ''),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => AuthService().logout(),
                      child: const Text('Logout'),
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
