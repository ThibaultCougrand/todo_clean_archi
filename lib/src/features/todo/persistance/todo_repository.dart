import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/i_local_db.dart';

class TodoRepository implements ITodoRepository {
  TodoRepository(this.ref);

  final Ref ref;

  /// Pour lire la todolist
  @override
  Future<List<Todo>> fetchTodo() async {
    //* Liste vide pour recevoir le resultat serialisé
    final result = <Todo>[];

    //* On récupère le Json sur sembast
    final json = await ref.read(localDbProvider).getData('todolist');
    //! Comprendre pourquoi le cast ne marche plus 
    // as List<Map<String, dynamic>>?;

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

    //* Si la liste n'est pas vide on transforme le json en Liste de Todo
    if (json != null && json.isNotEmpty) {
      for (var todo in json) {
        result.add(Todo.fromJson(todo));
      }
    }

    return result;
  }

  /// Pour ajouter un todo
  @override
  Future<void> setTodo(List<Todo> todos) async {
    //* Liste vide pour recevoir le resultat serialisé
    final datas = <Map<String, dynamic>>[];

    //* Si la liste n'est pas vide on transforme le json en Liste de Todo
    if (todos.isNotEmpty) {
      for (Todo todo in todos) {
        datas.add(todo.toJson());
      }

      //* Puis on envoie le Json sur sembast
      ref.read(localDbProvider).setData('todolist', datas);
    }
  }

  /// Pour vider la todolist
  @override
  Future<void> cleanTodo() async {
    //* On vide la valeur todolist sur sembast
    ref.read(localDbProvider).setData('todolist', []);
  }
}
