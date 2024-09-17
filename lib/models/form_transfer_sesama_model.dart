import 'package:equatable/equatable.dart';
class FormTransferSesamaModel extends Equatable {
  final String nomorRekening;
  final String nomorRekeningTujuan;
  final String nominalPengirim;
  final String nominalTransfer;
  final String? jenisTabunganPengirim;
  final String? keterangan;

  const FormTransferSesamaModel({
      required this.nomorRekening,
      required this.nomorRekeningTujuan,
      required this.nominalPengirim,
      required this.nominalTransfer,
      this.jenisTabunganPengirim,
      this.keterangan,
      });
  Map<String, dynamic> toJson(){
    return{
      'nomorRekening':nomorRekening,
      'nomorRekeningTujuan':nomorRekeningTujuan,
      'nominalPengirim':nominalPengirim,
      'nominalTransfer':nominalTransfer,
      'jenisTabunganPengirim':jenisTabunganPengirim,
      'keterangan':keterangan,
    };
  }

  factory FormTransferSesamaModel.fromJson(Map<String, dynamic> json) => FormTransferSesamaModel(
        nomorRekening: json['nomorRekening'],
        nomorRekeningTujuan: json['nomorRekeningTujuan'],
        nominalPengirim: json['nominalPengirim'],
        nominalTransfer: json['nominalTransfer'],
        jenisTabunganPengirim: json['jenisTabunganPengirim']?.toString(),
        keterangan: json['keterangan']?.toString(),
      );

  @override
  List<Object?> get props =>
    [
      nomorRekening,
      nomorRekeningTujuan,
      nominalPengirim,
      nominalTransfer,
      jenisTabunganPengirim,
      keterangan,
    ];
}
