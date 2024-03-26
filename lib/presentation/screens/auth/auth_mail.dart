import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:librarychuv/presentation/theme/text.dart';
import 'package:librarychuv/presentation/widgets/app.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/fon_picture.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

class AuthMailPage extends StatefulWidget {
  const AuthMailPage({super.key});

  @override
  State<AuthMailPage> createState() => _AuthMailPageState();
}

class _AuthMailPageState extends State<AuthMailPage> {
  final loginController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthBloc authBloc = Get.find<AuthBloc>();

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWithBackButton(),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            const FonPicture(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: context.mediaQuerySize.width,
              height: context.mediaQuerySize.height,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(50),
                      SvgPicture.asset('assets/svg/logo.svg', width: 118),
                      const Gap(60),
                      Text('Авторизация', style: AppText.captionText36Com),
                      const Gap(60),
                      LibFormField(
                        controller: loginController,
                        hint: 'E-mail',
                        onChanged: (value) => () {},
                        validator: (value) => Utils.validateEmail(
                            value, 'Введите правильный логин'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(20),
                      Buttons.buttonFull(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authBloc.add(AuthLoginEvent(
                                  login: loginController.text.toLowerCase()));
                              context.goNamed('Авторизация пароль');
                            }
                          },
                          text: 'Продолжить'),
                      const Gap(70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child:
                                Text('Забыли пароль?', style: AppText.text14r),
                          ),
                          const Gap(20),
                          GestureDetector(
                            onTap: () {},
                            child: Text('Восстановить', style: AppText.text14r),
                          ),
                        ],
                      ),
                      const Gap(40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
