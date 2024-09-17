class UserModel{
  String? id;
  String? name;
  String? kode;
  String? cif;
  String? email;
  String? nomorTelp;
  String? password;
  String? username;
  String? pin;
  String? token;
  String? kodelogin;
  String? profilePicture;
  String? createDate;
  String? flag;
  String? message;
  String? verificationOTP;

  UserModel({
    this.id,
    this.name,
    this.kode,
    this.cif,
    this.email,
    this.nomorTelp,
    this.password,
    this.username,
    this.pin,
    this.token,
    this.kodelogin,
    this.profilePicture,
    this.createDate,
    this.flag,
    this.message,
    this.verificationOTP,
  });
  
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    kode = json['kode'];
    email = json['email'];
    password = json['password'];
    username = json['username'];
    nomorTelp = json['nomorTelp'];
    pin = json['pin'];
    token = json['token'];
    cif = json['cif'];
    kodelogin = json['kodelogin'];
    profilePicture = json['profilePicture'];
    createDate = json['createDate'];
    flag = json['flag'];
    message = json['message'];
    verificationOTP = json['verificationOTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['kode'] = kode;
    data['email'] = email;
    data['password'] = password;
    data['username'] = username;
    data['nomorTelp'] = nomorTelp;
    data['pin'] = pin;
    data['token'] = token;
    data['cif'] = cif;
    data['kodelogin'] = kodelogin;
    data['profilePicture'] = profilePicture;
    data['createDate'] = createDate;
    data['flag'] = flag;
    data['message'] = message;
    data['verificationOTP'] = verificationOTP;
    return data;
  }


  UserModel copyWith({
    String? kode,
    String? cif,
    String? id,
    String? name,
    String? email,
    String? password,
    String? username,
    String? nomorTelp,
    String? pin,
    String? token,
    String? kodelogin,
    String? profilePicture,
    String? createDate,
    String? flag,
    String? message,
    String? verificationOTP,
  }) => UserModel(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      cif: cif ?? this.cif,
      username: username ?? this.username,
      name : name ?? this.name,
      email: email ?? this.email,
      nomorTelp: nomorTelp ?? this.nomorTelp,
      password: password ?? this.password,
      pin: pin ?? this.pin,
      token: token ?? this.token,
      kodelogin: kodelogin ?? this.kodelogin,
      profilePicture: profilePicture ?? this.profilePicture,
      createDate: createDate ?? this.createDate,
      flag: flag ?? this.flag,
      message: message ?? this.message,
      verificationOTP: verificationOTP ?? this.verificationOTP,
  );
}