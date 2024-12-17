part of 'item_detail_cubit.dart';

enum ItemDetailStatus { initial, loaded, newly, edited, deleted, failure }

class ItemDetailState extends Equatable {
  const ItemDetailState({
    this.status = ItemDetailStatus.initial,
    this.item,
    this.collections,
    this.editItem,
    this.errorMessage,
    this.image,
  });

  final ItemDetailStatus status;
  final ItemModel? item;
  final List<CollectionModel>? collections;
  final String? errorMessage;
  final ItemModel? editItem;
  final Uint8List? image;

  ItemDetailState copyWith({
    ItemDetailStatus? status,
    ItemModel? item,
    List<CollectionModel>? collections,
    String? errorMessage,
    ItemModel? editItem,
    Uint8List? image,
  }) =>
      ItemDetailState(
        status: status ?? this.status,
        item: item ?? this.item,
        collections: collections ?? this.collections,
        errorMessage: errorMessage ?? this.errorMessage,
        editItem: editItem ?? this.editItem,
        image: image ?? this.image,
      );

  @override
  List<dynamic> get props => [
        status,
        item,
        collections,
        errorMessage,
        editItem,
        image,
      ];
}
