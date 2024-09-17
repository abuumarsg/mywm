// import 'dart:convert';

import 'package:equatable/equatable.dart';
class ListBankModel extends Equatable {
  final String kodeBank;
  final String? namaBank;

  const ListBankModel({
      required this.kodeBank,
      this.namaBank,
      });

  Map<String, dynamic> toJson() {
    return {
      'kodeBank': kodeBank,
      'namaBank': namaBank,
    };
  }
  factory ListBankModel.fromJson(Map<String, dynamic> json) => ListBankModel(
        kodeBank: json['kodeBank'],
        namaBank: json['namaBank']?.toString(),
      );
  const ListBankModel.fromMap(Map<String, dynamic> map, this.kodeBank, this.namaBank);

  @override
  List<Object?> get props =>
      [
        namaBank,
        kodeBank,
      ];
}
