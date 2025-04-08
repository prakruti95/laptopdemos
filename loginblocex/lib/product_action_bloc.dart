import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginblocex/product_action_event.dart';
import 'package:loginblocex/product_action_state.dart';
import 'package:http/http.dart' as http;

class ProductActionBloc extends Bloc<ProductActionEvent, ProductActionState> {
  ProductActionBloc() : super(ProductActionInitial()) {
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onUpdateProduct(UpdateProduct event, Emitter<ProductActionState> emit) async {
    emit(ProductActionLoading());
    try {
      final response = await http.post(
        Uri.parse("https://prakrutitech.buzz/Fluttertestapi/productupdate.php"),
        body: {
          "id": event.id,
          "product_name": event.name,
          "product_price": event.price,
          "product_description": event.description,
        },
      );

      if (response.statusCode == 200) {
        final body = response.body.trim();
        if (body == "Record Updated Successfully") {
          emit(ProductActionSuccess("Product updated successfully"));
        } else {
          emit(ProductActionFailure("Failed to update product"));
        }
      } else {
        emit(ProductActionFailure("Server error"));
      }
    } catch (e) {
      emit(ProductActionFailure("Error: $e"));
    }
  }

  Future<void> _onDeleteProduct(DeleteProduct event, Emitter<ProductActionState> emit) async {
    emit(ProductActionLoading());
    try {
      final response = await http.post(
        Uri.parse("https://prakrutitech.buzz/Fluttertestapi/productdelete.php"),
        body: {
          "id": event.id,
        },
      );

      if (response.statusCode == 200) {
        final body = response.body.trim();
        if (body == "Record Deleted Successfully") {
          emit(ProductActionSuccess("Product deleted successfully"));
        } else {
          emit(ProductActionFailure("Failed to delete product"));
        }
      } else {
        emit(ProductActionFailure("Server error"));
      }
    } catch (e) {
      emit(ProductActionFailure("Error: $e"));
    }
  }
}
