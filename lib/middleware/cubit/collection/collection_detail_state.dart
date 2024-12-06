part of 'collection_detail_cubit.dart';

enum CollectionDetailStatus { initial, loaded, newly, edited, failure }

class CollectionDetailState extends Equatable {
  const CollectionDetailState({
    this.status = CollectionDetailStatus.initial,
    this.collection,
    this.editCollection,
    this.errorMessage,
  });

  final CollectionDetailStatus status;
  final CollectionModel? collection;
  final String? errorMessage;
  final CollectionModel? editCollection;

  CollectionDetailState copyWith({
    CollectionDetailStatus? status,
    CollectionModel? collection,
    String? errorMessage,
    CollectionModel? editCollection,
  }) =>
      CollectionDetailState(
        status: status ?? this.status,
        collection: collection ?? this.collection,
        errorMessage: errorMessage ?? this.errorMessage,
        editCollection: editCollection ?? this.editCollection,
      );

  @override
  List<dynamic> get props => [status, collection, errorMessage, editCollection];
}
