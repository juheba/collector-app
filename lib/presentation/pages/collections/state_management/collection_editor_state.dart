part of 'collection_editor_cubit.dart';

enum CollectionEditorStatus {
  initial,
  loaded,
  edited,
}

class CollectionEditorState extends Equatable {
  const CollectionEditorState({
    this.status = CollectionEditorStatus.initial,
    this.isNew = true,
    this.collection,
    this.editCollection,
    this.errorMessage,
    this.currentItems,
    this.availableItems,
    this.hasItemsChanged = false,
  });

  final CollectionEditorStatus status;
  final bool isNew;
  final CollectionModel? collection;
  final CollectionModel? editCollection;
  final List<ItemModel>? currentItems;
  final List<ItemModel>? availableItems;
  final bool hasItemsChanged;
  final String? errorMessage;

  CollectionEditorState copyWith({
    CollectionEditorStatus? status,
    bool? isNew,
    CollectionModel? collection,
    CollectionModel? editCollection,
    List<ItemModel>? currentItems,
    List<ItemModel>? availableItems,
    bool? hasItemsChanged,
    String? errorMessage,
  }) =>
      CollectionEditorState(
        status: status ?? this.status,
        isNew: isNew ?? this.isNew,
        collection: collection ?? this.collection,
        editCollection: editCollection ?? this.editCollection,
        currentItems: currentItems ?? this.currentItems,
        availableItems: availableItems ?? this.availableItems,
        hasItemsChanged: hasItemsChanged ?? this.hasItemsChanged,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<dynamic> get props => [
        status,
        isNew,
        collection,
        editCollection,
        currentItems,
        availableItems,
        hasItemsChanged,
        errorMessage,
      ];
}
