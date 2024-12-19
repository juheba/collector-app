import 'package:equatable/equatable.dart';

sealed class EditorPresentationEvent extends Equatable {}

class EditorPresentationEventSaved extends EditorPresentationEvent {
  EditorPresentationEventSaved();

  @override
  List<Object?> get props => [];
}

class EditorPresentationEventSkipSave extends EditorPresentationEvent {
  EditorPresentationEventSkipSave();

  @override
  List<Object?> get props => [];
}

class EditorPresentationEventCanceled extends EditorPresentationEvent {
  EditorPresentationEventCanceled({
    required this.isNew,
    required this.id,
  });

  final bool isNew;
  final String? id;

  @override
  List<Object?> get props => [isNew, id];
}

class EditorPresentationEventDeleted extends EditorPresentationEvent {
  EditorPresentationEventDeleted();

  @override
  List<Object?> get props => [];
}

class EditorPresentationEventFailure extends EditorPresentationEvent {
  EditorPresentationEventFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
