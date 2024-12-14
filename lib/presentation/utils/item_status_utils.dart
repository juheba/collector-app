import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_status.dart';
import 'package:flutter/material.dart';

extension ItemStatusUtils on ItemStatus {
  String displayName(BuildContext context) {
    final l1on = L10n.of(context);

    return switch (this) {
      ItemStatus.todo => l1on.item_status_todo,
      ItemStatus.processing => l1on.item_status_in_progress,
      ItemStatus.done => l1on.item_status_done,
      ItemStatus.unknown => l1on.item_status_undefined,
    };
  }

  IconData get icon => switch (this) {
        ItemStatus.todo => Icons.start,
        ItemStatus.processing => Icons.keyboard_double_arrow_right,
        ItemStatus.done => Icons.check_circle,
        ItemStatus.unknown => Icons.help_center,
      };

  Color get color => switch (this) {
        ItemStatus.todo => Colors.blue,
        ItemStatus.processing => Colors.orange,
        ItemStatus.done => Colors.green,
        ItemStatus.unknown => Colors.blueGrey,
      };
}
