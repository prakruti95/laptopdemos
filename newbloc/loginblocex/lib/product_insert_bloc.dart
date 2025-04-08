import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'product_insert_event.dart';
part 'product_insert_state.dart';

class ProductInsertBloc extends Bloc<ProductInsertEvent, ProductInsertState> {
  ProductInsertBloc() : super(ProductInsertInitial()) {
    on<InsertProduct>((event, emit) async {
      emit(ProductInsertLoading());

      try {
        final response = await http.post(
          Uri.parse('https://prakrutitech.buzz/Fluttertestapi/productinsert.php'),
          body: {
            'product_name': event.name,
            'product_price': event.price,
            'product_description': event.description,
          },
        );

        final body = response.body.trim();
        print("Response body: $body");

        if (body == '0') {
          emit(ProductInsertFailure("Failed to insert product"));
        } else {
          emit(ProductInsertSuccess("Product inserted successfully"));
        }
      } catch (e) {
        emit(ProductInsertFailure("Error: ${e.toString()}"));
      }
    });
  }
}
