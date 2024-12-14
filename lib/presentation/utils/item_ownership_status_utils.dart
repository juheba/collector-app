import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_ownership_status.dart';
import 'package:flutter/material.dart';

extension ItemOwnershipStatusUtils on ItemOwnershipStatus {
  String displayName(BuildContext context) {
    final l10n = L10n.of(context);

    return switch (this) {
      ItemOwnershipStatus.wishlist => l10n.item_ownership_status_wishlist,
      ItemOwnershipStatus.owner => l10n.item_ownership_status_owner,
      ItemOwnershipStatus.borrower => l10n.item_ownership_status_borrower,
      ItemOwnershipStatus.unknown => l10n.item_ownership_status_undefined,
    };
  }

  IconData get icon => switch (this) {
        ItemOwnershipStatus.wishlist => Icons.list,
        ItemOwnershipStatus.owner => Icons.person,
        ItemOwnershipStatus.borrower => Icons.event_outlined,
        ItemOwnershipStatus.unknown => Icons.help_center,
      };

  Color get color => switch (this) {
        ItemOwnershipStatus.wishlist => Colors.yellow,
        ItemOwnershipStatus.owner => Colors.green,
        ItemOwnershipStatus.borrower => Colors.deepOrange,
        ItemOwnershipStatus.unknown => Colors.blueGrey,
      };
}
