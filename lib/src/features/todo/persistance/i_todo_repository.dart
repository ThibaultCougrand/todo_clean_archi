import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/todo_repository.dart';

part 'i_todo_repository.g.dart';

/// Répository de la todolist, gère les échanges avec la base de données sembast
abstract class ITodoRepository {
  Future<List<Todo>> fetchTodo();
  Future<void> setTodo(List<Todo> todos);
  Future<void> cleanTodo();
}

@Riverpod(keepAlive: true)
ITodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepository(ref);
}
