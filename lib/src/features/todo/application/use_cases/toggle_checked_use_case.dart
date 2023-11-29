import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/application/providers/todo_providers.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'toggle_checked_use_case.g.dart';

class ToggleCheckedUseCase {
  ToggleCheckedUseCase(this.ref);

  final Ref ref;

  Future<void> execute(bool flag, int pos) async {
    final repo = ref.read(todoRepositoryProvider);

    final datas = ref.read(todoListProvider);
    datas.whenData((todoList) async {
      int index = 0;
      final List<Todo> finalList = [];
      for (Todo todo in todoList) {
        if (index == pos) {
          finalList.add(todo.copyWith(checked: flag));
        } else {
          finalList.add(todo);
        }
        index++;
      }


      await repo.setTodo(finalList);
      ref.read(todoListProvider.notifier).change(finalList);
    });
  }
}

@riverpod
ToggleCheckedUseCase toggleCheckedUseCase(ToggleCheckedUseCaseRef ref) {
  return ToggleCheckedUseCase(ref);
}
