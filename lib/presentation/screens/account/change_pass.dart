import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/screens/account/image_user.dart';
import 'package:librarychuv/presentation/screens/account/sucsess_pass.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

/// смена пароля
class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  MainBloc bloc = Get.find<MainBloc>();
  User user = Get.find<UserRepository>().user;
  bool isLoading = false;

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    oldController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> showUpdatePassDoneDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => const UpdatePassDone(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: context.mediaQuerySize.width,
        height: context.mediaQuerySize.height - 120,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: AppColor.fon,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const ImageUser(),
                      const Gap(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.firstName,
                              style: AppText.captionText16b,
                              overflow: TextOverflow.ellipsis),
                          const Gap(10),
                          Text(user.lastName,
                              style: AppText.captionText16b,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ],
                  ),
                  const Gap(20),
                  Text('Смена пароля:', style: AppText.text24rCom),
                  const Gap(20),
                  LibFormField(
                    controller: oldController,
                    hint: 'Старый пароль',
                    obscureText: true,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Введите старый пароль';
                      }
                      if (value != null && value != user.password) {
                        return 'Неправильный пароль';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const Gap(15),
                  LibFormField(
                    controller: newController,
                    hint: 'пароль',
                    obscureText: true,
                    validator: (value) =>
                        Utils.validateNotEmpty(value, 'Введите новый пароль'),
                    keyboardType: TextInputType.name,
                  ),
                  const Gap(15),
                  LibFormField(
                    controller: confirmController,
                    hint: 'пароль',
                    obscureText: true,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Повторите новый пароль';
                      }
                      if (value != null && value != newController.text) {
                        return 'Пароли не совпадают';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ],
              ),
              Column(children: [
                Buttons.buttonFull(
                    width: context.mediaQuerySize.width - 20,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        user.password = newController.text;
                        setLoading(true);
                        await Get.find<UserRepository>().updatePass();
                        setLoading(false);

                        if (context.mounted) {
                          await showUpdatePassDoneDialog(context);
                        }
                        bloc.add(DeletePageEvent());
                      }
                    },
                    text: 'Сохранить'),
                const Gap(15),
                Buttons.buttonOut(
                    width: context.mediaQuerySize.width - 20,
                    onPressed: () => bloc.add(DeletePageEvent()),
                    text: 'Отмена'),
                const Gap(70),
              ])
            ],
          ),
        ),
      ),
      if (isLoading) const Center(child: CircularProgressIndicator()),
    ]);
  }
}
