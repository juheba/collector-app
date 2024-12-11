// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(status) => "Eigentumsstatus: ${status}";

  static String m1(status) => "Fortschrittsstatus: ${status}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Collector-App"),
        "collections_page_empty_state":
            MessageLookupByLibrary.simpleMessage("Keine Sammlungen vorhanden."),
        "collections_page_title":
            MessageLookupByLibrary.simpleMessage("Sammlungen"),
        "common_action_add": MessageLookupByLibrary.simpleMessage("Hinzufügen"),
        "common_action_cancel":
            MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "common_action_delete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "common_action_save": MessageLookupByLibrary.simpleMessage("Speichern"),
        "common_log_out": MessageLookupByLibrary.simpleMessage("Ausloggen"),
        "editor_item_can_borrow_title":
            MessageLookupByLibrary.simpleMessage("Ist ausleihbar?"),
        "editor_item_description":
            MessageLookupByLibrary.simpleMessage("Beschreibung"),
        "editor_item_description_hint":
            MessageLookupByLibrary.simpleMessage("Beschreibung eingeben"),
        "editor_item_ownership_status_title":
            MessageLookupByLibrary.simpleMessage("Eigentumsstatus"),
        "editor_item_progress_title":
            MessageLookupByLibrary.simpleMessage("Fortschrittsstatus"),
        "editor_item_title": MessageLookupByLibrary.simpleMessage("Titel"),
        "editor_item_title_error":
            MessageLookupByLibrary.simpleMessage("Titel wird benötigt."),
        "editor_item_title_hint":
            MessageLookupByLibrary.simpleMessage("Titel eingeben"),
        "editor_item_upload_image_title":
            MessageLookupByLibrary.simpleMessage("Bild auswählen"),
        "home_page_title": MessageLookupByLibrary.simpleMessage("Startseite"),
        "item_details_can_be_borrowed":
            MessageLookupByLibrary.simpleMessage("Kann ausgeliehen werden"),
        "item_details_can_not_be_borrowed":
            MessageLookupByLibrary.simpleMessage(
                "Kann nicht ausgeliehen werden"),
        "item_details_ownership_status": m0,
        "item_details_process": m1,
        "items_page_empty_state": MessageLookupByLibrary.simpleMessage(
            "Keine Gegenstände vorhanden."),
        "items_page_title": MessageLookupByLibrary.simpleMessage("Gegenstände"),
        "login_page_login_button":
            MessageLookupByLibrary.simpleMessage("Login"),
        "new_item_page_title":
            MessageLookupByLibrary.simpleMessage("Neuer Gegenstand"),
        "notification_item_saved":
            MessageLookupByLibrary.simpleMessage("Gegenstand gespeichert."),
        "user_profile_copy_token":
            MessageLookupByLibrary.simpleMessage("Token kopieren"),
        "user_profile_email": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "user_profile_id": MessageLookupByLibrary.simpleMessage("Benutzer-ID"),
        "user_profile_name":
            MessageLookupByLibrary.simpleMessage("Benutzername"),
        "user_profile_page_title":
            MessageLookupByLibrary.simpleMessage("Nutzerprofil")
      };
}
