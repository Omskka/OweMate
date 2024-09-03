import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_request/view_model/request_event.dart';
import 'package:app_developments/app/views/view_request/view_model/request_state.dart';
import 'package:app_developments/app/views/view_request/view_model/request_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/money_request_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestPageAmountPageWidget extends StatelessWidget {
  const RequestPageAmountPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestViewModel, RequestState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<RequestViewModel>(context);
        viewModel.currencyController.addListener(() {
          context.read<RequestViewModel>().add(RequestUpdateCurrencyEvent(
              currency: viewModel.currencyController));
        });
        // Handle the case where maxWidth or maxHeight is Infinity
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Define responsive variables
        double containerHeight;
        EdgeInsets leftPadding;
        double textfieldWidth;
        double circleAvatarWidth;

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Height
        if (screenHeight <= 600) {
          containerHeight = 0.2;
        } else if (screenHeight <= 800) {
          containerHeight = 0.25;
        } else if (screenHeight <= 900) {
          containerHeight = 0.23;
        } else if (screenHeight <= 1080) {
          containerHeight = 0.22;
        } else {
          containerHeight = 0.18;
        }

        // Width
        if (screenWidth <= 600) {
          leftPadding = context.onlyLeftPaddingMedium;
          textfieldWidth = context.dynamicWidth(0.8);
          circleAvatarWidth = 2.2;
        } else if (screenWidth <= 800) {
          leftPadding = context.onlyLeftPaddingMedium * 2;
          textfieldWidth = context.dynamicWidth(0.7);
          circleAvatarWidth = 1.4;
        } else if (screenWidth <= 900) {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.37)) / 2);
          textfieldWidth = context.dynamicWidth(0.5);
          circleAvatarWidth = 1.3;
        } else if (screenWidth <= 1080) {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.37)) / 2);
          textfieldWidth = context.dynamicWidth(0.45);
          circleAvatarWidth = 1;
        } else {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.37)) / 2);
          textfieldWidth = context.dynamicWidth(0.4);
          circleAvatarWidth = 0.8;
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              BackButtonWithTitle(
                title: 'Enter Amount',
                ontap: () {
                  context.router.push(const DebtsViewRoute());
                },
              ),
              SizedBox(
                height: context.dynamicHeight(0.075),
                width: context.dynamicWidth(1),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Enter the exact amount owed to ensure\nprecise and clear transactions.',
                    style: context.textStyleGrey(context).copyWith(
                          fontSize: 15,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              context.sizedHeightBoxLower,
              Container(
                height: context.dynamicHeight(containerHeight),
                width: context.dynamicWidth(0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(context.normalRadius),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center align the content
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center align horizontally
                  children: [
                    // Display the profile image
                    Container(
                      width: context.dynamicWidth(
                          0.11 * circleAvatarWidth), // Adjust size as needed
                      height: context.dynamicWidth(
                          0.11 * circleAvatarWidth), // Ensure it's a square
                      decoration: BoxDecoration(
                        shape:
                            BoxShape.circle, // Make sure the border is circular
                        border: Border.all(
                          color: AppLightColorConstants.contentTeritaryColor
                              .withOpacity(0.45), // Border color
                          width: 3.0, // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        radius:
                            context.dynamicWidth(0.16), // Adjust size as needed
                        backgroundImage: NetworkImage(
                          state.selectedUser![0]['profileImageUrl'] ?? '',
                        ), // Use a default image or handle null
                        backgroundColor: Colors
                            .transparent, // Set a transparent background if needed
                      ),
                    ),

                    // Space between image and text
                    context.sizedHeightBoxLower,
                    // Display the user's name
                    Text(
                      'Send request to',
                      style: context.textStyleGrey(context),
                    ),
                    Text(
                      state.selectedUser?[0]['Name'] ??
                          'No Name', // Provide a default name if null
                      style: context.textStyleGreyBarlow(context),
                    ),
                  ],
                ),
              ),
              context.sizedHeightBoxLow,
              Padding(
                padding: leftPadding,
                child: SizedBox(
                  height: context.dynamicHeight(0.385),
                  width: context.dynamicWidth(1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a Currency',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              fontSize: 15,
                              color: AppLightColorConstants.primaryColor,
                            ),
                      ),
                      context.sizedHeightBoxLower,
                      DropdownMenu(
                        menuHeight: context.dynamicHeight(0.15),
                        width: context.dynamicWidth(0.3),
                        textStyle: context
                            .textStyleGrey(context)
                            .copyWith(fontWeight: FontWeight.w600),
                        controller: viewModel.currencyController,
                        hintText: 'Ex. USD',
                        dropdownMenuEntries: <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                            value: '₺',
                            label: 'TL',
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                    left: context.dynamicWidth(0.05)),
                              ),
                            ),
                          ),
                          DropdownMenuEntry(
                            value: '\$',
                            label: 'USD',
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                    left: context.dynamicWidth(0.05)),
                              ),
                            ),
                          ),
                          DropdownMenuEntry(
                            value: '€',
                            label: 'EURO',
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                    left: context.dynamicWidth(0.05)),
                              ),
                            ),
                          ),
                          DropdownMenuEntry(
                            value: '£',
                            label: 'GBP',
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                    left: context.dynamicWidth(0.05)),
                              ),
                            ),
                          ),
                          DropdownMenuEntry(
                            value: '¥',
                            label: 'JPY',
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                  left: context.dynamicWidth(0.05),
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuEntry(
                            value: '₣',
                            label: 'CHF',
                            style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.only(
                                    left: context.dynamicWidth(0.05)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      context.sizedHeightBoxLow,
                      Text(
                        'Enter Amount',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              fontSize: 15,
                              color: AppLightColorConstants.primaryColor,
                            ),
                      ),
                      CustomTextField(
                        width: textfieldWidth,
                        prefixIcon: state.prefix,
                        hintText: 'Ex. 500',
                        controller: viewModel.amountController,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            MoneyRequestValidation().checkValidAmount(
                          value,
                          context,
                        ),
                      ),
                      context.sizedHeightBoxLow,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Enter a Message', // Main text
                              style: context
                                  .textStyleGreyBarlow(context)
                                  .copyWith(
                                    fontSize: 15,
                                    color: AppLightColorConstants.primaryColor,
                                  ),
                            ),
                            TextSpan(
                              text: ' (Optional)', // Optional text
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppLightColorConstants
                                        .contentDisabled, // Different color
                                  ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                        width: textfieldWidth,
                        hintText: 'Ex. Lunch at Joe\'s Diner',
                        controller: viewModel.messageController,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            MoneyRequestValidation().checkValidMessage(
                          value,
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomContinueButton(
                buttonText: 'Send Request',
                onPressed: () {
                  viewModel.add(RequestSendEvent(
                      context: context,
                      selectedUser: state.selectedUser,
                      prefix: state.prefix!));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
