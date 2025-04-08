import 'package:equatable/equatable.dart';

abstract class ProductActionState extends Equatable {
  const ProductActionState();

  @override
  List<Object?> get props => [];
}

class ProductActionInitial extends ProductActionState {}

class ProductActionLoading extends ProductActionState {}

class ProductActionSuccess extends ProductActionState {
  final String message;

  const ProductActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductActionFailure extends ProductActionState {
  final String message;

  const ProductActionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
