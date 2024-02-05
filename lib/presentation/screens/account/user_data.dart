import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/domain/models/user.dart';
import 'package:librarychuv/presentation/screens/account/image_user.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// данные пользователя
class UserData extends StatelessWidget {
  final User user;
  final Function()? onTap;
  const UserData({required this.user, this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageUser(),
        const Gap(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.firstName,
                style: AppText.button15b,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                user.lastName,
                style: AppText.button15b,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {},
                child: Text('Изменить пароль', style: AppText.text14r),
              ),
            ],
          ),
        ),
        const Gap(15),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/svg/edit.svg', height: 36),
        ),
      ],
    );
  }
}
