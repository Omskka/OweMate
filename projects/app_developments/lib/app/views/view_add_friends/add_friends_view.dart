import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_event.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_state.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_view_model.dart';
import 'package:app_developments/app/views/view_add_friends/widgets/add_friends_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddFriendsView extends StatelessWidget {
  const AddFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddFriendsViewModel()..add(AddFriendsFetchAllUsersEvent()),
      child: BlocBuilder<AddFriendsViewModel, AddFriendsState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorThemeUtil.getBgLightColor(context),
              body: const AddFriendsPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
