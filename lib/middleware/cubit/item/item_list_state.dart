part of 'item_list_cubit.dart';

enum ItemListStatus { initial, loaded, failure }

class ItemState extends Equatable {
  const ItemState({
    this.status = ItemListStatus.initial,
    this.items = const [],
    this.isSelectionModeActive = false,
  });

  final ItemListStatus status;
  final List<ItemModel> items;
  final bool isSelectionModeActive;

  ItemState copyWith({
    ItemListStatus? status,
    List<ItemModel>? items,
    bool? isSelectionModeActive,
  }) =>
      ItemState(
        status: status ?? this.status,
        items: items ?? this.items,
        isSelectionModeActive: isSelectionModeActive ?? this.isSelectionModeActive,
      );

  @override
  List<Object?> get props => [
        status,
        items,
        isSelectionModeActive,
      ];
}
