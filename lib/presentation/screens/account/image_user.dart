import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librarychuv/domain/repository/user_repository.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// изображение пользователя
class ImageUser extends StatelessWidget {
  const ImageUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.greyText,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: Get.find<UserRepository>().user.pathImage,
          fit: BoxFit.cover,
          placeholder: (context, url) => Image.asset(
            'assets/images/noimage.png',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/noimage.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
