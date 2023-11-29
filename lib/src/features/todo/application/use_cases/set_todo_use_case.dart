import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/application/providers/todo_providers.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'set_todo_use_case.g.dart';

/// Use case qui contient la logique métier pour ajouter un todo à la liste
class SetTodoUseCase {
  SetTodoUseCase(this.ref);

  final Ref ref;

  Future<void> execute(String name) async {
    final repo = ref.read(todoRepositoryProvider);
    final datas = ref.read(todoListProvider);

    //* On vérifie que la todolist est bien chargée
    if (datas.hasValue && datas.value != null) {
      final todoList = datas.value!;

      //* On ajoute un nouveau todo à la liste
      todoList.add(Todo(name: name, checked: false));

      //* On met à jour le répo (base de données sembast)
      await repo.setTodo(todoList);
      //* On met à jour le provider pour l'interface
      ref.read(todoListProvider.notifier).change(todoList);
    }
  }
}

@riverpod
SetTodoUseCase setTodoUseCase(SetTodoUseCaseRef ref) {
  return SetTodoUseCase(ref);
}
