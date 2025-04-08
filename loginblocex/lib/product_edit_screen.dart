import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginblocex/product_action_bloc.dart';
import 'package:loginblocex/product_action_event.dart';
import 'package:loginblocex/product_action_state.dart';
import 'package:loginblocex/product_screen.dart';

class ProductEditScreen extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String description;

  const ProductEditScreen({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price);
    descController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ProductActionBloc, ProductActionState>(
          listener: (context, state) {
            if (state is ProductActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductScreen()),
              );
            } else if (state is ProductActionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
                TextField(controller: priceController, decoration: const InputDecoration(labelText: "Price")),
                TextField(controller: descController, decoration: const InputDecoration(labelText: "Description")),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductActionBloc>().add(UpdateProduct(
                      id: widget.id,
                      name: nameController.text,
                      price: priceController.text,
                      description: descController.text,
                    ));
                  },
                  child: const Text("Update"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    context.read<ProductActionBloc>().add(DeleteProduct(widget.id));
                  },
                  child: const Text("Delete"),
                ),
                if (state is ProductActionLoading) const CircularProgressIndicator()
              ],
            );
          },
        ),
      ),
    );
  }
}
