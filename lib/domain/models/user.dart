class User {
  String id;
  String phone;
  String email;
  String password;
  String token;
  String refresh;
  bool isConfirmed;
  bool isActive;
  bool isSuperUser;
  int smsCountCheck;
  DateTime nextSmsAt;

  User({
    required this.id,
    required this.phone,
    required this.email,
    required this.password,
    required this.isConfirmed,
    required this.isActive,
    required this.isSuperUser,
    required this.token,
    required this.refresh,
    required this.smsCountCheck,
    required this.nextSmsAt,
  });
  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'] as String,
      phone: data['phone'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
      token: data['token'] as String,
      isConfirmed: data['isConfirmed'] as bool,
      isActive: data['isActive'] as bool,
      isSuperUser: data['isSuperUser'] as bool,
      refresh: data['refresh'] as String,
      smsCountCheck: data['sms_count_check'] as int,
      nextSmsAt: data['next_sms_at'] != null
          ? DateTime.parse(data['next_sms_at'] as String)
          : DateTime.now(),
    );
  }

  User copyWith({
    String? id,
    String? phone,
    String? email,
    String? password,
    String? token,
    String? refresh,
    bool? isConfirmed,
    bool? isActive,
    bool? isSuperUser,
    int? smsCountCheck,
    DateTime? nextSmsAt,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isActive: isActive ?? this.isActive,
      isSuperUser: isSuperUser ?? this.isSuperUser,
      refresh: refresh ?? this.refresh,
      smsCountCheck: smsCountCheck ?? this.smsCountCheck,
      nextSmsAt: nextSmsAt ?? this.nextSmsAt,
    );
  }

  factory User.initial() {
    return User(
      id: '',
      phone: '',
      email: '',
      password: '',
      isConfirmed: false,
      isActive: false,
      isSuperUser: false,
      token: '',
      refresh: '',
      smsCountCheck: 0,
      nextSmsAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
      'password': password,
      'isConfirmed': isConfirmed,
      'isActive': isActive,
      'isSuperUser': isSuperUser,
      'token': token,
      'refresh': refresh,
      'sms_count_check': smsCountCheck,
      'next_sms_at': nextSmsAt.toIso8601String(),
    };
  }
}
