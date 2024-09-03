import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_view_model.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetttleDeclinePageWidget extends StatelessWidget {
  const SetttleDeclinePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettleViewModel, SettleState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<SettleViewModel>(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              BackButtonWithTitle(
                title: 'Decline Request',
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
                width: context.dynamicWidth(0.9),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Decline the request and provide a reason if needed.\nThis helps keep things clear and avoids misunderstandings.',
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
