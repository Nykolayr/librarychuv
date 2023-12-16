import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:surf_logger/surf_logger.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String errorMessage = '';
  bool isPasswordVisible = false;
  late AuthBloc bloc;

  @override
  void initState() {
    bloc = context.read<AuthBloc>();
    super.initState();
  }

  Future<void> submit() async {
    setState(() {
      _isLoading = true;
      errorMessage = '';
    });
    // Remove Keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      // var respAuth = await AuthRepository().auth('phone_number',
      //     Utils.normalizePhone('7${loginController.text}'), _passwordHash);
      const respAuth = '';
      if (respAuth != 'OK') {
        switch (respAuth) {
          case 'REQ_ERROR':
            setState(() {
              _isLoading = false;
              errorMessage = 'Ошибка при отправке запроса!';
            });
            return;
          case 'NO_USER':
            setState(() {
              _isLoading = false;
              errorMessage = 'Нет такого пользователя';
            });
            return;
          case 'BAD_PASSWORD':
            setState(() {
              _isLoading = false;
              errorMessage = 'Неправильный пароль!';
            });
            return;
        }
        return;
      }

      setState(() {
        FocusScope.of(context).unfocus();
        _isLoading = false;
        errorMessage = '';
      });
    } on Exception {
      setState(() {
        _isLoading = false;
        errorMessage = 'Непредвиденная ошибка';
      });
      log('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: bloc,
        buildWhen: (previous, current) {
          Logger.d('AuthPage >>> ${current.isSucsess}');
          if (current.isAuth && !current.isLoading) {
            while (context.canPop()) {
              context.pop();
            }
          }
          return false;
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(40),
                      const Text(
                        'Авторизация',
                        // style: AppText.displayText24,
                      ),
                      const Gap(25),
                      const Text(
                        'Для того чтобы войти в профиль — введите номер телефона или emil, а также пароль',
                        textAlign: TextAlign.center,
                        // style: Styles.subheadingGrey,
                      ),
                      const Gap(40),
                      // ClubTextFormField(
                      //   controller: loginController,
                      //   topLabel: 'Логин*',
                      //   hint: 'Введите ваш логин',
                      //   onChanged: (value) => () {},
                      //   validator: (value) =>
                      //       Utils.validateNotEmpty(value, 'Укажите логин'),
                      //   keyboardType: TextInputType.name,
                      //   subText: 'телефон в виде +7XXXXXXXXXX либо email',
                      // ),
                      const Gap(25),
                      // ClubTextFormField(
                      //   controller: passwordController,
                      //   obscureText: !isPasswordVisible,
                      //   keyboardType: isPasswordVisible
                      //       ? TextInputType.text
                      //       : TextInputType.visiblePassword,
                      //   topLabel: 'Пароль*',
                      //   onEditingComplete: submit,
                      //   hint: 'Введите пароль',
                      //   suffixIcon: IconVisible(
                      //       isVisible: isPasswordVisible,
                      //       onPressed: () {
                      //         isPasswordVisible = !isPasswordVisible;
                      //         setState(() {});
                      //       }),
                      //   validator: (value) =>
                      //       Utils.validateNotEmpty(value, 'Укажите пароль'),
                      // ),
                      const Gap(25),
                      if (_isLoading)
                        const CircularProgressIndicator.adaptive()
                      else
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 40),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // context.read<AuthBloc>().add(AuthUserEvent(
                              //       login: loginController.text,
                              //       pass: passwordController.text,
                              //     ));
                            }
                          },
                          child: const Text(
                            'Войти',
                          ),
                        ),
                      const Gap(25),
                      TextButton(
                          onPressed: () {
                            // context.go(
                            //     '/auth/${AuthPageType.passwordRecovery.name}');
                          },
                          child: const Text('Забыли пароль?')),
                      const Gap(25),
                      TextButton(
                          onPressed: () {
                            // context.go(
                            //     '/auth/${AuthPageType.enterPhoneNumber.name}');
                          },
                          child: const Text('Регистрация')),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
