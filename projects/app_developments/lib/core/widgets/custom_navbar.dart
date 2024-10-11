import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/core/constants/dark_theme_color_constants.dart';
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
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return AutoTabsScaffold(
            backgroundColor: ColorThemeUtil.getBgDarkColor(context),
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
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            splashColor:
                                Colors.transparent, // Remove splash effect
                            highlightColor:
                                Colors.transparent, // Remove highlight effect
                          ),
                          child: NavigationBar(
                            backgroundColor:
                                ColorThemeUtil.getMoneyCardColor(context),
                            selectedIndex: tabsRouter.activeIndex,
                            indicatorShape: CustomRoundedTopBorderShape(),
                            onDestinationSelected: (index) {
                              tabsRouter.setActiveIndex(index);
                            },
                            destinations: [
                              _navigationDestination(
                                activeIcon: Assets.images.svg.home,
                                icon: Assets.images.svg.home,
                                isDarkMode: isDarkMode,
                              ),
                              _navigationDestination(
                                activeIcon: Assets.images.svg.wallet,
                                icon: Assets.images.svg.wallet,
                                isDarkMode: isDarkMode,
                              ),
                              _navigationDestination(
                                activeIcon: Assets.images.svg.chart,
                                icon: Assets.images.svg.chart,
                                isDarkMode: isDarkMode,
                              ),
                              _navigationDestination(
                                activeIcon: Assets.images.svg.friends,
                                icon: Assets.images.svg.friends,
                                isDarkMode: isDarkMode,
                              ),
                              // Add more NavigationDestinations here
                            ],
                          ),
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
    required bool isDarkMode,
  }) {
    return NavigationDestination(
      icon: _svgPictureIcon(icon, isDarkMode),
      selectedIcon: _svgPictureIcon(activeIcon, isDarkMode, true),
      label: '',
    );
  }

  SvgPicture _svgPictureIcon(String icon, bool isDarkMode,
      [bool isSelected = false]) {
    return SvgPicture.asset(
      icon,
      height: 25,
      width: 25,
      colorFilter: ColorFilter.mode(
        _getIconColor(isDarkMode, isSelected),
        BlendMode.srcIn,
      ),
    );
  }

  // Helper function to get the correct icon color based on theme and selection
  Color _getIconColor(bool isDarkMode, bool isSelected) {
    if (isDarkMode) {
      return isSelected
          ? Colors.white
          : AppDarkColorConstants.contentTeritaryColor;
    } else {
      return isSelected ? Colors.white : AppLightColorConstants.primaryColor;
    }
  }
}
