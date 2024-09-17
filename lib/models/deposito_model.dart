import 'package:equatable/equatable.dart';
class DepositoModel extends Equatable {
  final String flag;
  final String nomorRekening;
  final String keterangan;
  final String saldoAkhir;
  final String? tglJatuhtempo;
  final String? kodeBunga;
  final String? tglJatuhtempoIndo;
  final String? tglSekarangInisial;

  const DepositoModel({
      required this.flag,
      required this.nomorRekening,
      required this.keterangan,
      required this.saldoAkhir,
      this.tglJatuhtempo,
      this.kodeBunga,
      this.tglJatuhtempoIndo,
      this.tglSekarangInisial,
      });

  factory DepositoModel.fromJson(Map<String, dynamic> json) => DepositoModel(
        flag: json['flag'],
        nomorRekening: json['nomorRekening'],
        keterangan: json['keterangan'],
        saldoAkhir: json['saldoAkhir'],
        tglJatuhtempo: json['tglJatuhtempo']?.toString(),
        kodeBunga: json['kodeBunga']?.toString(),
        tglJatuhtempoIndo: json['tglJatuhtempoIndo']?.toString(),
        tglSekarangInisial: json['tglSekarangInisial']?.toString(),
      );

  @override
  List<Object?> get props =>
      [
        flag,
        nomorRekening,
        keterangan,
        saldoAkhir,
        tglJatuhtempo,
        kodeBunga,
        tglJatuhtempoIndo,
        tglSekarangInisial,
      ];
}
