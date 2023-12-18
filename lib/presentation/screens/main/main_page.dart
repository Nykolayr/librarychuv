import 'package:flutter/material.dart';
import 'package:librarychuv/presentation/screens/main/app_bottom.dart';
import 'package:librarychuv/presentation/screens/main/pages.dart';
import 'package:librarychuv/presentation/theme/text.dart';
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
  MainPageType type = MainPageType.values[1];
  PageController pageController = PageController();

  @override
  void initState() {
    tabController =
        TabController(vsync: this, length: MainPageType.values.length);

    tabController.addListener(() {
      type = MainPageType.values[tabController.index];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MainPageType.values.length,
      child: Scaffold(
        appBar: const AppBarWithBackButton(isShow: false),
        bottomSheet: AppBottom(
            tabController: tabController, pageController: pageController),
        body: SafeArea(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              tabController.animateTo(index,
                  duration: const Duration(milliseconds: 500));
            },
            itemCount: MainPageType.values.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 15),
                        child: Text(
                          type.pageName,
                          style: AppText.text24rCom,
                        ),
                      ),
                      MainPageType.values[tabController.index].getPage,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
