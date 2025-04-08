import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginblocex/product_bloc.dart';
import 'package:loginblocex/product_insert_screen.dart';
import 'package:loginblocex/product_model.dart';
import 'package:loginblocex/product_edit_screen.dart';
import 'package:loginblocex/product_action_bloc.dart';
import 'package:loginblocex/product_action_event.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(FetchProducts());
              },
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  Product product = state.products[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price: ₹${product.price}"),
                          Text("Desc: ${product.description}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductEditScreen(
                                    id: product.id,
                                    name: product.name,
                                    price: product.price,
                                    description: product.description,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<ProductActionBloc>()
                                  .add(DeleteProduct(product.id));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const Center(child: Text("No data"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProductInsertScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
