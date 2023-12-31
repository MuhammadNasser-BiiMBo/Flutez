import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.68,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const ContinuousRectangleBorder(),
      key: _key,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWidget(
                    onPressed: () {
                      context.pop();
                    },
                    iconAsset: Assets.exitIcon,
                    size: 20.r,
                  ),
                  IconWidget(
                    onPressed: () {},
                    iconAsset: Assets.moonIcon,
                    size: 20.r,
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              DrawerItem(
                icon: Assets.userIcon,
                label: "Profile",
                onPressed: () {
                  context.pushNamed(Routes.profile);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              DrawerItem(
                icon: Assets.heartIcon,
                label: "Liked Songs",
                onPressed: () {
                  // context.pop();
                  context.pushNamed(Routes.likedSongs);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              DrawerItem(
                icon: Assets.languageIcon,
                label: "Language",
                onPressed: () {},
              ),
              SizedBox(
                height: 10.h,
              ),
              DrawerItem(
                icon: Assets.contactUsIcon,
                label: "Contact us",
                onPressed: () {},
              ),
              SizedBox(
                height: 10.h,
              ),
              DrawerItem(
                icon: Assets.fAQIcon,
                label: "FAQs",
                onPressed: () {},
              ),
              SizedBox(
                height: 10.h,
              ),
              DrawerItem(
                icon: Assets.settingsIcon,
                label: "Settings",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
