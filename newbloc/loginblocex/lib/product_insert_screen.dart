import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginblocex/product_insert_bloc.dart';

class ProductInsertScreen extends StatefulWidget {
  const ProductInsertScreen({super.key});

  @override
  State<ProductInsertScreen> createState() => _ProductInsertScreenState();
}

class _ProductInsertScreenState extends State<ProductInsertScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductInsertBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Add Product")),
        body: BlocConsumer<ProductInsertBloc, ProductInsertState>(
          listener: (context, state) {
            if (state is ProductInsertSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              nameController.clear();
              priceController.clear();
              descController.clear();
            } else if (state is ProductInsertFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: "Product Name"),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: "Product Price"),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: "Product Description"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ProductInsertBloc>(context).add(
                        InsertProduct(
                          name: nameController.text,
                          price: priceController.text,
                          description: descController.text,
                        ),
                      );
                    },
                    child: const Text("Insert Product"),
                  ),
                  if (state is ProductInsertLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
