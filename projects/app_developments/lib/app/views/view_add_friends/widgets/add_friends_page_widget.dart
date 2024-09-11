import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_event.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_state.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddFriendsPageWidget extends StatelessWidget {
  const AddFriendsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFriendsViewModel, AddFriendsState>(
        builder: (context, state) {
      final viewModel = BlocProvider.of<AddFriendsViewModel>(context);
      // Add listener to call event as user types
      viewModel.searchFriendsController.addListener(() {
        context.read<AddFriendsViewModel>().add(AddFriendsFetchAllUsersEvent());
      });
      // Determine height and width based on screen width
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      double textfieldWidth;
      // Width
      if (screenWidth <= 600) {
        textfieldWidth = context.dynamicWidth(0.6);
      } else if (screenWidth <= 800) {
        textfieldWidth = context.dynamicWidth(0.55);
      } else if (screenWidth <= 900) {
        textfieldWidth = context.dynamicWidth(0.5);
      } else if (screenWidth <= 1080) {
        textfieldWidth = context.dynamicWidth(0.5);
      } else {
        textfieldWidth = context.dynamicWidth(0.4);
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            BackButtonWithTitle(
              title: 'Add Friends',
              ontap: () {
                context.router.push(const FriendsViewRoute());
              },
            ),
            Center(
              child: SizedBox(
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.images.svg.friendsIcon),
                    context.sizedWidthBoxNormal,
                    CustomTextField(
                      hintTextColor:
                          AppLightColorConstants.contentTeritaryColor,
                      fillColor: AppLightColorConstants.infoColor,
                      icon: const Icon(
                        Icons.search,
                        color: AppLightColorConstants.contentTeritaryColor,
                      ),
                      removePadding: true,
                      width: textfieldWidth,
                      controller: viewModel.searchFriendsController,
                      hintText: 'Search User by Name',
                      outlineBorder: true,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.55),
              width: context.dynamicWidth(0.75),
              child: state.users.isEmpty
                  ? SizedBox(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(Assets.images.svg.magnifyingGlass),
                            Text(
                              'No results found',
                              style:
                                  context.textStyleGreyBarlow(context).copyWith(
                                        fontSize: 18,
                                        color: AppLightColorConstants
                                            .contentTeritaryColor,
                                        fontWeight: FontWeight.w100,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        String userId = state.users[index]['userId'] ?? '';

                        return FutureBuilder<bool>(
                          future: context
                              .read<AddFriendsViewModel>()
                              .isRequestSent(userId),
                          builder: (context, snapshot) {
                            // Determine if the request has been sent
                            final requestSent = snapshot.data ?? false;
                            final icon = requestSent
                                ? Icons.pending_actions_outlined
                                : Icons.add;

                            return InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () async {
                                context.read<AddFriendsViewModel>().add(
                                      AddFriendsToListEvent(
                                        index: index,
                                        context: context,
                                        userId: userId,
                                      ),
                                    );
                                // Optionally, you can trigger a rebuild or update
                              },
                              child: Padding(
                                padding: context.onlyTopPaddingNormal,
                                child: SizedBox(
                                  height: context.dynamicHeight(0.1),
                                  width: context.dynamicWidth(0.8),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: context.dynamicWidth(0.07),
                                        backgroundColor: AppLightColorConstants
                                            .contentTeritaryColor,
                                        backgroundImage: NetworkImage(
                                          state.users[index]
                                                  ['profileImageUrl'] ??
                                              '',
                                        ),
                                      ),
                                      context.sizedWidthBoxNormal,
                                      Text(
                                        state.users[index]['Name'] ??
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
                                      const Spacer(),
                                      Icon(icon),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            CustomContinueButton(
              buttonText: 'Invite Friends',
              onPressed: () {},
              icon: const Icon(Icons.mail),
            )
          ],
        ),
      );
    });
  }
}
