part of 'item_detail_cubit.dart';

enum ItemDetailStatus { initial, loaded, newly, edited, failure }

class ItemDetailState extends Equatable {
  const ItemDetailState({this.status = ItemDetailStatus.initial, this.item, this.editItem, this.errorMessage});

  final ItemDetailStatus status;
  final ItemModel? item;
  final String? errorMessage;
  final ItemModel? editItem;

  ItemDetailState copyWith({ItemDetailStatus? status, ItemModel? item, String? errorMessage, ItemModel? editItem}) =>
      ItemDetailState(
        status: status ?? this.status,
        item: item ?? this.item,
        errorMessage: errorMessage ?? this.errorMessage,
        editItem: editItem ?? this.editItem,
      );

  @override
  List<dynamic> get props => [status, item, errorMessage, editItem];
}
