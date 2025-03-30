import 'package:equatable/equatable.dart';
import 'todo.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitialState extends TodoState {}

class TodoLoadedState extends TodoState {
  final List<Todo> todos;

  TodoLoadedState(this.todos);

  @override
  List<Object?> get props => [todos];
}