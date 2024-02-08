import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/qustion.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

/// страница ответа на справку
class AskQuestionPage extends StatefulWidget {
  const AskQuestionPage({super.key});

  @override
  State<AskQuestionPage> createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MainBloc bloc = Get.find<MainBloc>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  bool isLoading = false;

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  dispose() {
    nameController.dispose();
    emailController.dispose();
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 70, left: 12, right: 12),
          width: context.mediaQuerySize.width,
          height: context.mediaQuerySize.height - 100,
          color: AppColor.fon,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('Задать вопрос', style: AppText.captionText36Com),
                    const Gap(15),
                    LibFormField(
                      title: 'Заголовок вопроса',
                      controller: nameController,
                      hint: 'Введите заголовок вопроса',
                      validator: (value) => Utils.validateNotEmpty(
                          value, 'Введите заголовок вороса'),
                    ),
                    const Gap(10),
                    LibFormField(
                      title: 'Email',
                      controller: emailController,
                      hint: 'Введите email',
                      validator: (value) => Utils.validateEmail(
                          value, 'Введите правильный email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(10),
                    LibFormField(
                      title: 'Текст вопроса',
                      controller: questionController,
                      maxLines: 6,
                      // maxLength: 1000,
                      hint: 'Введите текст вопроса',
                      validator: (value) => Utils.validateNotEmpty(
                          value, 'Введите текст вопроса'),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Buttons.buttonFull(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Question question = Question.initial();
                              question.name = nameController.text;
                              question.email = emailController.text;
                              question.question = questionController.text;
                              setLoading(true);
                              await Get.find<MainRepository>()
                                  .addQuestion(question);
                              setLoading(false);
                              bloc.add(DeletePageEvent());
                            }
                          },
                          text: 'Отправить'),
                      const Gap(15),
                      Buttons.buttonOut(
                          onPressed: () => bloc.add(DeletePageEvent()),
                          text: 'Отмена'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
