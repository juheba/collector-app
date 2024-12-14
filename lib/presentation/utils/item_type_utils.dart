import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_type.dart';
import 'package:flutter/material.dart';

extension ItemTypeUtils on ItemType {
  String displayName(BuildContext context) {
    final l10n = L10n.of(context);

    return switch (this) {
      ItemType.book => l10n.item_type_book,
      ItemType.game => l10n.item_type_game,
      ItemType.movie => l10n.item_type_movie,
      ItemType.undefined => l10n.item_type_undefined
    };
  }

  IconData get icon => switch (this) {
        ItemType.book => Icons.book,
        ItemType.game => Icons.videogame_asset,
        ItemType.movie => Icons.movie,
        ItemType.undefined => Icons.help_center
      };

  Color get color => switch (this) {
        ItemType.book => Colors.deepOrange,
        ItemType.game => Colors.lightBlue,
        ItemType.movie => Colors.lime,
        ItemType.undefined => Colors.blueGrey
      };
}
