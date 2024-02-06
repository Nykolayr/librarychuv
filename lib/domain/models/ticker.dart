class Ticket {
  String fio;
  String education;
  String activity;
  DateTime birthDate;
  String passport;
  String address;
  String phone;

  Ticket({
    required this.fio,
    required this.education,
    required this.activity,
    required this.birthDate,
    required this.passport,
    required this.address,
    required this.phone,
  });

  factory Ticket.fromJson(Map<String, dynamic> data) => Ticket(
        fio: data['fio'] as String,
        education: data['education'] as String,
        activity: data['activity'] as String,
        birthDate: DateTime.parse(data['birthDate']),
        passport: data['passport'] as String,
        address: data['address'] as String,
        phone: data['phone'] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      'fio': fio,
      'education': education,
      'activity': activity,
      'birthDate': birthDate.toIso8601String(),
      'passport': passport,
      'address': address,
      'phone': phone,
    };
  }

  factory Ticket.initial() {
    return Ticket(
      fio: '',
      education: '',
      activity: '',
      birthDate: DateTime.now(),
      passport: '',
      address: '',
      phone: '',
    );
  }
}
