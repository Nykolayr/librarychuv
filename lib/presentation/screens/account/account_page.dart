import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/screens/account/user_data.dart';
import 'package:librarychuv/presentation/screens/account/widgets.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/theme.dart';
import 'package:librarychuv/presentation/widgets/buttons.dart';

/// страница событий
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  MainBloc bloc = Get.find<MainBloc>();
  User user = Get.find<UserRepository>().user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        // buildWhen: (previous, current) {},
        builder: (context, state) {
          return Container(
            alignment: Alignment.topCenter,
            width: context.mediaQuerySize.width,
            height: context.mediaQuerySize.height - 120,
            color: AppColor.fon,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          UserData(user: user),
                          const Gap(20),
                          DataNameUser(
                              title: 'Дата рождения:',
                              sub: Utils.getFormatDate(user.birthDate)),
                          DataNameUser(title: 'Роль:', sub: user.role),
                          DataNameUser(
                              title: 'Читательский билет:',
                              sub:
                                  'Активен до ${Utils.getFormatDate(user.ticketDate)}'),
                          // '${user.ticket}'),
                          const Gap(25),
                        ],
                      ),
                    ),
                    Column(children: [
                      Buttons.buttonFullWitImage(
                        text: 'Персональная книжная полка',
                        pathImage: 'assets/svg/shelf.svg',
                        onPressed: () => bloc.add(
                            const AddPageEvent(typePage: SecondPageType.shelf)),
                      ),
                      const Gap(10),
                      Buttons.buttonFullWitImage(
                        text: 'Виртуальная справка',
                        pathImage: 'assets/svg/help.svg',
                        onPressed: () => bloc.add(
                            const AddPageEvent(typePage: SecondPageType.help)),
                      ),
                      const Gap(10),
                      Buttons.buttonFullWitImage(
                        text: 'Читательский билет',
                        pathImage: 'assets/svg/ticket.svg',
                        onPressed: () => bloc.add(const AddPageEvent(
                            typePage: SecondPageType.ticket)),
                      ),
                      const Gap(10),
                      Buttons.buttonFullWitImage(
                        text: 'Корзина заказов',
                        pathImage: 'assets/svg/orders.svg',
                        onPressed: () => bloc.add(const AddPageEvent(
                            typePage: SecondPageType.orders)),
                      ),
                      const Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Buttons.buttonOut(
                            onPressed: () async {
                              await Get.find<UserRepository>().clearUser();
                              if (context.mounted) {
                                context.goNamed('Авторизация');
                              }
                            },
                            text: 'Выход'),
                      ),
                      const Gap(85),
                    ]),
                  ]),
            ),
          );
        });
  }
}
