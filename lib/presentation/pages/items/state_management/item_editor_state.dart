part of 'item_editor_cubit.dart';

enum ItemEditorStatus {
  initial,
  loaded,
  edited,
}

class ItemEditorState extends Equatable {
  const ItemEditorState({
    this.status = ItemEditorStatus.initial,
    this.isNew = true,
    this.item,
    this.collections,
    this.editCollections,
    this.editItem,
    this.errorMessage,
    this.image,
  });

  final ItemEditorStatus status;
  final bool isNew;
  final ItemModel? item;
  final List<CollectionModel>? collections;
  final String? errorMessage;
  final ItemModel? editItem;
  final List<CollectionModel>? editCollections;
  final Uint8List? image;

  ItemEditorState copyWith({
    ItemEditorStatus? status,
    bool? isNew,
    ItemModel? item,
    String? errorMessage,
    ItemModel? editItem,
    Uint8List? image,
  }) =>
      ItemEditorState(
        status: status ?? this.status,
        isNew: isNew ?? this.isNew,
        item: item ?? this.item,
        errorMessage: errorMessage ?? this.errorMessage,
        editItem: editItem ?? this.editItem,
        image: image ?? this.image,
      );

  @override
  List<dynamic> get props => [
        status,
        isNew,
        item,
        collections,
        errorMessage,
        editItem,
        editCollections,
        image,
      ];
}
