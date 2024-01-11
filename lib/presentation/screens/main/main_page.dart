import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:librarychuv/presentation/screens/main/app_bottom.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/widgets/app.dart';

/// общая страница, в которой можно переключаться между вкладками страницами
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  MainPageType type = MainPageType.values[0];
  MainBloc bloc = Get.find<MainBloc>();

  @override
  void initState() {
    tabController =
        TabController(vsync: this, length: MainPageType.values.length);

    tabController.addListener(() {
      Get.find<MainBloc>().add(DeletePageEvent());
      type = MainPageType.values[tabController.index];

      setState(() {});
    });
    super.initState();
  }

  @override
  dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<bool?> showBackDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение выхода'),
          content: const Text('Вы уверены, что хотите выйти из приложения?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
        bloc: bloc,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (didPop) {
                return;
              }
              if (state.isSecondPage) {
                bloc.add(DeletePageEvent());
                return;
              }
              final NavigatorState navigator = Navigator.of(context);
              final bool? shouldPop = await showBackDialog(context);
              if (shouldPop ?? false) {
                navigator.pop();
              }
            },
            child: DefaultTabController(
              length: MainPageType.values.length,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBarWithBackButton(
                  isShow: state.isSecondPage,
                  title: state.isSecondPage
                      ? state.typePages.last.page.appBarTitle
                      : type.pageName,
                  typePage: state.isSecondPage ? null : type,
                ),
                bottomSheet: AppBottom(
                  tabController: tabController,
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      TabBarView(
                        controller: tabController,
                        children: MainPageType.values.map((type) {
                          return state.isSecondPage
                              ? state.typePages.last.page.page
                              : type.getPage;
                        }).toList(),
                      ),
                      // Visibility(
                      //   visible: state.isSecondPage,
                      //   child: state.isSecondPage
                      //       ? state.typePages.last.page.page
                      //       : const SizedBox.shrink(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
