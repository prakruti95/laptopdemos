import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginblocex/product_action_bloc.dart';
import 'package:loginblocex/product_bloc.dart';
import 'package:loginblocex/product_insert_bloc.dart';
import 'package:loginblocex/product_insert_screen.dart';
import 'package:loginblocex/product_screen.dart';
import 'package:loginblocex/signup_bloc.dart';
import 'package:loginblocex/signup_screen.dart';

import 'login_bloc.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        BlocProvider<SignupBloc>(create: (_) => SignupBloc()),
        BlocProvider<ProductBloc>(create: (_) => ProductBloc()..add(FetchProducts())),
        BlocProvider<ProductInsertBloc>(create: (_) => ProductInsertBloc()),
        BlocProvider<ProductActionBloc>(create: (_) => ProductActionBloc()),
      ],
      child: MaterialApp(
        title: 'Auth App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ProductScreen(),
      ),
    );
  }
}
