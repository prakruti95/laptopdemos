import 'package:equatable/equatable.dart';
import 'todo.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class ToggleTodoEvent extends TodoEvent {
  final int index;

  ToggleTodoEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class RemoveTodoEvent extends TodoEvent {
  final int index;

  RemoveTodoEvent(this.index);

  @override
  List<Object?> get props => [index];
}