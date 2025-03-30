import 'package:flutter_bloc/flutter_bloc.dart';
import 'TodoEvent.dart';
import 'TodoState.dart';
import 'todo.dart';
import 'TodoDatabase.dart';  // Import the database helper class

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoDatabase _todoDatabase = TodoDatabase.instance;

  TodoBloc() : super(TodoInitialState()) {
    on<AddTodoEvent>(_onAddTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<RemoveTodoEvent>(_onRemoveTodo);
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _todoDatabase.getTodos();
    emit(TodoLoadedState(todos));
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    await _todoDatabase.create(event.todo);
    _loadTodos();
  }

  Future<void> _onToggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) async {
    final todos = await _todoDatabase.getTodos();
    final todo = todos[event.index];
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await _todoDatabase.update(updatedTodo);
    _loadTodos();
  }

  Future<void> _onRemoveTodo(RemoveTodoEvent event, Emitter<TodoState> emit) async {
    await _todoDatabase.delete(event.index);
    _loadTodos();
  }
}
