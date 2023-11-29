import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/application/use_cases/set_todo_use_case.dart';
import 'package:todo_clean_archi/src/features/todo/application/use_cases/toggle_checked_use_case.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'todo_controller.g.dart';

/// Controller de la page TodoPage, permet de gérer l'état de la page quand un utilisateur effectue une action
@riverpod
class TodoController extends _$TodoController {
  @override
  FutureOr<void> build() {}

  /// Pour ajouter un todo à la todolist
  Future<void> setTodo(String name) async {
    final useCase = ref.read(setTodoUseCaseProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => useCase.execute(name));
  }

  /// Pour changer l'attribut checked d'un todo
  Future<void> toggleChecked(bool flag, int pos) async {
    final useCase = ref.read(toggleCheckedUseCaseProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => useCase.execute(flag, pos));
  }

  /// Pour vider la todolist
  Future<void> cleanTodo() async {
    final repo = ref.read(todoRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.cleanTodo());
  }
}
