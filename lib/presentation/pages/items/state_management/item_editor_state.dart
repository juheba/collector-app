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
    this.editItem,
    this.currentCollections,
    this.availableCollections,
    this.currentLocation,
    this.availableLocations,
    this.errorMessage,
    this.image,
  });

  final ItemEditorStatus status;
  final bool isNew;
  final ItemModel? item;
  final ItemModel? editItem;
  final List<CollectionModel>? currentCollections;
  final List<CollectionModel>? availableCollections;
  final LocationModel? currentLocation;
  final List<LocationModel>? availableLocations;
  final String? errorMessage;
  final Uint8List? image;

  ItemEditorState copyWith({
    ItemEditorStatus? status,
    bool? isNew,
    ItemModel? item,
    ItemModel? editItem,
    List<CollectionModel>? currentCollections,
    List<CollectionModel>? availableCollections,
    LocationModel? currentLocation,
    List<LocationModel>? availableLocations,
    String? errorMessage,
    Uint8List? image,
  }) =>
      ItemEditorState(
        status: status ?? this.status,
        isNew: isNew ?? this.isNew,
        item: item ?? this.item,
        editItem: editItem ?? this.editItem,
        currentCollections: currentCollections ?? this.currentCollections,
        availableCollections: availableCollections ?? this.availableCollections,
        currentLocation: currentLocation ?? this.currentLocation,
        availableLocations: availableLocations ?? this.availableLocations,
        errorMessage: errorMessage ?? this.errorMessage,
        image: image ?? this.image,
      );

  @override
  List<dynamic> get props => [
        status,
        isNew,
        item,
        editItem,
        currentCollections,
        availableCollections,
        currentLocation,
        availableLocations,
        errorMessage,
        image,
      ];
}
