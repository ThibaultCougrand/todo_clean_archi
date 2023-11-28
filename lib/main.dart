import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_clean_archi/src/app.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/i_local_db.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/sembast/my_sembast.dart';

void main() async {
  ///* Initialisation des dépendances (infrastructure)
  final ILocalDb localDb = await MySembast.initDb();

  ///* Implémente les provider initialisés au lancement
  final container = ProviderContainer(
    overrides: [
      localDbProvider.overrideWithValue(localDb),
    ],
  );

  ///* Initialise la lecture des providers
  container.read(localDbProvider);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}
