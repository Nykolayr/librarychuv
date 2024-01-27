import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/news.dart';
import 'package:librarychuv/domain/repository/main_repository.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/news/subscrable_done.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';
import 'package:librarychuv/presentation/widgets/lines_dot.dart';
import 'package:librarychuv/presentation/widgets/textfields.dart';

/// страница объявлений
class NewsSubscribePage extends StatefulWidget {
  const NewsSubscribePage({Key? key}) : super(key: key);

  @override
  State<NewsSubscribePage> createState() => _NewsSubscribePageState();
}

class _NewsSubscribePageState extends State<NewsSubscribePage> {
  TextEditingController mailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<SubjectNews> subjectNews = Get.find<MainRepository>().subjectNews;
  List<bool> listSub = [];
  @override
  void initState() {
    listSub = List.generate(subjectNews.length, (index) => false);
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    mailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          width: context.mediaQuerySize.width,
          height: context.mediaQuerySize.height - 120,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: AppDif.borderRadius10,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(20),
                      Text('Подписаться новостную на рассылку',
                          style: AppText.button15b),
                      const Gap(24),
                      LibFormField(
                        controller: mailController,
                        hint: 'Введите email',
                        onChanged: (value) => () {},
                        validator: (value) => Utils.validateEmail(
                            value, 'Введите правильный email'),
                        keyboardType: TextInputType.name,
                      ),
                      const Gap(34),
                      Text('Выберите тематику', style: AppText.captionText14b),
                      const Gap(15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: AppDif.borderRadius10,
                          border: AppDif.borderSearcch,
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          for (int index = 0;
                              index < subjectNews.length;
                              index++)
                            getSubNews(subjectNews[index], index),
                        ]),
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Buttons.buttonFull(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const SubscrableDone());
                        Get.find<MainBloc>().add(DeletePageEvent());
                      }
                    },
                    text: 'Подписаться'),
                const Gap(120),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getSubNews(SubjectNews item, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          listSub[index] = !listSub[index];
        });
      },
      child: Row(
        children: [
          Expanded(child: LinesWithDot(text: item.name, isTitle: true)),
          Icon(
            !listSub[index] ? Icons.remove : Icons.add,
            color: AppColor.redMain,
            size: 20,
            weight: 100,
          ),
        ],
      ),
    );
  }
}
