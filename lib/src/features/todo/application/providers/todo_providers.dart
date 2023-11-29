import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'todo_providers.g.dart';

/// Provider pour partager l'état stocké en cache de la todolist
@Riverpod(keepAlive: true)
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() {
    return init();
  }

  /// Initialise la valeur du provider pour la méthode build
  Future<List<Todo>> init() async {
    return ref.read(todoRepositoryProvider).fetchTodo();
  }

  /// Permet de changer la valeur du provider
  void change(List<Todo> todos) {
    state = AsyncValue.data(todos);
  }
}
