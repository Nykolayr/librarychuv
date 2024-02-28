import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/screens/account/image_user.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

/// Редактирование профиля
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController roleController = TextEditingController();
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
    nameController.text = user.firstName;
    lastController.text = user.lastName;
    dateController.text = Utils.getFormatDate(user.birthDate);
    roleController.text = user.role;
    super.initState();
  }

  @override
  dispose() {
    nameController.dispose();
    lastController.dispose();
    dateController.dispose();
    roleController.dispose();
    super.dispose();
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
                      Column(
                        children: [
                          const ImageUser(),
                          GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              try {
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  setLoading(true);
                                  await Get.find<UserRepository>()
                                      .upLoadImage(image);
                                  setLoading(false);
                                }
                              } catch (e) {
                                Logger.e('Error picking image: $e');
                              }
                            },
                            child:
                                Text('Загрузить фото', style: AppText.text10r),
                          ),
                        ],
                      ),
                      const Gap(15),
                      Expanded(
                        child: Column(
                          children: [
                            LibFormField(
                              controller: nameController,
                              validator: (value) =>
                                  Utils.validateNotEmpty(value, 'Введите имя'),
                            ),
                            const Gap(10),
                            LibFormField(
                              controller: lastController,
                              validator: (value) => Utils.validateNotEmpty(
                                  value, 'Введите фамилию'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(15),
                  LibFormField(
                      readOnly: true,
                      controller: dateController,
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
                            dateController.text = Utils.getFormatDate(date);
                          });
                        }
                      }),
                  const Gap(15),
                  LibFormField(
                    controller: roleController,
                    hint: 'Роль',
                    title: 'Роль:',
                    validator: (value) =>
                        Utils.validateNotEmpty(value, 'Введите роль'),
                  ),
                ],
              ),
              Column(children: [
                Buttons.buttonFull(
                    width: context.mediaQuerySize.width - 20,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        user.firstName = nameController.text;
                        user.lastName = lastController.text;
                        user.role = roleController.text;
                        user.birthDate = Utils.parseDate(dateController.text);
                        setLoading(true);
                        await Get.find<UserRepository>().saveUser();
                        setLoading(false);
                      }
                      bloc.add(DeletePageEvent());
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
