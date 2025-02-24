import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/app.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/fon_picture.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

class AuthPassPage extends StatefulWidget {
  const AuthPassPage({super.key});

  @override
  State<AuthPassPage> createState() => _AuthPassPageState();
}

class _AuthPassPageState extends State<AuthPassPage> {
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthBloc authBloc = Get.find<AuthBloc>();

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWithBackButton(),
        body: BlocBuilder<AuthBloc, AuthState>(
            bloc: authBloc,
            buildWhen: (previous, current) {
              if (previous.isSucsess != current.isSucsess &&
                  current.isSucsess) {
                context.goNamed('Основная');
              }

              return true;
            },
            builder: (context, state) {
              return Stack(
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
                            Text('Авторизация',
                                style: AppText.captionText36Com),
                            const Gap(60),
                            LibFormField(
                              controller: passController,
                              hint: 'пароль',
                              obscureText: true,
                              validator: (value) => Utils.validateNotEmpty(
                                  value, 'Введите пароль'),
                              keyboardType: TextInputType.name,
                            ),
                            const Gap(20),
                            Buttons.buttonFull(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authBloc.add(AuthPassEvent(
                                        pass: passController.text));
                                  }
                                },
                                text: 'Продолжить'),
                            const Gap(70),
                            if (state.error.isNotEmpty)
                              Text('Неверный логин или пароль',
                                  style: AppText.text16r),
                            const Gap(40),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state.isLoading)
                    const Center(
                        child: CircularProgressIndicator.adaptive(
                            valueColor:
                                AlwaysStoppedAnimation(AppColor.redMain))),
                ],
              );
            }),
      ),
    );
  }
}
