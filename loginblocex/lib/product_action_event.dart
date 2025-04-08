import 'package:equatable/equatable.dart';

abstract class ProductActionEvent extends Equatable {
  const ProductActionEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProduct extends ProductActionEvent {
  final String id;
  final String name;
  final String price;
  final String description;

  const UpdateProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, price, description];
}

class DeleteProduct extends ProductActionEvent {
  final String id;

  const DeleteProduct(this.id);

  @override
  List<Object?> get props => [id];
}
