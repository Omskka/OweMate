import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          clipBehavior: Clip.none,
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
                      'Home',
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
              SizedBox(
                height: context.dynamicHeight(0.08),
                width: context.dynamicWidth(1),
                child: Center(
                  child: Text(
                    'Manage your debts and requests easily.\nTap on the cards to view messages.',
                    textAlign: TextAlign.center,
                    style:
                        context.textStyleGrey(context).copyWith(fontSize: 17),
                  ),
                ),
              ),
              context.sizedHeightBoxLower,
              SizedBox(
                height: context.dynamicHeight(0.05),
                width: context.dynamicWidth(1),
                child: Padding(
                  padding: context.onlyLeftPaddingMedium,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Money you owe',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: context.dynamicHeight(0.25),
                width: context.dynamicWidth(1),
                child: Center(
                    child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'You don\'t owe anyone any money. You\'re all clear!',
                    style: context.textStyleGrey(context),
                  ),
                )),
              ),
              SizedBox(
                height: context.dynamicHeight(0.05),
                width: context.dynamicWidth(1),
                child: Padding(
                  padding: context.onlyLeftPaddingMedium,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Money Owed to You',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: context.dynamicHeight(0.25),
                width: context.dynamicWidth(1),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'No one owes you anything right now. Everything is balanced!',
                      style: context.textStyleGrey(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
