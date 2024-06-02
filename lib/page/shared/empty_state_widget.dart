import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/empty.svg'),
        const SizedBox(
          height: 32,
        ),
        Text(message),
      ],
    );
  }
}
