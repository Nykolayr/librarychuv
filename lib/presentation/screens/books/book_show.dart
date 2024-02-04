import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/presentation/screens/main/bloc/main_bloc.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// просмотр книги
class BookShow extends StatefulWidget {
  const BookShow({Key? key}) : super(key: key);

  @override
  State<BookShow> createState() => _BookShowState();
}

class _BookShowState extends State<BookShow> {
  bool isReading = false;
  late PDFViewController mainController;
  List<PDFViewController> controllers = [];
  int index = 0;
  int maxIndex = 0;
  int choosePdf = 0;
  MainBloc bloc = Get.find<MainBloc>();
  Book book = Get.find<MainBloc>().state.chooseItem as Book;
  Widget pdf = const SizedBox.shrink();
  @override
  initState() {
    super.initState();
  }

  setIndexPdf(int index) {
    setState(() {
      index = index;
      // mainController.setPage(index);
      // for (int i = 0; i < controllers.length; i++) {
      //   controllers[i].setPage(index + i);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuerySize.width,
      height: context.mediaQuerySize.height - 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: AppColor.fon,
      child: Stack(
        children: [
          getMainPdf(),
          if (isReading)
            Positioned(
              bottom: 76,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.stroke,
                  borderRadius: AppDif.borderRadius20,
                  boxShadow: [AppDif.boxShadowCarusel],
                ),
                height: 120,
                width: context.mediaQuerySize.width - 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, indexItem) {
                    return getPdf(indexItem);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget getMainPdf() {
    return PDF(
      onViewCreated: (PDFViewController controller) {
        mainController = controller;
        setState(() {
          // isReading = true;
        });
      },
      fitPolicy: FitPolicy.BOTH,
      onPageChanged: (indexThis, maxIndexThis) {
        if (maxIndexThis != maxIndex) maxIndex = maxIndexThis!;
        if (indexThis != index) setIndexPdf(indexThis!);
      },
    ).cachedFromUrl(
      book.url,
      placeholder: (progress) => Center(child: Text('$progress %')),
      errorWidget: (error) => Center(child: Text(error.toString())),
    );
  }

  Widget getSecondarypdf(int indexCon) {
    return PDF(
      enableSwipe: false,
      onViewCreated: (PDFViewController controller) {
        controllers[indexCon] = controller;
      },
      defaultPage: index + indexCon,
      fitPolicy: FitPolicy.HEIGHT,
    ).cachedFromUrl(book.url);
  }

  Widget getPdf(int indexCon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      width: MediaQuery.of(context).size.width / 5 - 24,
      child: getSecondarypdf(indexCon),
    );
  }
}
