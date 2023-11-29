import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/application/use_cases/set_todo_use_case.dart';
import 'package:todo_clean_archi/src/features/todo/application/use_cases/toggle_checked_use_case.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'todo_controller.g.dart';

@riverpod
class TodoController extends _$TodoController {
  @override
  FutureOr<void> build() {}

  Future<void> setTodo(String name) async {
    final useCase = ref.read(setTodoUseCaseProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => useCase.run(name));
  }

  Future<void> toggleChecked(bool flag, int pos) async {
    final useCase = ref.read(toggleCheckedUseCaseProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => useCase.run(flag, pos));
  }

  Future<void> cleanTodo() async {
    final repo = ref.read(todoRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.cleanTodo());
  }
}
