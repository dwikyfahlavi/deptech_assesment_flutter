class CutiPegawai {
  final int? id;
  final int? idPegawai;
  final String? reason;
  final String? startCuti;
  final String? finishCuti;
  final String? firstName;
  final String? lastName;

  CutiPegawai(
      {this.id,
      required this.idPegawai,
      required this.reason,
      required this.startCuti,
      required this.finishCuti,
      this.firstName,
      this.lastName});

  factory CutiPegawai.fromMap(Map<String, dynamic> json) => CutiPegawai(
        id: json['id'],
        idPegawai: json['id_pegawai'],
        reason: json['reason'],
        startCuti: json['start_cuti'],
        finishCuti: json['finish_cuti'],
        firstName: json['first_name'],
        lastName: json['last_name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_pegawai': idPegawai,
      'reason': reason,
      'start_cuti': startCuti,
      'finish_cuti': finishCuti,
    };
  }
}
