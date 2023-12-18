import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/common/utils.dart';
import 'package:librarychuv/presentation/theme/colors.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';

class Carusel extends StatefulWidget {
  final List items;
  const Carusel({required this.items, super.key});

  @override
  State<Carusel> createState() => _CaruselState();
}

class _CaruselState extends State<Carusel> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 278.0,
            viewportFraction: 0.85,
            enableInfiniteScroll: false,
            initialPage: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: widget.items.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: AppDif.borderRadius10,
                    border: AppDif.borderCarusel,
                    boxShadow: [AppDif.boxShadowCarusel],
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              borderRadius: AppDif.borderRadius10,
                            ),
                            child: Image.asset(item.pathImage)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Utils.getFormatDateFull(item.date),
                                  style: AppText.text14bCom,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: Text(
                                    item.title,
                                    style: AppText.text14b,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  item.description,
                                  style: AppText.text12g,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]),
                        ),
                      ]),
                );
              },
            );
          }).toList(),
        ),
        const Gap(10),
        DotsIndicator(
          dotsCount: widget.items.length,
          position: currentIndex,
          decorator: const DotsDecorator(
            color: AppColor.greyCircle,
            activeColor: AppColor.redMain,
            size: Size.square(6.0),
            activeSize: Size(8.0, 8.0),
            spacing: EdgeInsets.all(5.0),
          ),
        ),
        const Gap(15),
      ],
    );
  }
}



