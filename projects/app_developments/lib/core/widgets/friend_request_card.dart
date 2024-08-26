import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FriendRequestCard extends StatelessWidget {
  final String profileImageUrl; // Add this to pass the profile image URL
  final String userName; // Add this to pass the user's name
  final VoidCallback onPressedAccept;
  final VoidCallback onPressedDecline;

  const FriendRequestCard({
    super.key,
    required this.profileImageUrl,
    required this.onPressedAccept,
    required this.onPressedDecline,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive variables
    double svgAssetWidth;

    // Height
    if (screenHeight <= 680) {
      // Small screens
    } else if (screenHeight <= 800) {
      // Small screens
    } else if (screenHeight <= 900) {
      // Medium screens
    } else if (screenHeight <= 1080) {
      // Medium screens
    } else {
      // Large screens
    }

    // Width
    if (screenWidth <= 600) {
      // very Small screens
      svgAssetWidth = 0.05;
    } else if (screenWidth <= 800) {
      // Small screens
      svgAssetWidth = 0.03;
    } else if (screenWidth <= 900) {
      // Medium screens
      svgAssetWidth = 0.025;
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      svgAssetWidth = 0.022;
    } else {
      // Large screens
      svgAssetWidth = 0.02;
    }
    return Container(
      height: context.dynamicHeight(0.1),
      width: context.dynamicWidth(1),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Padding(
            padding: context.onlyLeftPaddingMedium,
            child: CircleAvatar(
              radius:
                  context.dynamicHeight(0.035), // Adjust the size of the avatar
              backgroundImage:
                  NetworkImage(profileImageUrl), // Load the profile image
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: context.dynamicWidth(0.04)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName, // Display the user's name
                    style: context.textStyleTitleBarlow(
                        context), // Use your custom text style
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: onPressedAccept,
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.images.svg.addFriend,
                    width: context.dynamicWidth(svgAssetWidth),
                  ),
                  context.sizedWidthBoxLow,
                  const Text('Accept'),
                ],
              )),
          Padding(
            padding: context.onlyRightPaddingLow,
            child: InkWell(
              onTap: () {
                if (onPressedDecline != null) {
                  onPressedDecline();
                }
              },
              child: IconButton(
                icon: const Icon(Icons.close,
                    color: AppLightColorConstants
                        .contentTeritaryColor), // Decline button
                onPressed: () {
                  // Handle decline action
                  if (onPressedDecline != null) {
                    onPressedDecline();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
