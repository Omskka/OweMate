import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomeNavbarWidget extends StatelessWidget {
  final String name;
  final String email;
  final String profileImageUrl;

  const HomeNavbarWidget({
    super.key,
    required this.name,
    required this.email,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
        } else if (maxHeight <= 700) {
          sizedboxHeight = context.dynamicHeight(0.29);
          heightBox = context.sizedHeightBoxLow;
          initialHeightBox = const SizedBox(
            height: 0,
          );
        } else if (maxHeight <= 800) {
          heightBox = context.sizedHeightBoxLow;
          sizedboxHeight = context.dynamicHeight(0.25);
          initialHeightBox = const SizedBox(
            height: 0,
          );
        } else if (maxHeight <= 1080) {
          sizedboxHeight = context.dynamicHeight(0.235);
          heightBox = context.sizedHeightBoxLow;
          initialHeightBox = const SizedBox(
            height: 0,
          );
          sizedboxHeight = context.dynamicHeight(0.21);
        } else {
          heightBox = context.sizedHeightBoxNormal;
          initialHeightBox = context.sizedHeightBoxLow;
          sizedboxHeight = context.dynamicHeight(0.165);
        }

        return Drawer(
          backgroundColor: ColorThemeUtil.getDrawerColor(context),
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
                                color:
                                    ColorThemeUtil.getBgInverseColor(context),
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
                        decoration: BoxDecoration(
                          color: ColorThemeUtil.getDrawerColor(context),
                        ),
                      ),
                    ),
                  ),
                ),
                // List items
                context.sizedHeightBoxLower,
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
                            color: ColorThemeUtil.getPrimaryColor(context)
                                .withOpacity(0.9),
                          ),
                          title: Text(
                            'Profile',
                            style: context.textStyleGrey(context).copyWith(
                                  color:
                                      ColorThemeUtil.getBgInverseColor(context),
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                      heightBox,
                      InkWell(
                        onTap: () {
                          context.router.push(const MessagesViewRoute());
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.message,
                            color: ColorThemeUtil.getPrimaryColor(context)
                                .withOpacity(0.9),
                          ),
                          title: Text(
                            'Messages',
                            style: context.textStyleGrey(context).copyWith(
                                color:
                                    ColorThemeUtil.getBgInverseColor(context),
                                fontSize: 16),
                          ),
                        ),
                      ),
                      heightBox,
                      InkWell(
                        onTap: () {
                          context.router.push(const StatisticsViewRoute());
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.insert_chart,
                            color: ColorThemeUtil.getPrimaryColor(context)
                                .withOpacity(0.9),
                          ),
                          title: Text(
                            'Statistics',
                            style: context.textStyleGrey(context).copyWith(
                                color:
                                    ColorThemeUtil.getBgInverseColor(context),
                                fontSize: 16),
                          ),
                        ),
                      ),
                      heightBox,
                      InkWell(
                        onTap: () {
                          context.router.push(
                            const SettingsViewRoute(),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: ColorThemeUtil.getPrimaryColor(context)
                                .withOpacity(0.9),
                          ),
                          title: Text(
                            'Settings',
                            style: context.textStyleGrey(context).copyWith(
                                color:
                                    ColorThemeUtil.getBgInverseColor(context),
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
