part of 'item_list_cubit.dart';

enum ItemListStatus { initial, loaded, failure }

class ItemState extends Equatable {
  const ItemState({
    this.status = ItemListStatus.initial,
    this.items = const [],
  });

  final ItemListStatus status;
  final List<ItemModel> items;

  ItemState copyWith({
    ItemListStatus? status,
    List<ItemModel>? items,
  }) =>
      ItemState(
        status: status ?? this.status,
        items: items ?? this.items,
      );

  @override
  List<Object?> get props => [
        status,
        items,
      ];
}
