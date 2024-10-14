import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/money_request_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetttleDeclinePageWidget extends StatelessWidget {
  const SetttleDeclinePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettleViewModel, SettleState>(
      builder: (context, state) {
        // Check if the current theme is dark or light
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        // Handle the case where maxWidth or maxHeight is Infinity
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Define responsive variables
        EdgeInsets leftPadding;
        double textfieldWidth;
        double containerwidth;

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Width
        if (screenWidth <= 600) {
          leftPadding = context.onlyLeftPaddingMedium;
          textfieldWidth = context.dynamicWidth(0.75);
          containerwidth = 0.75;
        } else if (screenWidth <= 800) {
          leftPadding = context.onlyLeftPaddingMedium * 2;
          textfieldWidth = context.dynamicWidth(0.7);
          containerwidth = 0.65;
        } else if (screenWidth <= 900) {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.5)) / 2);
          textfieldWidth = context.dynamicWidth(0.7);
          containerwidth = 0.55;
        } else if (screenWidth <= 1080) {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.45)) / 2);
          textfieldWidth = context.dynamicWidth(0.6);
          containerwidth = 0.45;
        } else {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.45)) / 2);
          textfieldWidth = context.dynamicWidth(0.6);
          containerwidth = 0.35;
        }
        // Get viewmodel
        final viewModel = BlocProvider.of<SettleViewModel>(context);

        // Fetch friends data
        final debt = state.userData['owedMoney'][state.index];
        final amount = debt['amount']?.toString() ?? '0';
        final date = debt['date'] ?? '';
        final friendUserId = debt['friendUserId'] ?? '';

        // Fetch friend's data from state
        final friendData = state.friendsUserData[friendUserId] ?? {};
        final friendName = friendData['firstName'] ?? 'Unknown';
        final profileImageUrl = friendData['profileImageUrl'] ?? '';

        return SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonWithTitle(
                  title: 'Decline Request',
                  ontap: () {
                    viewModel.add(
                      SettleNavigateToNextPageEvent(
                        selectedPage: 1,
                        context: context,
                        index: -1,
                      ),
                    );
                  },
                ),
                Center(
                  child: SizedBox(
                    height: context.dynamicHeight(0.1),
                    width: context.dynamicWidth(0.9),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Decline the request and provide a reason if needed.\nThis helps keep things clear and avoids misunderstandings.',
                        style: context
                            .textStyleGrey(context)
                            .copyWith(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                context.sizedHeightBoxLower,
                Center(
                  child: Container(
                    padding: EdgeInsets.all(context.lowValue),
                    height: context.dynamicHeight(0.11),
                    width: context.dynamicWidth(containerwidth),
                    decoration: BoxDecoration(
                      color: ColorThemeUtil.getFinanceCardColor(context),
                      borderRadius: BorderRadius.all(context.normalRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: context.onlyTopPaddingLow * 1.5,
                          child: Row(
                            children: [
                              Padding(
                                padding: context.onlyLeftPaddingLow,
                                child: CircleAvatar(
                                  radius: context.dynamicHeight(0.03),
                                  backgroundImage:
                                      NetworkImage(profileImageUrl),
                                ),
                              ),
                              SizedBox(width: context.lowValue),
                              Expanded(
                                child: Padding(
                                  padding: context.onlyLeftPaddingLow,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        friendName,
                                        style: context
                                            .textStyleGrey(context)
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                      ),
                                      Padding(
                                        padding: context.onlyTopPaddingLow,
                                        child: Flexible(
                                          child: Text(
                                            date,
                                            style: context
                                                .textStyleGrey(context)
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: context.onlyRightPaddingMedium,
                                child: Text(
                                  amount,
                                  style: context
                                      .textStyleGrey(context)
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                context.sizedHeightBoxMedium,
                Padding(
                  padding: leftPadding,
                  child: SizedBox(
                    height: context.dynamicHeight(0.13),
                    width: context.dynamicWidth(1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Decline Message',
                          style: context.textStyleGreyBarlow(context).copyWith(
                                color: isDarkMode
                                    ? AppLightColorConstants.bgLight
                                    : AppLightColorConstants.primaryColor,
                                fontSize: 18,
                              ),
                        ),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          width: textfieldWidth,
                          controller: viewModel.declineMessageController,
                          hintText:
                              'Ex. "Sorry, I can’t cover this right now."',
                          hintFontSize: 14,
                          validator: (value) =>
                              MoneyRequestValidation().checkValidMessage(
                            value,
                            context,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                context.sizedHeightBoxHigh,
                Center(
                  child: CustomContinueButton(
                    buttonText: 'Decline Request',
                    onPressed: () {
                      if (viewModel.formKey.currentState!.validate()) {
                        viewModel.add(
                          SettleDeclineRequestEvent(
                            context: context,
                            requestId: debt['requestId'],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
