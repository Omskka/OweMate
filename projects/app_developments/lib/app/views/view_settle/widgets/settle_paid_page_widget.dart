import 'package:flutter/material.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_view_model.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettlePaidPageWidget extends StatelessWidget {
  const SettlePaidPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<SettleViewModel>(context);
    return BlocBuilder<SettleViewModel, SettleState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              BackButtonWithTitle(
                title: 'Mark as Paid',
                ontap: () {
                  viewModel.add(
                    SettleNavigateToNextPageEvent(
                      selectedPage: 1,
                      context: context,
                    ),
                  );
                },
              ),
              SizedBox(
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(1),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Confirm the payment and send a message to let them\nknow the debt is cleared.',
                    style:
                        context.textStyleGrey(context).copyWith(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
