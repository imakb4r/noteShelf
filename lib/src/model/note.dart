// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';
part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  final String title;
  final String discription;
  final DateTime lastMod;
  Note({
    required this.id,
    required this.title,
    required this.discription,
    required this.lastMod,
  });

  Note copyWith({
    Id? id,
    String? title,
    String? discription,
    DateTime? lastMod,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      discription: discription ?? this.discription,
      lastMod: lastMod ?? this.lastMod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'discription': discription,
      'lastMod': lastMod.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'] as String,
      discription: map['discription'] as String,
      lastMod: DateTime.fromMillisecondsSinceEpoch(map['lastMod'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, discription: $discription, lastMod: $lastMod)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.discription == discription &&
      other.lastMod == lastMod;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      discription.hashCode ^
      lastMod.hashCode;
  }
}
