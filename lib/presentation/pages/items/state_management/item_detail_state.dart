part of 'item_detail_cubit.dart';

enum ItemDetailStatus { initial, loaded, failure }

class ItemDetailState extends Equatable {
  const ItemDetailState({
    this.status = ItemDetailStatus.initial,
    this.item,
    this.collections,
    this.location,
    this.errorMessage,
    this.image,
  });

  final ItemDetailStatus status;
  final ItemModel? item;
  final List<CollectionModel>? collections;
  final LocationModel? location;
  final String? errorMessage;
  final Uint8List? image;

  ItemDetailState copyWith({
    ItemDetailStatus? status,
    ItemModel? item,
    List<CollectionModel>? collections,
    LocationModel? location,
    String? errorMessage,
    Uint8List? image,
  }) =>
      ItemDetailState(
        status: status ?? this.status,
        item: item ?? this.item,
        collections: collections ?? this.collections,
        location: location ?? this.location,
        errorMessage: errorMessage ?? this.errorMessage,
        image: image ?? this.image,
      );

  @override
  List<dynamic> get props => [
        status,
        item,
        collections,
        location,
        errorMessage,
        image,
      ];
}
