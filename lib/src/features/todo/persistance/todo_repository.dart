import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/i_local_db.dart';

class TodoRepository implements ITodoRepository {
  TodoRepository(this.ref);

  final Ref ref;

  @override
  Future<List<Todo>> fetchTodo() async {
    /// Liste vide pour recevoir le resultat serialisé
    final result = <Todo>[];

    /// On récupère le Json sur sembast
    final json = await ref.read(localDbProvider).getData('todolist');
    //as List<Map<String, dynamic>>?;

    /// {
    ///   {
    ///     "name": "todo1",
    ///     "checked": true,
    ///   },
    ///   {
    ///     "name": "todo2",
    ///     "checked": false,
    ///   }
    /// }

    /// Si la liste n'est pas vide on transforme le json en Liste de Todo
    if (json != null && json.isNotEmpty) {
      json.forEach((todo) => result.add(Todo.fromJson(todo)));
    }

    return result;
  }

  @override
  Future<void> setTodo(List<Todo> todos) async {
    final datas = <Map<String, dynamic>>[];
    if (todos.isNotEmpty) {
      todos.forEach((todo) => datas.add(todo.toJson()));
      ref.read(localDbProvider).setData('todolist', datas);
    }
  }

  @override
  Future<void> cleanTodo() async {
    ref.read(localDbProvider).setData('todolist', []);
  }
}
