import 'package:collector/generated/l10n.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:flutter/material.dart';

extension CollectionVisibilityUtils on CollectionVisibility {
  String displayName(BuildContext context) => switch (this) {
        CollectionVisibility.public => L10n.of(context).collection_visibility_public,
        CollectionVisibility.private => L10n.of(context).collection_visibility_private,
      };

  IconData get icon => switch (this) {
        CollectionVisibility.public => Icons.lock_open,
        CollectionVisibility.private => Icons.lock,
      };

  Color get color => switch (this) {
        CollectionVisibility.public => Colors.blue,
        CollectionVisibility.private => Colors.orange,
      };

  Color get foregroundColor => switch (this) {
        CollectionVisibility.public => Colors.white,
        CollectionVisibility.private => Colors.black,
      };
}
