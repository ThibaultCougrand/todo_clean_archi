import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_clean_archi/src/features/todo/application/providers/todo_providers.dart';
import 'package:todo_clean_archi/src/features/todo/domain/todo.dart';
import 'package:todo_clean_archi/src/features/todo/persistance/i_todo_repository.dart';

part 'toggle_checked_use_case.g.dart';

/// Use case qui contient la logique métier pour changer l'état checked d'un todo
class ToggleCheckedUseCase {
  ToggleCheckedUseCase(this.ref);

  final Ref ref;

  Future<void> execute(bool flag, int pos) async {
    final repo = ref.read(todoRepositoryProvider);
    final datas = ref.read(todoListProvider);

    //* On vérifie que la todolist est bien chargée
    if (datas.hasValue && datas.value != null) {
      final todoList = datas.value!;
      int index = 0;
      final List<Todo> finalList = [];

      //* On cherche l'élement todo qu'on a modifié
      for (Todo todo in todoList) {
        //* quand on le trouve on change sa valeur checked
        if (index == pos) {
          finalList.add(todo.copyWith(checked: flag));
        //* sinon on renvoie la valeur de base
        } else {
          finalList.add(todo);
        }
        index++;
      }

      //* On met à jour le répo (base de données sembast)
      await repo.setTodo(finalList);
      //* On met à jour le provider pour l'interface
      ref.read(todoListProvider.notifier).change(finalList);
    }
  }
}

@riverpod
ToggleCheckedUseCase toggleCheckedUseCase(ToggleCheckedUseCaseRef ref) {
  return ToggleCheckedUseCase(ref);
}
