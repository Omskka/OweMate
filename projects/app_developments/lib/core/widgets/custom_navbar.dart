import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_indicator.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(),
      child: BlocBuilder<HomeViewModel, HomeState>(
        builder: (context, state) {
          return AutoTabsScaffold(
            backgroundColor: AppLightColorConstants.bgDark,
            extendBody: false,
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: false,
            routes: const [
              HomeViewRoute(),
              DebtsViewRoute(),
              ActivityViewRoute(),
              FriendsViewRoute(),
              // Add other routes as needed
            ],
            bottomNavigationBuilder: (_, tabsRouter) {
              return state is! HomeDrawerOpenedState &&
                      state is! DebtsDrawerOpenedState
                  ? Padding(
                      padding: context.paddingMedium,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: context.normalRadius,
                          bottom: context.normalRadius,
                        ),
                        child: NavigationBar(
                          backgroundColor: AppLightColorConstants.bgLight,
                          selectedIndex: tabsRouter.activeIndex,
                          indicatorShape: CustomRoundedTopBorderShape(),
                          onDestinationSelected: (index) {
                            tabsRouter.setActiveIndex(index);
                          },
                          destinations: [
                            _navigationDestination(
                              activeIcon: Assets.images.svg.home,
                              icon: Assets.images.svg.home,
                            ),
                            _navigationDestination(
                              activeIcon: Assets.images.svg.wallet,
                              icon: Assets.images.svg.wallet,
                            ),
                            _navigationDestination(
                              activeIcon: Assets.images.svg.chart,
                              icon: Assets.images.svg.chart,
                            ),
                            _navigationDestination(
                              activeIcon: Assets.images.svg.friends,
                              icon: Assets.images.svg.friends,
                            ),
                            // Add more NavigationDestinations here
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          );
        },
      ),
    );
  }

  NavigationDestination _navigationDestination({
    required String activeIcon,
    required String icon,
  }) {
    return NavigationDestination(
      icon: _svgPictureIcon(icon),
      selectedIcon: _svgPictureIcon(activeIcon, AppLightColorConstants.bgLight),
      label: '',
    );
  }

  SvgPicture _svgPictureIcon(String icon, [Color? color]) {
    return SvgPicture.asset(
      icon,
      height: 25,
      width: 25,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null, // No color filter if color is null
    );
  }
}
