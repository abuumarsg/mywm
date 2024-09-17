// import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
class SaldoModel extends Equatable {
  final String flag;
  final String nomorRekening;
  final String keterangan;
  final String saldoAkhir;
  final String? saldoTunggak;
  final String? saldoBlokir;
  final String? saldoEfektif;
  final String? tglJatuhtempo;
  final String? kodeBunga;
  final String? tglJatuhtempoIndo;
  final String? tglSekarangInisial;
  final String? textTambahan;
  final String? tambahanSaldo;

  const SaldoModel({
      required this.flag,
      required this.nomorRekening,
      required this.keterangan,
      required this.saldoAkhir,
      this.saldoTunggak,
      this.saldoBlokir,
      this.saldoEfektif,
      this.tglJatuhtempo,
      this.kodeBunga,
      this.tglJatuhtempoIndo,
      this.tglSekarangInisial,
      this.textTambahan,
      this.tambahanSaldo,
      });

  factory SaldoModel.fromJson(Map<String, dynamic> json) => SaldoModel(
        flag: json['flag'],
        nomorRekening: json['nomorRekening'],
        keterangan: json['keterangan'],
        saldoAkhir: json['saldoAkhir'],
        saldoTunggak: json['saldoTunggak']?.toString(),
        saldoBlokir: json['saldoBlokir']?.toString(),
        saldoEfektif: json['saldoEfektif']?.toString(),
        tglJatuhtempo: json['tglJatuhtempo']?.toString(),
        kodeBunga: json['kodeBunga']?.toString(),
        tglJatuhtempoIndo: json['tglJatuhtempoIndo']?.toString(),
        tglSekarangInisial: json['tglSekarangInisial']?.toString(),
        textTambahan: json['textTambahan']?.toString(),
        tambahanSaldo: json['tambahanSaldo']?.toString(),
      );

  @override
  List<Object?> get props =>
      [
        flag,
        nomorRekening,
        keterangan,
        saldoAkhir,
        saldoTunggak,
        saldoTunggak,
        saldoBlokir,
        saldoEfektif,
        tglJatuhtempo,
        kodeBunga,
        tglJatuhtempoIndo,
        tglSekarangInisial,
        textTambahan,
        tambahanSaldo,
      ];
}

class SaldoUtamaModel extends Equatable {
  final String flag;
  final String nomorRekening;
  final String keterangan;
  final String saldoAkhir;
  final String? saldoTunggak;
  final String? saldoBlokir;
  final String? saldoEfektif;
  final String? tglJatuhtempo;
  final String? kodeBunga;
  final String? tglJatuhtempoIndo;
  final String? tglSekarangInisial;
  final String? textTambahan;
  final String? tambahanSaldo;

  const SaldoUtamaModel({
      required this.flag,
      required this.nomorRekening,
      required this.keterangan,
      required this.saldoAkhir,
      this.saldoTunggak,
      this.saldoBlokir,
      this.saldoEfektif,
      this.tglJatuhtempo,
      this.kodeBunga,
      this.tglJatuhtempoIndo,
      this.tglSekarangInisial,
      this.textTambahan,
      this.tambahanSaldo,
      });

  factory SaldoUtamaModel.fromJson(Map<String, dynamic> json) => SaldoUtamaModel(
        flag: json['flag'],
        nomorRekening: json['nomorRekening'],
        keterangan: json['keterangan'],
        saldoAkhir: json['saldoAkhir'],
        saldoTunggak: json['saldoTunggak']?.toString(),
        saldoBlokir: json['saldoBlokir']?.toString(),
        saldoEfektif: json['saldoEfektif']?.toString(),
        tglJatuhtempo: json['tglJatuhtempo']?.toString(),
        kodeBunga: json['kodeBunga']?.toString(),
        tglJatuhtempoIndo: json['tglJatuhtempoIndo']?.toString(),
        tglSekarangInisial: json['tglSekarangInisial']?.toString(),
        textTambahan: json['textTambahan']?.toString(),
        tambahanSaldo: json['tambahanSaldo']?.toString(),
      );

  @override
  List<Object?> get props =>
      [
        flag,
        nomorRekening,
        keterangan,
        saldoAkhir,
        saldoTunggak,
        saldoTunggak,
        saldoBlokir,
        saldoEfektif,
        tglJatuhtempo,
        kodeBunga,
        tglJatuhtempoIndo,
        tglSekarangInisial,
        textTambahan,
        tambahanSaldo,
      ];
}