part of 'collection_list_cubit.dart';

enum CollectionListStatus { initial, loaded, failure }

class CollectionState extends Equatable {
  const CollectionState({
    this.status = CollectionListStatus.initial,
    this.collections = const [],
    this.isSelectionModeActive = false,
  });

  final CollectionListStatus status;
  final List<CollectionModel> collections;
  final bool isSelectionModeActive;

  CollectionState copyWith({
    CollectionListStatus? status,
    List<CollectionModel>? collections,
    bool? isSelectionModeActive,
  }) =>
      CollectionState(
        status: status ?? this.status,
        collections: collections ?? this.collections,
        isSelectionModeActive: isSelectionModeActive ?? this.isSelectionModeActive,
      );

  @override
  List<Object?> get props => [
        status,
        collections,
        isSelectionModeActive,
      ];
}
