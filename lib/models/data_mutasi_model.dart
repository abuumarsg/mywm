import 'package:equatable/equatable.dart';
class DataMutasiModel extends Equatable {
  final String nomorRekening;
  final String keterangan;
  final String nominal;
  final String? tanggal;
  final String? jenis;

  const DataMutasiModel({
      required this.nomorRekening,
      required this.keterangan,
      required this.nominal,
      this.tanggal,
      this.jenis,
      });

  factory DataMutasiModel.fromJson(Map<String, dynamic> json) => DataMutasiModel(
        nomorRekening: json['nomorRekening'],
        keterangan: json['keterangan'],
        nominal: json['nominal'],
        tanggal: json['tanggal']?.toString(),
        jenis: json['jenis']?.toString(),
      );

  @override
  List<Object?> get props =>
    [
      nomorRekening,
      keterangan,
      nominal,
      tanggal,
      jenis,
    ];
}
