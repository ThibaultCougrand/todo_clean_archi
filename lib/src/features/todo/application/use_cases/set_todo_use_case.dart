import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/application/providers/todo_providers.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'set_todo_use_case.g.dart';

class SetTodoUseCase {
  SetTodoUseCase(this.ref);

  final Ref ref;

  Future<void> run(String name) async {
    final repo = ref.read(todoRepositoryProvider);

    final datas = ref.read(todoListProvider);
    if (datas.hasValue) {
      final todoList = datas.value!;
      todoList.add(Todo(name: name, checked: false));
      await repo.setTodo(todoList);
      ref.read(todoListProvider.notifier).change(todoList);
    }
  }
}

@riverpod
SetTodoUseCase setTodoUseCase(SetTodoUseCaseRef ref) {
  return SetTodoUseCase(ref);
}
