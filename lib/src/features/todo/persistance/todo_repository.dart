import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/exceptions/app_exception.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/i_local_db.dart';

class TodoRepository implements ITodoRepository {
  TodoRepository(this.ref);

  final Ref ref;

  /// Pour lire la todolist
  @override
  Future<List<Todo>> fetchTodo() async {
    try {
      //* Liste vide pour recevoir le resultat serialisé
      final result = <Todo>[];

      //* On récupère le Json sur sembast
      final json = await ref.read(localDbProvider).getData('todolist');

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
          //* Vu que le case avec as ne marche pas on vérifie le type de chaque items
          if (todo is Map<String, dynamic>) {
            result.add(Todo.fromJson(todo));
          }
        }
      }

      return result;
    } catch (e) {
      throw AppException.unknownError();
    }
  }

  /// Pour ajouter un todo
  @override
  Future<void> setTodo(List<Todo> todos) async {
    try {
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
    } catch (e) {
      throw AppException.unknownError();
    }
  }

  /// Pour vider la todolist
  @override
  Future<void> cleanTodo() async {
    try {
      //* On vide la valeur todolist sur sembast
      ref.read(localDbProvider).setData('todolist', []);
    } catch (e) {
      throw AppException.unknownError();
    }
  }
}
