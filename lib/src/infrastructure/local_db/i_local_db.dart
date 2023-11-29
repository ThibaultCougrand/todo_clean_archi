import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'i_local_db.g.dart';

/// Class de gestion de la base de données locale du projet, dans ce cas implémenté avec sembast
abstract class ILocalDb {
  Future<dynamic> getData(String key);
  Future<void> setData(String key, Object data);
  Stream<dynamic> watchData(String key);
}

@Riverpod(keepAlive: true)
ILocalDb localDb(LocalDbRef ref) {
  //* On initialise le provider dans la méthode main
  throw UnimplementedError();
}