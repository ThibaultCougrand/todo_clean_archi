import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

/// Un objet todo serialisé avec une class Freezed
@freezed
class Todo with _$Todo {

  factory Todo({
    required String name,
    required bool checked,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}