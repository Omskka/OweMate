import 'package:app_developments/app/views/view_friends/view_model/friends_event.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_state.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_view_model.dart';
import 'package:app_developments/app/views/view_friends/widgets/friends_page_widget.dart';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/app/views/view_home/widgets/home_drawer.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FriendsView extends StatelessWidget {
  const FriendsView({Key? key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = BlocProvider.of<HomeViewModel>(context);
    return BlocProvider(
      create: (context) => FriendsViewModel()..add(FriendsInitialEvent()),
      child: BlocBuilder<FriendsViewModel, FriendsState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppLightColorConstants.bgDark,
              appBar: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                title: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'OWE',
                            style: TextStyle(
                              color: AppLightColorConstants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              fontFamily: 'Barlow Semi Condensed bold',
                              shadows: [
                                Shadow(
                                  color: AppLightColorConstants.hueShadow
                                      .withOpacity(0.3), // Hue shadow color
                                  offset: const Offset(
                                      3.0, 0.0), // Offset to the right
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: 'MATE',
                            style: TextStyle(
                              color: AppLightColorConstants.thirdColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              fontFamily: 'Barlow Semi Condensed bold',
                              shadows: [
                                Shadow(
                                  color: AppLightColorConstants.hueShadow
                                      .withOpacity(0.3), // Hue shadow color
                                  offset: const Offset(
                                      3.0, 0.0), // Offset to the right
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      CustomFlutterToast(
                        context: context,
                        msg: 'Under Construction',
                      ).flutterToast();
                    },
                  ),
                ],
              ),
              drawer: HomeNavbarWidget(
                name: context.read<FriendsViewModel>().name,
                phoneNumber: context.read<FriendsViewModel>().phoneNumber,
                email: context.read<FriendsViewModel>().email,
                profileImageUrl:
                    context.read<FriendsViewModel>().profileImageUrl,
              ),
              // Hide navbar when drawer is opened
              onDrawerChanged: (isOpened) {
                isOpened
                    ? homeViewModel.add(HomeDrawerOpenedEvent())
                    : homeViewModel.add(HomeDrawerClosedEvent());
              },
              body: const FriendsPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
