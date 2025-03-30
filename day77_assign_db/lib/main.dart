import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TodoBloc.dart';
import 'TodoEvent.dart';
import 'TodoState.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App with BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: const TodoScreen(),
      ),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      labelText: 'Enter a new task',
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        final newTodo = Todo(task: text);
                        context.read<TodoBloc>().add(AddTodoEvent(newTodo));
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final text = TextEditingController().text;
                    if (text.isNotEmpty) {
                      final newTodo = Todo(task: text);
                      context.read<TodoBloc>().add(AddTodoEvent(newTodo));
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoadedState) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(
                          todo.task,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<TodoBloc>().add(RemoveTodoEvent(index));
                          },
                        ),
                        onTap: () {
                          context.read<TodoBloc>().add(ToggleTodoEvent(index));
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No Todos'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}