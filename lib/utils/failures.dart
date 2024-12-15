import 'package:equatable/equatable.dart';

sealed class CollectorFailure extends Equatable {
  const CollectorFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class RessourceNotFoundFailure extends CollectorFailure {
  const RessourceNotFoundFailure({required super.message});
}

class InvalidResponseFailure extends CollectorFailure {
  const InvalidResponseFailure({required super.message});
}

class UnknownFailure extends CollectorFailure {
  const UnknownFailure({required super.message});
}
