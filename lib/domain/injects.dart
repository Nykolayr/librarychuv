import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';

/// внедряем зависимости, чтобы можно было вызвать в любом месте приложения
Future initMaint() async {
  await Get.putAsync(() async {
    final userRepository = UserRepository();
    userRepository.init();
    return userRepository;
  });
  await Get.putAsync(() async {
    final mainRepository = MainRepository();
    mainRepository.init();
    return mainRepository;
  });
  Get.put<AuthBloc>(AuthBloc());
}
