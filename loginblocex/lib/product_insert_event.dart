part of 'product_insert_bloc.dart';

abstract class ProductInsertEvent extends Equatable {
  const ProductInsertEvent();

  @override
  List<Object> get props => [];
}

class InsertProduct extends ProductInsertEvent {
  final String name;
  final String price;
  final String description;

  const InsertProduct({
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  List<Object> get props => [name, price, description];
}
