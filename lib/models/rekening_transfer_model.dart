import 'package:equatable/equatable.dart';
class RekeningForTransferModel extends Equatable {
  final String nomorRekening;
  final String nama;
  final String saldo;
  final String jenis;
  final String minimalTransfer;
  final String kuotaTransferGratis;

  const RekeningForTransferModel({
      required this.nomorRekening,
      required this.nama,
      required this.saldo,
      required this.jenis,
      required this.minimalTransfer,
      required this.kuotaTransferGratis,
      });

  factory RekeningForTransferModel.fromJson(Map<String, dynamic> json) => RekeningForTransferModel(
        nomorRekening: json['nomorRekening'],
        nama: json['nama'],
        saldo: json['saldo'],
        jenis: json['jenis'],
        minimalTransfer: json['minimalTransfer'],  
        kuotaTransferGratis: json['kuotaTransferGratis'],
      );

  @override
  List<Object?> get props =>
      [
        nomorRekening,
        nama,
        saldo,
        jenis,
        minimalTransfer,  
        kuotaTransferGratis,
      ];
}
