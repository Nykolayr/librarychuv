import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

/// страница читательского билета
class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MainBloc bloc = Get.find<MainBloc>();
  User user = Get.find<UserRepository>().user;
  TextEditingController fioController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  initState() {
    fioController.text = user.ticket.fio;
    educationController.text = user.ticket.education;
    activityController.text = user.ticket.activity;
    birthDateController.text = Utils.getFormatDate(user.ticket.birthDate);
    passportController.text = user.ticket.passport;
    addressController.text = user.ticket.address;
    phoneController.text = user.ticket.phone;
    super.initState();
  }

  @override
  dispose() {
    fioController.dispose();
    educationController.dispose();
    activityController.dispose();
    birthDateController.dispose();
    passportController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.mediaQuerySize.width,
          height: context.mediaQuerySize.height - 240,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: AppColor.fon,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LibFormField(
                    controller: fioController,
                    hint: 'Заполните ФИО',
                    title: 'ФИО',
                    validator: (value) =>
                        Utils.validateNotEmpty(value, 'Введите ФИО'),
                  ),
                  const Gap(15),
                  LibFormField(
                    controller: educationController,
                    hint: 'Введите образование',
                    title: 'Образование',
                  ),
                  const Gap(15),
                  LibFormField(
                    controller: activityController,
                    hint: 'Введите сферу деятельности',
                    title: 'Сфера деятельности',
                  ),
                  const Gap(15),
                  LibFormField(
                      readOnly: true,
                      controller: birthDateController,
                      title: 'Дата рождения:',
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: user.birthDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            birthDateController.text =
                                Utils.getFormatDate(date);
                          });
                        }
                      }),
                  const Gap(15),
                  LibFormField(
                    controller: passportController,
                    hint: 'Введите паспортные данные',
                    title: 'Паспортные данные',
                    validator: (value) => Utils.validateNotEmpty(
                        value, 'Введите паспортные данные'),
                  ),
                  const Gap(15),
                  LibFormField(
                    controller: addressController,
                    hint: 'Введите адрес по месту проживания',
                    title: 'Адрес по месту проживания',
                    validator: (value) => Utils.validateNotEmpty(
                        value, 'Введите адрес по месту проживания'),
                  ),
                  const Gap(15),
                  LibFormField(
                    controller: phoneController,
                    hint: 'Введите номер телефона',
                    title: 'Номер телефона',
                    validator: (value) =>
                        Utils.validateNotEmpty(value, 'Введите номер телефона'),
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 90,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Buttons.buttonFull(
                width: context.mediaQuerySize.width - 20,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    user.ticket.fio = fioController.text;
                    user.ticket.education = educationController.text;
                    user.ticket.activity = activityController.text;
                    user.ticket.birthDate =
                        Utils.parseDate(birthDateController.text);
                    user.ticket.passport = passportController.text;
                    user.ticket.address = addressController.text;
                    user.ticket.phone = phoneController.text;
                    setLoading(true);
                    await Get.find<UserRepository>().saveUser();
                    setLoading(false);
                  }
                  bloc.add(DeletePageEvent());
                },
                text: 'Продолжить'),
          ),
        ),
        if (isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
