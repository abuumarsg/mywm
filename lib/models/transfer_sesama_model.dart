import 'package:equatable/equatable.dart';
class TransferSesamaModel extends Equatable {
  final String? nomorRekening;
  final String? nomorRekeningTujuan;
  final String? nominalPengirim;
  final String? nominalTransfer;
  final String? namaPenerima;
  final String? keterangan;
  final String? jenisTabunganPengirim;
  final String? biayaAdmin;
  final String? nomorSlip;
  final String? nomorTelp;

  const TransferSesamaModel({
      this.nomorRekening,
      this.nomorRekeningTujuan,
      this.nominalPengirim,
      this.nominalTransfer,
      this.namaPenerima,
      this.keterangan,
      this.jenisTabunganPengirim,
      this.biayaAdmin,
      this.nomorSlip,
      this.nomorTelp,
  });
  Map<String, dynamic> toJson(){
    return{
      'nomorRekening':nomorRekening,
      'nomorRekeningTujuan':nomorRekeningTujuan,
      'nominalPengirim':nominalPengirim,
      'nominalTransfer':nominalTransfer,
      'namaPenerima':namaPenerima,
      'keterangan':keterangan,
      'jenisTabunganPengirim':jenisTabunganPengirim,
      'biayaAdmin':biayaAdmin,
      'nomorSlip':nomorSlip,
      'nomorTelp':nomorTelp,
    };
  }

  factory TransferSesamaModel.fromJson(Map<String, dynamic> json) => TransferSesamaModel(
        nomorRekening: json['nomorRekening']?.toString(),
        nomorRekeningTujuan: json['nomorRekeningTujuan']?.toString(),
        nominalPengirim: json['nominalPengirim']?.toString(),
        nominalTransfer: json['nominalTransfer']?.toString(),
        namaPenerima: json['namaPenerima']?.toString(),
        keterangan: json['keterangan']?.toString(),
        jenisTabunganPengirim: json['jenisTabunganPengirim']?.toString(),
        biayaAdmin: json['biayaAdmin']?.toString(),
        nomorSlip: json['nomorSlip']?.toString(),
        nomorTelp: json['nomorTelp']?.toString(),
      );

  @override
  List<Object?> get props =>
    [
      nomorRekening,
      nomorRekeningTujuan,
      nominalPengirim,
      nominalTransfer,
      namaPenerima,
      keterangan,
      jenisTabunganPengirim,
      biayaAdmin,
      nomorSlip,
      nomorTelp,
    ];
}
