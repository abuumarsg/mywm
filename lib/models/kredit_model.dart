import 'package:equatable/equatable.dart';
class KreditModel extends Equatable {
  final String atasNama;
  final String nomorRekening;
  final String nomorRekeningTabungan;
  final String namaJenis;
  final String plafon;
  final String bakiDebet;
  final String? kelonggaranTarik;
  final String? jenis;

  const KreditModel({
      required this.atasNama,
      required this.nomorRekening,
      required this.nomorRekeningTabungan,
      required this.namaJenis,
      required this.plafon,
      required this.bakiDebet,
      this.kelonggaranTarik,
      this.jenis,
      });

  factory KreditModel.fromJson(Map<String, dynamic> json) => KreditModel(
        atasNama: json['atasNama'],
        nomorRekening: json['nomorRekening'],
        nomorRekeningTabungan: json['nomorRekeningTabungan'],
        namaJenis: json['namaJenis'],
        plafon: json['plafon'],
        bakiDebet: json['bakiDebet'],
        kelonggaranTarik: json['kelonggaranTarik']?.toString(),
        jenis: json['jenis']?.toString(),
      );

  @override
  List<Object?> get props =>
      [
        atasNama,
        nomorRekening,
        nomorRekeningTabungan,
        namaJenis,
        plafon,
        bakiDebet,
        kelonggaranTarik,
        jenis,
      ];
}
