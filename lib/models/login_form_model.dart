class SignInFormModel{
  final String? id;
  final String? username;
  final String? password;
  final String? cif;
  final String? name;
  final String? kode;
  final String? token;
  final String? verificationOTP;

  SignInFormModel({
    this.id,
    this.username,
    this.password,
    this.cif,
    this.name,
    this.kode,
    this.token,
    this.verificationOTP,
  });

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'username':username,
      'password':password,
      'cif':cif,
      'name':name,
      'kode':kode,
      'token':token,
      'verificationOTP':verificationOTP,
    };
  }
  factory SignInFormModel.fromJson(Map<String, dynamic> json) => SignInFormModel(
    id:json['id'],
    password:json['password'],
    username:json['username'],
    cif:json['cif'],
    name:json['name'],
    kode:json['kode'],
    token:json['token'],
    verificationOTP:json['verificationOTP'],
  );
  SignInFormModel copyWith({
    String? id,
    String? username,
    String? password,
    String? cif,
    String? name,
    String? kode,
    String? token,
    String? verificationOTP,
  }) => SignInFormModel(
    id: id ?? this.id,
    username: username,
    password: password ?? this.password,
    cif: cif ?? this.cif,
    name: name ?? this.name,
    kode: kode ?? this.kode,
    token: token ?? this.token,
    verificationOTP: verificationOTP ?? this.verificationOTP,
  );
}