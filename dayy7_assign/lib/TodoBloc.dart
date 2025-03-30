import 'package:flutter_bloc/flutter_bloc.dart';
import 'TodoEvent.dart';
import 'TodoState.dart';
import 'todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> _todos = [];

  TodoBloc() : super(TodoInitialState()) {
    on<AddTodoEvent>(_onAddTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<RemoveTodoEvent>(_onRemoveTodo);
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    _todos.add(event.todo);
    emit(TodoLoadedState(List.from(_todos)));
  }

  void _onToggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) {
    final todo = _todos[event.index];
    _todos[event.index] = todo.copyWith(isCompleted: !todo.isCompleted);
    emit(TodoLoadedState(List.from(_todos)));
  }

  void _onRemoveTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    _todos.removeAt(event.index);
    emit(TodoLoadedState(List.from(_todos)));
  }
}