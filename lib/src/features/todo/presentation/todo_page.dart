import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/features/todo/application/providers/todo_providers.dart';
import 'package:todo_clean_archi/src/features/todo/presentation/controllers/todo_controller.dart';

class TodoPage extends ConsumerWidget {
  final textController = TextEditingController();

  TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final controller = ref.read(todoControllerProvider.notifier);
    final state = ref.watch(todoControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'entrez un mot',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => state.isLoading
                        ? null
                        : controller.setTodo(textController.text),
                    child: const Text("Ajouter"),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        state.isLoading ? null : controller.cleanTodo(),
                    child: const Text("Clear"),
                  ),
                ],
              ),
              Expanded(
                child: todoList.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(data[index].name),
                          onTap: () => !state.isLoading
                              ? controller.toggleChecked(
                                  !data[index].checked, index)
                              : null,
                          tileColor:
                              data[index].checked ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  ),
                  error: (error, stackTrace) => Center(
                    child: SelectableText(error.toString()),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
