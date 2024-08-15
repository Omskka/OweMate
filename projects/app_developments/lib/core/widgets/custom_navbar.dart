/* import 'package:app_developments/app/routes/app_router.dart';
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
          // Debug statement to print the current state
          return AutoTabsScaffold(
            backgroundColor: AppLightColorConstants.bg,
            extendBody: false,
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: false,
            routes: const [
              HomeViewRoute(),
              CardDetailsViewRoute(),
              ActivityViewRoute(),
              ProfileViewRoute()
            ],
            bottomNavigationBuilder: (_, tabsRouter) {
              return state is! HomeDrawerOpenedState
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
                                activeIcon: Assets.images.svg.homeIcon,
                                icon: Assets.images.svg.homeIcon),
                            _navigationDestination(
                                activeIcon: Assets.images.svg.walletIcon,
                                icon: Assets.images.svg.walletIcon),
                            _navigationDestination(
                                activeIcon: Assets.images.svg.chartIcon,
                                icon: Assets.images.svg.chartIcon),
                            _navigationDestination(
                                activeIcon: Assets.images.svg.profileIcon,
                                icon: Assets.images.svg.profileIcon),
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
      icon: _svgPictureIcon(icon, AppLightColorConstants.secondaryColor),
      selectedIcon: _svgPictureIcon(activeIcon, AppLightColorConstants.bgLight),
      label: '',
    );
  }

  SvgPicture _svgPictureIcon(String icon, Color color) {
    return SvgPicture.asset(
      icon,
      height: 25,
      width: 25,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
 */