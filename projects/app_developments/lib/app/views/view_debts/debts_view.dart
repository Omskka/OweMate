import 'package:app_developments/app/views/view_debts/view_model/debts_event.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_view_model.dart';
import 'package:app_developments/app/views/view_debts/widgets/debts_page_widget.dart';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/app/views/view_home/widgets/home_drawer.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DebtsView extends StatelessWidget {
  const DebtsView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DebtsViewModel()..add(DebtsInitialEvent()),
      child: BlocBuilder<DebtsViewModel, DebtsState>(
        builder: (context, state) {
          final viewModel = context.read<DebtsViewModel>();
          final homeViewModel = context.read<HomeViewModel>();
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
                name: context.read<DebtsViewModel>().name,
                phoneNumber: context.read<DebtsViewModel>().phoneNumber,
                email: context.read<DebtsViewModel>().email,
                profileImageUrl: context.read<DebtsViewModel>().profileImageUrl,
              ),
              // Hide navbar when drawer is opened
              onDrawerChanged: (isOpened) {
                isOpened
                    ? homeViewModel.add(HomeDrawerOpenedEvent())
                    : homeViewModel.add(HomeDrawerClosedEvent());
              },
              body: const DebtsPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
