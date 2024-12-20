// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Collector-App`
  String get app_name {
    return Intl.message(
      'Collector-App',
      name: 'app_name',
      desc: 'Label: Name of the application',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'Label for a button to confirm an action',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'Label for a button to decline an action',
      args: [],
    );
  }

  /// `Private`
  String get collection_visibility_private {
    return Intl.message(
      'Private',
      name: 'collection_visibility_private',
      desc: 'Label: Private',
      args: [],
    );
  }

  /// `Public`
  String get collection_visibility_public {
    return Intl.message(
      'Public',
      name: 'collection_visibility_public',
      desc: 'Label: Public',
      args: [],
    );
  }

  /// `No collection found.`
  String get collections_page_empty_state {
    return Intl.message(
      'No collection found.',
      name: 'collections_page_empty_state',
      desc: 'Message: There are no collections available',
      args: [],
    );
  }

  /// `Collections`
  String get collections_page_title {
    return Intl.message(
      'Collections',
      name: 'collections_page_title',
      desc: 'Label: Title of the collections page',
      args: [],
    );
  }

  /// `Add`
  String get common_action_add {
    return Intl.message(
      'Add',
      name: 'common_action_add',
      desc: 'Action: Add something',
      args: [],
    );
  }

  /// `Cancel`
  String get common_action_cancel {
    return Intl.message(
      'Cancel',
      name: 'common_action_cancel',
      desc: 'Action: Cancel',
      args: [],
    );
  }

  /// `Delete`
  String get common_action_delete {
    return Intl.message(
      'Delete',
      name: 'common_action_delete',
      desc: 'Action: Delete something',
      args: [],
    );
  }

  /// `Save`
  String get common_action_save {
    return Intl.message(
      'Save',
      name: 'common_action_save',
      desc: 'Action: Save something',
      args: [],
    );
  }

  /// `Log out`
  String get common_log_out {
    return Intl.message(
      'Log out',
      name: 'common_log_out',
      desc: 'Action: Log out current user',
      args: [],
    );
  }

  /// `Can be borrowed?`
  String get editor_item_can_borrow_title {
    return Intl.message(
      'Can be borrowed?',
      name: 'editor_item_can_borrow_title',
      desc: 'Label: Can the item be borrowed?',
      args: [],
    );
  }

  /// `Change image`
  String get editor_item_change_image_title {
    return Intl.message(
      'Change image',
      name: 'editor_item_change_image_title',
      desc: 'Label: Change image for item',
      args: [],
    );
  }

  /// `Description`
  String get editor_item_description {
    return Intl.message(
      'Description',
      name: 'editor_item_description',
      desc: 'Label: Description of the item',
      args: [],
    );
  }

  /// `Enter description`
  String get editor_item_description_hint {
    return Intl.message(
      'Enter description',
      name: 'editor_item_description_hint',
      desc: 'Hint: Enter description of the item',
      args: [],
    );
  }

  /// `Ownership status`
  String get editor_item_ownership_status_title {
    return Intl.message(
      'Ownership status',
      name: 'editor_item_ownership_status_title',
      desc: 'Label: Ownership status of the item',
      args: [],
    );
  }

  /// `Progress status`
  String get editor_item_progress_title {
    return Intl.message(
      'Progress status',
      name: 'editor_item_progress_title',
      desc: 'Label: Progress status of the item',
      args: [],
    );
  }

  /// `Title`
  String get editor_item_title {
    return Intl.message(
      'Title',
      name: 'editor_item_title',
      desc: 'Label: Title of the item',
      args: [],
    );
  }

  /// `Title is required`
  String get editor_item_title_error {
    return Intl.message(
      'Title is required',
      name: 'editor_item_title_error',
      desc: 'Error: Title is required',
      args: [],
    );
  }

  /// `Enter title`
  String get editor_item_title_hint {
    return Intl.message(
      'Enter title',
      name: 'editor_item_title_hint',
      desc: 'Hint: Enter title of the item',
      args: [],
    );
  }

  /// `Upload image`
  String get editor_item_upload_image_title {
    return Intl.message(
      'Upload image',
      name: 'editor_item_upload_image_title',
      desc: 'Label: Upload image for item',
      args: [],
    );
  }

  /// `Home`
  String get home_page_title {
    return Intl.message(
      'Home',
      name: 'home_page_title',
      desc: 'Label: Title of the home page',
      args: [],
    );
  }

  /// `Can be borrowed`
  String get item_details_can_be_borrowed {
    return Intl.message(
      'Can be borrowed',
      name: 'item_details_can_be_borrowed',
      desc: 'Label: Item can be borrowed',
      args: [],
    );
  }

  /// `Can not be borrowed`
  String get item_details_can_not_be_borrowed {
    return Intl.message(
      'Can not be borrowed',
      name: 'item_details_can_not_be_borrowed',
      desc: 'Label: Item can not be borrowed',
      args: [],
    );
  }

  /// `Ownership: {status}`
  String item_details_ownership_status(String status) {
    return Intl.message(
      'Ownership: $status',
      name: 'item_details_ownership_status',
      desc: 'Label: Ownership status of the item',
      args: [status],
    );
  }

  /// `Process: {status}`
  String item_details_process(String status) {
    return Intl.message(
      'Process: $status',
      name: 'item_details_process',
      desc: 'Label: Progress status of the item',
      args: [status],
    );
  }

  /// `Borrower`
  String get item_ownership_status_borrower {
    return Intl.message(
      'Borrower',
      name: 'item_ownership_status_borrower',
      desc: 'Label: Borrower',
      args: [],
    );
  }

  /// `Owner`
  String get item_ownership_status_owner {
    return Intl.message(
      'Owner',
      name: 'item_ownership_status_owner',
      desc: 'Label: Owner',
      args: [],
    );
  }

  /// `Unknown`
  String get item_ownership_status_undefined {
    return Intl.message(
      'Unknown',
      name: 'item_ownership_status_undefined',
      desc: 'Label: Undefined',
      args: [],
    );
  }

  /// `Wishlist`
  String get item_ownership_status_wishlist {
    return Intl.message(
      'Wishlist',
      name: 'item_ownership_status_wishlist',
      desc: 'Label: Wishlist',
      args: [],
    );
  }

  /// `Done`
  String get item_status_done {
    return Intl.message(
      'Done',
      name: 'item_status_done',
      desc: 'Label: Done',
      args: [],
    );
  }

  /// `In progress`
  String get item_status_in_progress {
    return Intl.message(
      'In progress',
      name: 'item_status_in_progress',
      desc: 'Label: In progress',
      args: [],
    );
  }

  /// `ToDo`
  String get item_status_todo {
    return Intl.message(
      'ToDo',
      name: 'item_status_todo',
      desc: 'Label: ToDo',
      args: [],
    );
  }

  /// `Unknown`
  String get item_status_undefined {
    return Intl.message(
      'Unknown',
      name: 'item_status_undefined',
      desc: 'Label: Undefined',
      args: [],
    );
  }

  /// `Book`
  String get item_type_book {
    return Intl.message(
      'Book',
      name: 'item_type_book',
      desc: 'Label: Book',
      args: [],
    );
  }

  /// `Game`
  String get item_type_game {
    return Intl.message(
      'Game',
      name: 'item_type_game',
      desc: 'Label: Game',
      args: [],
    );
  }

  /// `Movie`
  String get item_type_movie {
    return Intl.message(
      'Movie',
      name: 'item_type_movie',
      desc: 'Label: Movie',
      args: [],
    );
  }

  /// `Others`
  String get item_type_undefined {
    return Intl.message(
      'Others',
      name: 'item_type_undefined',
      desc: 'Label: Undefined',
      args: [],
    );
  }

  /// `Type`
  String get editor_item_type_title {
    return Intl.message(
      'Type',
      name: 'editor_item_type_title',
      desc: 'Label: Type of the item',
      args: [],
    );
  }

  /// `Collections`
  String get editor_item_collections_label {
    return Intl.message(
      'Collections',
      name: 'editor_item_collections_label',
      desc: 'Label: Collections',
      args: [],
    );
  }

  /// `Assign to collections`
  String get editor_item_select_collections {
    return Intl.message(
      'Assign to collections',
      name: 'editor_item_select_collections',
      desc: 'Label: Assign collections',
      args: [],
    );
  }

  /// `No items found.`
  String get items_page_empty_state {
    return Intl.message(
      'No items found.',
      name: 'items_page_empty_state',
      desc: 'Message: There are no items available',
      args: [],
    );
  }

  /// `Items`
  String get items_page_title {
    return Intl.message(
      'Items',
      name: 'items_page_title',
      desc: 'Label: Title of the items page',
      args: [],
    );
  }

  /// `Is part of collections`
  String get item_details_collections {
    return Intl.message(
      'Is part of collections',
      name: 'item_details_collections',
      desc: 'Label: Item is in collections',
      args: [],
    );
  }

  /// `Login`
  String get login_page_login_button {
    return Intl.message(
      'Login',
      name: 'login_page_login_button',
      desc: 'Label: Title of the login button',
      args: [],
    );
  }

  /// `New item`
  String get new_item_page_title {
    return Intl.message(
      'New item',
      name: 'new_item_page_title',
      desc: 'Label: Title of the new item page',
      args: [],
    );
  }

  /// `Item saved.`
  String get notification_item_saved {
    return Intl.message(
      'Item saved.',
      name: 'notification_item_saved',
      desc: 'Notification: Item saved successfully',
      args: [],
    );
  }

  /// `Item has no changes.`
  String get notification_item_skip_save {
    return Intl.message(
      'Item has no changes.',
      name: 'notification_item_skip_save',
      desc: 'Notification: Item has no changes',
      args: [],
    );
  }

  /// `Item deleted.`
  String get notification_item_deleted {
    return Intl.message(
      'Item deleted.',
      name: 'notification_item_deleted',
      desc: 'Notification: Item deleted successfully',
      args: [],
    );
  }

  /// `Copy token`
  String get user_profile_copy_token {
    return Intl.message(
      'Copy token',
      name: 'user_profile_copy_token',
      desc: 'Action: Copy token to clipboard',
      args: [],
    );
  }

  /// `Email`
  String get user_profile_email {
    return Intl.message(
      'Email',
      name: 'user_profile_email',
      desc: 'Label: User\'s email address',
      args: [],
    );
  }

  /// `User ID`
  String get user_profile_id {
    return Intl.message(
      'User ID',
      name: 'user_profile_id',
      desc: 'Label: User\'s ID',
      args: [],
    );
  }

  /// `Username`
  String get user_profile_name {
    return Intl.message(
      'Username',
      name: 'user_profile_name',
      desc: 'Label: Username',
      args: [],
    );
  }

  /// `User profile`
  String get user_profile_page_title {
    return Intl.message(
      'User profile',
      name: 'user_profile_page_title',
      desc: 'Label: Title of the user profile page',
      args: [],
    );
  }

  /// `New collection`
  String get new_collection_page_title {
    return Intl.message(
      'New collection',
      name: 'new_collection_page_title',
      desc: 'Label: Title of the new collection page',
      args: [],
    );
  }

  /// `Collection saved.`
  String get notification_collection_saved {
    return Intl.message(
      'Collection saved.',
      name: 'notification_collection_saved',
      desc: 'Notification: Collection saved successfully',
      args: [],
    );
  }

  /// `Collection has no changes.`
  String get notification_collection_skip_save {
    return Intl.message(
      'Collection has no changes.',
      name: 'notification_collection_skip_save',
      desc: 'Notification: Collection has no changes',
      args: [],
    );
  }

  /// `Collection deleted.`
  String get notification_collection_deleted {
    return Intl.message(
      'Collection deleted.',
      name: 'notification_collection_deleted',
      desc: 'Notification: Collection deleted successfully',
      args: [],
    );
  }

  /// `Description`
  String get editor_collection_description {
    return Intl.message(
      'Description',
      name: 'editor_collection_description',
      desc: 'Label: Description of the collection',
      args: [],
    );
  }

  /// `Enter description`
  String get editor_collection_description_hint {
    return Intl.message(
      'Enter description',
      name: 'editor_collection_description_hint',
      desc: 'Hint: Enter description of the collection',
      args: [],
    );
  }

  /// `Visibility`
  String get editor_collection_visibility_label {
    return Intl.message(
      'Visibility',
      name: 'editor_collection_visibility_label',
      desc: 'Label: Visibility of the collection',
      args: [],
    );
  }

  /// `Name`
  String get editor_collection_name {
    return Intl.message(
      'Name',
      name: 'editor_collection_name',
      desc: 'Label: Name of the collection',
      args: [],
    );
  }

  /// `Name is required`
  String get editor_collection_name_error {
    return Intl.message(
      'Name is required',
      name: 'editor_collection_name_error',
      desc: 'Error: Name is required',
      args: [],
    );
  }

  /// `Enter name`
  String get editor_collection_name_hint {
    return Intl.message(
      'Enter name',
      name: 'editor_collection_name_hint',
      desc: 'Hint: Enter name of the collection',
      args: [],
    );
  }

  /// `Contains items`
  String get collection_details_items {
    return Intl.message(
      'Contains items',
      name: 'collection_details_items',
      desc: 'Label: Collection contains items',
      args: [],
    );
  }

  /// `Location`
  String get location_label {
    return Intl.message(
      'Location',
      name: 'location_label',
      desc: 'Label: Location',
      args: [],
    );
  }

  /// `Locations`
  String get locations_page_title {
    return Intl.message(
      'Locations',
      name: 'locations_page_title',
      desc: 'Label: Title of the locations page',
      args: [],
    );
  }

  /// `No locations found.`
  String get locations_page_empty_state {
    return Intl.message(
      'No locations found.',
      name: 'locations_page_empty_state',
      desc: 'Message: There are no locations available',
      args: [],
    );
  }

  /// `New location`
  String get new_location_page_title {
    return Intl.message(
      'New location',
      name: 'new_location_page_title',
      desc: 'Label: Title of the new location page',
      args: [],
    );
  }

  /// `Location saved.`
  String get notification_location_saved {
    return Intl.message(
      'Location saved.',
      name: 'notification_location_saved',
      desc: 'Notification: Location saved successfully',
      args: [],
    );
  }

  /// `Location has no changes.`
  String get notification_location_skip_save {
    return Intl.message(
      'Location has no changes.',
      name: 'notification_location_skip_save',
      desc: 'Notification: Location has no changes',
      args: [],
    );
  }

  /// `Location deleted.`
  String get notification_location_deleted {
    return Intl.message(
      'Location deleted.',
      name: 'notification_location_deleted',
      desc: 'Notification: Location deleted successfully',
      args: [],
    );
  }

  /// `Description`
  String get editor_location_description {
    return Intl.message(
      'Description',
      name: 'editor_location_description',
      desc: 'Label: Description of the location',
      args: [],
    );
  }

  /// `Enter description`
  String get editor_location_description_hint {
    return Intl.message(
      'Enter description',
      name: 'editor_location_description_hint',
      desc: 'Hint: Enter description of the location',
      args: [],
    );
  }

  /// `Name`
  String get editor_location_name {
    return Intl.message(
      'Name',
      name: 'editor_location_name',
      desc: 'Label: Name of the location',
      args: [],
    );
  }

  /// `Name is required`
  String get editor_location_name_error {
    return Intl.message(
      'Name is required',
      name: 'editor_location_name_error',
      desc: 'Error: Name is required',
      args: [],
    );
  }

  /// `Enter name`
  String get editor_location_name_hint {
    return Intl.message(
      'Enter name',
      name: 'editor_location_name_hint',
      desc: 'Hint: Enter name of the location',
      args: [],
    );
  }

  /// `Upload image`
  String get editor_location_upload_image_label {
    return Intl.message(
      'Upload image',
      name: 'editor_location_upload_image_label',
      desc: 'Label: Upload image for location',
      args: [],
    );
  }

  /// `Change image`
  String get editor_location_change_image_label {
    return Intl.message(
      'Change image',
      name: 'editor_location_change_image_label',
      desc: 'Label: Change image for location',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
