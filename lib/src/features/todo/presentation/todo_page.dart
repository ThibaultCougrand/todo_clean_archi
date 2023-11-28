import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/features/todo/application/providers/todo_providers.dart';

class TodoPage extends ConsumerWidget {
  final controller = TextEditingController();

  TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'entrez un mot',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //words.add(controller.text);
                },
                child: const Text("Ajouter"),
              ),
              Expanded(
                child: todoList.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].name),
                        onTap: () => data[index].checked
                            ? print(data[index].name)
                            : null,
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
