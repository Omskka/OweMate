import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_event.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_state.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FriendsPageWidget extends StatelessWidget {
  const FriendsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsViewModel, FriendsState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<FriendsViewModel>(context);
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            // Determine height and width based on screen width
            double textfieldWidth;

            // Width
            if (maxWidth <= 600) {
              textfieldWidth = context.dynamicWidth(0.6);
            } else if (maxWidth <= 800) {
              textfieldWidth = context.dynamicWidth(0.55);
            } else if (maxWidth <= 900) {
              textfieldWidth = context.dynamicWidth(0.5);
            } else if (maxWidth <= 1080) {
              textfieldWidth = context.dynamicWidth(0.5);
            } else {
              textfieldWidth = context.dynamicWidth(0.4);
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  context.sizedHeightBoxLow,
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: context.dynamicWidth(0.2),
                            right: context.dynamicWidth(0.06),
                          ),
                          child: const Divider(
                            color: AppLightColorConstants.contentDisabled,
                            height: 36,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Friends',
                          style: context.textStyleGrey(context).copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppLightColorConstants.bgInverse,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: context.dynamicWidth(0.06),
                            right: context.dynamicWidth(0.2),
                          ),
                          child: const Divider(
                            color: AppLightColorConstants.contentDisabled,
                            height: 36,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  context.sizedHeightBoxLower,
                  Center(
                    child: SizedBox(
                      height: context.dynamicHeight(0.1),
                      width: context.dynamicWidth(
                          1), // or context.dynamicWidth(0.8) to leave some margin
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.images.svg.friendsIcon),
                          context.sizedWidthBoxNormal,
                          CustomTextField(
                            fillColor: AppLightColorConstants.infoColor,
                            hintTextColor:
                                AppLightColorConstants.contentTeritaryColor,
                            icon: const Icon(
                              Icons.search,
                              color:
                                  AppLightColorConstants.contentTeritaryColor,
                            ),
                            removePadding: true,
                            width: textfieldWidth,
                            controller: viewModel.friendsSearchController,
                            hintText: 'Search Friends',
                            outlineBorder: true,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                  ),
                  context.sizedHeightBoxLower,
                  SizedBox(
                    height: context.dynamicHeight(0.4),
                    width: context.dynamicWidth(0.75),
                    child: state.friends.isEmpty
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                'No Friends found',
                                style: context
                                    .textStyleTitleBarlow(context)
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          )
                        : Scrollbar(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.friends.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  // remove splash effect
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {},
                                  child: Padding(
                                    padding: context.onlyTopPaddingNormal,
                                    child: SizedBox(
                                      height: context.dynamicHeight(0.1),
                                      width: context.dynamicWidth(0.8),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: context.dynamicWidth(0.07),
                                            backgroundColor:
                                                AppLightColorConstants
                                                    .contentTeritaryColor,
                                            backgroundImage: NetworkImage(
                                              state.friends[index]
                                                      ['profileImageUrl'] ??
                                                  '', // Use index to get the correct user
                                            ),
                                          ),
                                          context.sizedWidthBoxNormal,
                                          Text(
                                            state.friends[index]['Name'] ??
                                                'Unknown User',
                                            style: context
                                                .textStyleGrey(context)
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: AppLightColorConstants
                                                      .bgInverse,
                                                ),
                                          ),
                                          context.sizedWidthBoxHigh,
                                          context.sizedWidthBoxHigh,
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                  context.sizedHeightBoxNormal,
                  CustomContinueButton(
                    buttonText: 'Add Friend',
                    onPressed: () {
                      context.router.push(const AddFriendsViewRoute());
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
