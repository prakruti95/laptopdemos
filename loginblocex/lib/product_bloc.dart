import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loginblocex/product_model.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await http.get(
          Uri.parse('https://prakrutitech.buzz/Fluttertestapi/productview.php'),
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonList = json.decode(response.body);
          final List<Product> products = jsonList.map((e) => Product.fromJson(e)).toList();

          emit(ProductLoaded(products));
        } else {
          emit(ProductError("Failed to load products"));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
