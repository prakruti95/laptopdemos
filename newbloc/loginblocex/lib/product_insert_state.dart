part of 'product_insert_bloc.dart';

abstract class ProductInsertState extends Equatable {
  const ProductInsertState();

  @override
  List<Object> get props => [];
}

class ProductInsertInitial extends ProductInsertState {}

class ProductInsertLoading extends ProductInsertState {}

class ProductInsertSuccess extends ProductInsertState {
  final String message;

  const ProductInsertSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ProductInsertFailure extends ProductInsertState {
  final String message;

  const ProductInsertFailure(this.message);

  @override
  List<Object> get props => [message];
}
