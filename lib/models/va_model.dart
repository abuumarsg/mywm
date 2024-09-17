// import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
class VAModel extends Equatable {
  // ignore: non_constant_identifier_names
  final String? NOAC_VIRTUAL;
  // ignore: non_constant_identifier_names
  final String? TGL_BUKA;
  // ignore: non_constant_identifier_names
  final String? KD_BANK;
  // ignore: non_constant_identifier_names
  final String? NAMA_BANK;

  const VAModel({
  // ignore: non_constant_identifier_names
      required this.NOAC_VIRTUAL,
  // ignore: non_constant_identifier_names
      required this.TGL_BUKA,
  // ignore: non_constant_identifier_names
      required this.KD_BANK,
  // ignore: non_constant_identifier_names
      required this.NAMA_BANK,
      });

  factory VAModel.fromJson(Map<String, dynamic> json) => VAModel(
        NOAC_VIRTUAL: json['NOAC_VIRTUAL'],
        TGL_BUKA: json['TGL_BUKA'],
        KD_BANK: json['KD_BANK'],
        NAMA_BANK: json['NAMA_BANK'],
      );

  @override
  List<Object?> get props =>
      [
        NOAC_VIRTUAL,
        TGL_BUKA,
        KD_BANK,
        NAMA_BANK,
      ];
}
