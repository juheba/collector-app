// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(status) => "Ownership: ${status}";

  static String m1(status) => "Process: ${status}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Collector-App"),
        "collection_visibility_private":
            MessageLookupByLibrary.simpleMessage("Privat"),
        "collection_visibility_public":
            MessageLookupByLibrary.simpleMessage("Public"),
        "collections_page_empty_state":
            MessageLookupByLibrary.simpleMessage("No collection found."),
        "collections_page_title":
            MessageLookupByLibrary.simpleMessage("Collections"),
        "common_action_add": MessageLookupByLibrary.simpleMessage("Add"),
        "common_action_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "common_action_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "common_action_save": MessageLookupByLibrary.simpleMessage("Save"),
        "common_log_out": MessageLookupByLibrary.simpleMessage("Log out"),
        "editor_collection_description":
            MessageLookupByLibrary.simpleMessage("Description"),
        "editor_collection_description_hint":
            MessageLookupByLibrary.simpleMessage("Enter description"),
        "editor_collection_name": MessageLookupByLibrary.simpleMessage("Name"),
        "editor_collection_name_error":
            MessageLookupByLibrary.simpleMessage("Error: Name is required"),
        "editor_collection_name_hint":
            MessageLookupByLibrary.simpleMessage("Enter name"),
        "editor_collection_visibility_label":
            MessageLookupByLibrary.simpleMessage("Visibility"),
        "editor_item_can_borrow_title":
            MessageLookupByLibrary.simpleMessage("Can be borrowed?"),
        "editor_item_change_image_title":
            MessageLookupByLibrary.simpleMessage("Change image"),
        "editor_item_description":
            MessageLookupByLibrary.simpleMessage("Description"),
        "editor_item_description_hint":
            MessageLookupByLibrary.simpleMessage("Enter description"),
        "editor_item_ownership_status_title":
            MessageLookupByLibrary.simpleMessage("Ownership status"),
        "editor_item_progress_title":
            MessageLookupByLibrary.simpleMessage("Progress status"),
        "editor_item_title": MessageLookupByLibrary.simpleMessage("Title"),
        "editor_item_title_error":
            MessageLookupByLibrary.simpleMessage("Title is required"),
        "editor_item_title_hint":
            MessageLookupByLibrary.simpleMessage("Enter title"),
        "editor_item_upload_image_title":
            MessageLookupByLibrary.simpleMessage("Upload image"),
        "home_page_title": MessageLookupByLibrary.simpleMessage("Home"),
        "item_details_can_be_borrowed":
            MessageLookupByLibrary.simpleMessage("Can be borrowed"),
        "item_details_can_not_be_borrowed":
            MessageLookupByLibrary.simpleMessage("Can not be borrowed"),
        "item_details_ownership_status": m0,
        "item_details_process": m1,
        "item_ownership_status_borrower":
            MessageLookupByLibrary.simpleMessage("Borrower"),
        "item_ownership_status_owner":
            MessageLookupByLibrary.simpleMessage("Owner"),
        "item_ownership_status_undefined":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "item_ownership_status_wishlist":
            MessageLookupByLibrary.simpleMessage("Wishlist"),
        "item_status_done": MessageLookupByLibrary.simpleMessage("Done"),
        "item_status_in_progress":
            MessageLookupByLibrary.simpleMessage("In progress"),
        "item_status_todo": MessageLookupByLibrary.simpleMessage("ToDo"),
        "item_status_undefined":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "item_type_book": MessageLookupByLibrary.simpleMessage("Book"),
        "item_type_game": MessageLookupByLibrary.simpleMessage("Game"),
        "item_type_movie": MessageLookupByLibrary.simpleMessage("Movie"),
        "item_type_undefined": MessageLookupByLibrary.simpleMessage("Others"),
        "items_page_empty_state":
            MessageLookupByLibrary.simpleMessage("No items found."),
        "items_page_title": MessageLookupByLibrary.simpleMessage("Items"),
        "login_page_login_button":
            MessageLookupByLibrary.simpleMessage("Login"),
        "new_collection_page_title":
            MessageLookupByLibrary.simpleMessage("New collection"),
        "new_item_page_title": MessageLookupByLibrary.simpleMessage("New item"),
        "notification_collection_saved":
            MessageLookupByLibrary.simpleMessage("Collection saved."),
        "notification_item_saved":
            MessageLookupByLibrary.simpleMessage("Item saved."),
        "user_profile_copy_token":
            MessageLookupByLibrary.simpleMessage("Copy token"),
        "user_profile_email": MessageLookupByLibrary.simpleMessage("Email"),
        "user_profile_id": MessageLookupByLibrary.simpleMessage("User ID"),
        "user_profile_name": MessageLookupByLibrary.simpleMessage("Username"),
        "user_profile_page_title":
            MessageLookupByLibrary.simpleMessage("User profile")
      };
}
