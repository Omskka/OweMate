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
        viewModel.friendsSearchController.addListener(() {
          context
              .read<FriendsViewModel>()
              .add(FriendsSearchEvent(context: context));
        });
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            // Determine height and width based on screen width
            double textfieldWidth;
            double containerWidth;

            // Width
            if (maxWidth <= 600) {
              containerWidth = 0.75;
              textfieldWidth = context.dynamicWidth(0.6);
            } else if (maxWidth <= 800) {
              containerWidth = 0.65;
              textfieldWidth = context.dynamicWidth(0.55);
            } else if (maxWidth <= 900) {
              containerWidth = 0.6;
              textfieldWidth = context.dynamicWidth(0.5);
            } else if (maxWidth <= 1080) {
              containerWidth = 0.55;
              textfieldWidth = context.dynamicWidth(0.5);
            } else {
              containerWidth = 0.5;
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
                    width: context.dynamicWidth(containerWidth),
                    child: state is FriendsLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state.friends.isEmpty
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
                                                radius:
                                                    context.dynamicWidth(0.07),
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
                                              Expanded(
                                                child: Text(
                                                  state.friends[index]
                                                          ['Name'] ??
                                                      'Unknown User',
                                                  style: context
                                                      .textStyleGrey(context)
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color:
                                                            AppLightColorConstants
                                                                .bgInverse,
                                                      ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // set up the buttons
                                                  Widget cancelButton =
                                                      TextButton(
                                                    child: const Text(
                                                      "Cancel",
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Dismiss the dialog
                                                    },
                                                  );
                                                  Widget continueButton =
                                                      TextButton(
                                                    child: const Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                        color:
                                                            AppLightColorConstants
                                                                .errorColor,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              FriendsViewModel>()
                                                          .add(
                                                            FriendsRemoveFriendEvent(
                                                              context: context,
                                                              friendId:
                                                                  state.friends[
                                                                          index]
                                                                      [
                                                                      'userId']!,
                                                            ),
                                                          );
                                                      Navigator.of(context)
                                                          .pop(); // Dismiss the dialog
                                                    },
                                                  );

                                                  // set up the AlertDialog
                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    title: const Text(
                                                        "Remove Friend"),
                                                    content: Text(
                                                        "Are you sure you want to remove ${state.friends[index]['Name'] ?? 'Unknown User'} as a friend?"),
                                                    actions: [
                                                      cancelButton,
                                                      continueButton,
                                                    ],
                                                  );

                                                  // show the dialog
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                },
                                                child: Padding(
                                                  padding: context
                                                      .onlyRightPaddingNormal,
                                                  child:
                                                      const Icon(Icons.close),
                                                ),
                                              )
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
