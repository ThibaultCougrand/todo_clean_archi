import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/i_local_db.dart';

class TodoRepository implements ITodoRepository {
  TodoRepository(this.ref);

  final Ref ref;

  @override
  Future<List<String>> fetchTodo() async {
    return ref.read(localDbProvider).getData('todolist') as List<String>;
  }

  @override
  Future<void> setTodo(List<String> todos) async {
    ref.read(localDbProvider).setData('todolist', todos);
  }
}
