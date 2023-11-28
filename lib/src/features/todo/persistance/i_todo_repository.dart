import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/todo_repository.dart';

part 'i_todo_repository.g.dart';

abstract class ITodoRepository {
  Future<List<String>> fetchTodo();
  Future<void> setTodo(List<String> todos);
}

@Riverpod(keepAlive: true)
ITodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepository(ref);
}
