part of 'collection_editor_cubit.dart';

enum CollectionEditorStatus { initial, loaded, newly, edited, failure }

class CollectionEditorState extends Equatable {
  const CollectionEditorState({
    this.status = CollectionEditorStatus.initial,
    this.collection,
    this.editCollection,
    this.items,
    this.errorMessage,
  });

  final CollectionEditorStatus status;
  final CollectionModel? collection;
  final List<ItemModel>? items;
  final String? errorMessage;
  final CollectionModel? editCollection;

  CollectionEditorState copyWith({
    CollectionEditorStatus? status,
    CollectionModel? collection,
    List<ItemModel>? items,
    String? errorMessage,
    CollectionModel? editCollection,
  }) =>
      CollectionEditorState(
        status: status ?? this.status,
        collection: collection ?? this.collection,
        items: items ?? this.items,
        errorMessage: errorMessage ?? this.errorMessage,
        editCollection: editCollection ?? this.editCollection,
      );

  @override
  List<dynamic> get props => [
        status,
        collection,
        editCollection,
        items,
        errorMessage,
      ];
}
