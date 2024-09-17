// import 'dart:convert';

import 'package:equatable/equatable.dart';
class RekFavModel extends Equatable {
  final String id;
  final String kodeBank;
  final String? atasNama;
  final String? namaBank;
  final String? nomorRekening;

  const RekFavModel({
      required this.id,
      required this.kodeBank,
      this.atasNama,
      this.namaBank,
      this.nomorRekening,
      });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kodeBank': kodeBank,
      'atasNama': atasNama,
      'namaBank': namaBank,
      'nomorRekening': nomorRekening,
    };
  }
  factory RekFavModel.fromJson(Map<String, dynamic> json) => RekFavModel(
        id: json['id'],
        kodeBank: json['kodeBank'],
        atasNama: json['atasNama']?.toString(),
        namaBank: json['namaBank']?.toString(),
        nomorRekening: json['nomorRekening']?.toString(),
      );
  const RekFavModel.fromMap(Map<String, dynamic> map, this.id, this.kodeBank, this.atasNama, this.namaBank, this.nomorRekening);

  @override
  List<Object?> get props =>
      [
        id,
        kodeBank,
        atasNama,
        namaBank,
        nomorRekening,
      ];
}
