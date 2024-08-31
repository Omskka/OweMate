import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_event.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_state.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_view_model.dart';
import 'package:app_developments/app/views/view_activity/widgets/activity_page_widget.dart';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/app/views/view_home/widgets/home_drawer.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityViewModel()..add(ActivityInitialEvent()),
      child: BlocBuilder<ActivityViewModel, ActivityState>(
        builder: (context, state) {
          final homeViewModel = context.read<HomeViewModel>();
          int requestNumber = HomeViewModel().fetchRequestNumber(
            state.requestNumber,
          );
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
                  Padding(
                    padding: context.onlyRightPaddingLow,
                    child: requestNumber != 0
                        ? GestureDetector(
                            onTap: () {
                              context.router
                                  .push(const NotificationsViewRoute());
                            },
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Stack(
                                children: [
                                  const Icon(
                                    Icons.notifications,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.topRight,
                                    margin: const EdgeInsets.only(top: 2.7),
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              AppLightColorConstants.errorColor,
                                          border: Border.all(
                                              color: Colors.white, width: 1)),
                                      child: Center(
                                          /* child: Text(
                                          '${state.requestNumber.length}',
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                fontSize: 10,
                                                color: AppLightColorConstants
                                                    .bgDark,
                                              ),
                                        ), */
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              context.router
                                  .push(const NotificationsViewRoute());
                            },
                            child: const Icon(Icons.notifications),
                          ),
                  ),
                ],
              ),
              drawer: HomeNavbarWidget(
                name: context.read<ActivityViewModel>().name,
                phoneNumber: context.read<ActivityViewModel>().phoneNumber,
                email: context.read<ActivityViewModel>().email,
                profileImageUrl:
                    context.read<ActivityViewModel>().profileImageUrl,
              ),
              // Hide navbar when drawer is opened
              onDrawerChanged: (isOpened) {
                isOpened
                    ? homeViewModel.add(HomeDrawerOpenedEvent())
                    : homeViewModel.add(HomeDrawerClosedEvent());
              },
              body: const ActivityPageWidget(),
            ),
          );
        },
      ),
    );
  }
}