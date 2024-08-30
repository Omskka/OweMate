import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:app_developments/core/widgets/custom_smaller_continue_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomeNavbarWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;

  const HomeNavbarWidget({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final maxHeight = constraints.maxHeight;

      // Determine height and width based on screen width
      double sizedboxHeight;
      SizedBox heightBox;
      SizedBox initialHeightBox;

      // Height
      if (maxHeight <= 600) {
        sizedboxHeight = context.dynamicHeight(0.35);
        heightBox = context.sizedHeightBoxLow;
        initialHeightBox = const SizedBox(
          height: 0,
        );
      } else if (maxHeight <= 800) {
        heightBox = context.sizedHeightBoxLow;
        sizedboxHeight = context.dynamicHeight(0.28);
        initialHeightBox = const SizedBox(
          height: 0,
        );
      } else if (maxHeight <= 1080) {
        heightBox = context.sizedHeightBoxLow;
        initialHeightBox = const SizedBox(
          height: 0,
        );
        sizedboxHeight = context.dynamicHeight(0.22);
      } else {
        heightBox = context.sizedHeightBoxNormal;
        initialHeightBox = context.sizedHeightBoxLow;
        sizedboxHeight = context.dynamicHeight(0.165);
      }

      return Drawer(
        backgroundColor: AppLightColorConstants.bgLight,
        child: Padding(
          padding: context.onlyLeftPaddingLow,
          child: Column(
            children: [
              Padding(
                padding: context.onlyTopPaddingMedium,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                  ),
                  child: SizedBox(
                    height: sizedboxHeight,
                    width: context.width,
                    child: UserAccountsDrawerHeader(
                      accountName: Text(
                        name,
                        style: context.textStyleGrey(context).copyWith(
                              fontSize: 24,
                              color: AppLightColorConstants.bgInverse,
                            ),
                      ),
                      accountEmail: Text(
                        email,
                        style: context.textStyleGrey(context).copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor:
                            AppLightColorConstants.contentTeritaryColor,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                      decoration: const BoxDecoration(
                        color: AppLightColorConstants.bgLight,
                      ),
                    ),
                  ),
                ),
              ),
              // List items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    initialHeightBox,
                    InkWell(
                      onTap: () {
                        context.router.push(const ProfileViewRoute());
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: AppLightColorConstants.primaryColor
                              .withOpacity(0.9),
                        ),
                        title: Text(
                          'profile',
                          style: context.textStyleGrey(context).copyWith(
                                color: AppLightColorConstants.bgInverse,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                    heightBox,
                    InkWell(
                      onTap: () {
                        CustomFlutterToast(
                          context: context,
                          msg: 'Under Construction',
                        ).flutterToast();
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.message,
                          color: AppLightColorConstants.primaryColor
                              .withOpacity(0.9),
                        ),
                        title: Text(
                          'Messages',
                          style: context.textStyleGrey(context).copyWith(
                              color: AppLightColorConstants.bgInverse,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    heightBox,
                    InkWell(
                      onTap: () {
                        CustomFlutterToast(
                          context: context,
                          msg: 'Under Construction',
                        ).flutterToast();
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.insert_chart,
                          color: AppLightColorConstants.primaryColor
                              .withOpacity(0.9),
                        ),
                        title: Text(
                          'Statistics',
                          style: context.textStyleGrey(context).copyWith(
                              color: AppLightColorConstants.bgInverse,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    heightBox,
                    InkWell(
                      onTap: () {
                        CustomFlutterToast(
                          context: context,
                          msg: 'Under Construction',
                        ).flutterToast();
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: AppLightColorConstants.primaryColor
                              .withOpacity(0.9),
                        ),
                        title: Text(
                          'Settings',
                          style: context.textStyleGrey(context).copyWith(
                              color: AppLightColorConstants.bgInverse,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Signout button
              Padding(
                padding: context.onlyBottomPaddingHigh,
                child: Padding(
                  padding: context.onlyBottomPaddingMedium,
                  child: CustomSmallerContinueButton(
                    buttonText: 'Sign Out',
                    icon: const Icon(Icons.logout),
                    borderRadius: BorderRadius.all(context.highRadius),
                    onPressed: () {
                      AuthenticationRepository().signOut(context: context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
