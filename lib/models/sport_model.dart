
import 'package:equatable/equatable.dart';
class Sports extends Equatable {
  final String? id;
  final String? name;

  Sports({
    this.id,
    this.name,
  });

  // factory Sports.fromJson(Map<String, dynamic> json) {
  //   return Sports(
  //     name: json['name'],
  //     age: json['age'],
  //   );
  // }
  factory Sports.fromJson(Map<String, dynamic> json) {
    return Sports(id: json['id'], name: json['name']);
  }
  
  @override
  List<Object?> get props =>
      [
        id,
        name,
      ];
}