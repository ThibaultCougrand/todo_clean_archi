import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:todo_clean_archi/src/infrastructure/local_db/i_local_db.dart';

class MySembast implements ILocalDb {
  MySembast(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<Database> _openDb() async {
      //* On récupère le path du dossier de l'application avec path_provider
      //! seulement sur mobile
      final appDocDir = await getApplicationDocumentsDirectory();

      //* Ouverture du fichier de database (création si première fois)
      return databaseFactoryIo.openDatabase('${appDocDir.path}/homeasier.db');
  }

  /// Initialisation de la database
  static Future<MySembast> initDb() async {
    return MySembast(await _openDb());
  }

  /// Pour récupérer un jeu de données
  @override
  Future getData(String key) async {
    return await store.record(key).get(db);
  }

  /// Pour écrire un jeu de données
  @override
  Future<void> setData(String key, data) {
    return store.record(key).put(db, data);
  }

  /// Pour récupérer le stream d'un jeu de données
  @override
  Stream watchData(String key) {
    return store.record(key).onSnapshot(db);
  }
}
