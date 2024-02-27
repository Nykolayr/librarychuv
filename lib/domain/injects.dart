import 'package:dio/dio.dart';
import 'package:librarychuv/data/api/api.dart';
import 'package:librarychuv/data/api/dio_client.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:librarychuv/main.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';

/// внедряем зависимости, чтобы можно было вызвать в любом месте приложения
Future initMain() async {
  try {
    Get.put<DioClient>(DioClient(Dio()));
    Get.put<Api>(Api());
    await Get.putAsync(() async {
      final userRepository = UserRepository();
      await userRepository.init();
      return userRepository;
    });
    await Get.putAsync(() async {
      final mainRepository = MainRepository();
      await mainRepository.init();
      return mainRepository;
    });

    Get.put<MainBloc>(MainBloc());
    Get.put<AuthBloc>(AuthBloc());
  } on Exception catch (e) {
    error = e.toString();
  }
}
