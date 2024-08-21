import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:flutter/material.dart';

// Bottomnavbar
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
    return Drawer(
      backgroundColor: AppLightColorConstants.bgLight,
      child: Padding(
        padding: context.onlyLeftPaddingLow,
        child: Column(
          children: [
            Padding(
              padding: context.onlyTopPaddingMedium,
              child: SizedBox(
                height: context.dynamicHeight(0.225),
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
            // List items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(
                      'Add friends',
                      style: context.textStyleGrey(context).copyWith(
                          color: AppLightColorConstants.bgInverse,
                          fontSize: 16),
                    ),
                  ),
                  context.sizedHeightBoxLow,
                  ListTile(
                    leading: const Icon(Icons.message),
                    title: Text(
                      'Messages',
                      style: context.textStyleGrey(context).copyWith(
                          color: AppLightColorConstants.bgInverse,
                          fontSize: 16),
                    ),
                  ),
                  context.sizedHeightBoxLow,
                  ListTile(
                    leading: const Icon(Icons.insert_chart),
                    title: Text(
                      'Statistics',
                      style: context.textStyleGrey(context).copyWith(
                          color: AppLightColorConstants.bgInverse,
                          fontSize: 16),
                    ),
                  ),
                  context.sizedHeightBoxLow,
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'Settings',
                      style: context.textStyleGrey(context).copyWith(
                          color: AppLightColorConstants.bgInverse,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Signout button
            Padding(
              padding: context.onlyBottomPaddingHigh,
              child: Padding(
                padding: context.onlyBottomPaddingHigh,
                child: CustomContinueButton(
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
  }
}