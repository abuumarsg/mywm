import 'package:equatable/equatable.dart';
class DataRiwayatTransaksi extends Equatable {
  final String nomorRekening;
  final String namaBankTujuan;
  final String nominal;
  final String? tanggal;
  final String? rekeningTujuan;
  final String? atasNamaTujuan;
  final String? biayaAdmin;
  final String? nominalBiayaAdmin;
  final String? flag;
  final String? nomorSlip;
  final String? kodePbk;
  final String? berita;
  final String? waktuTransaksi;
  final String? biayaAdminSlip;
  final String? norefId;
  final String? namaSumber;

  const DataRiwayatTransaksi({
      required this.nomorRekening,
      required this.namaBankTujuan,
      required this.nominal,
      this.tanggal,
      this.rekeningTujuan,
      this.atasNamaTujuan,
      this.biayaAdmin,
      this.nominalBiayaAdmin,
      this.flag,
      this.nomorSlip,
      this.kodePbk,
      this.berita,
      this.waktuTransaksi,
      this.biayaAdminSlip,
      this.norefId,
      this.namaSumber,
      });

  factory DataRiwayatTransaksi.fromJson(Map<String, dynamic> json) => DataRiwayatTransaksi(
        nomorRekening: json['nomorRekening'],
        namaBankTujuan: json['namaBankTujuan'],
        nominal: json['nominal'],
        tanggal: json['tanggal']?.toString(),
        rekeningTujuan: json['rekeningTujuan']?.toString(),
        atasNamaTujuan: json['atasNamaTujuan']?.toString(),
        biayaAdmin: json['biayaAdmin']?.toString(),
        nominalBiayaAdmin: json['nominalBiayaAdmin']?.toString(),
        flag: json['flag']?.toString(),
        nomorSlip: json['nomorSlip']?.toString(),
        kodePbk: json['kodePbk']?.toString(),
        berita: json['berita']?.toString(),
        waktuTransaksi: json['waktuTransaksi']?.toString(),
        biayaAdminSlip: json['biayaAdminSlip']?.toString(),
        norefId: json['norefId']?.toString(),
        namaSumber: json['namaSumber']?.toString(),
      );

  @override
  List<Object?> get props =>
    [
      nomorRekening,
      namaBankTujuan,
      nominal,
      tanggal,
      rekeningTujuan,
      atasNamaTujuan,
      biayaAdmin,
      nominalBiayaAdmin,
      flag,
      nomorSlip,
      kodePbk,
      berita,
      waktuTransaksi,
      biayaAdminSlip,
      norefId,
      namaSumber,
    ];
}
