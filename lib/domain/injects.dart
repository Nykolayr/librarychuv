import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';

/// внедряем зависимости, чтобы можно было вызвать в любом месте приложения
Future initMaint() async {
  await Get.putAsync(() async {
    final userRepository = UserRepository();
    return userRepository;
  });
  Get.put<AuthBloc>(AuthBloc());
}
