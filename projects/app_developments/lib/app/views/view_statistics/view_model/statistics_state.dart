abstract class StatisticsState {
  final List filteredRequestedMoney;
  final List filteredOwedMoney;
  final List friends;
  StatisticsState({
    required this.filteredRequestedMoney,
    required this.filteredOwedMoney,
    required this.friends,
  });
}

class StatisticsInitialState extends StatisticsState {
  StatisticsInitialState()
      : super(
          filteredRequestedMoney: [],
          filteredOwedMoney: [],
          friends: [],
        );
}

class StatisticsLoadingState extends StatisticsState {
  StatisticsLoadingState()
      : super(
          filteredRequestedMoney: [],
          filteredOwedMoney: [],
          friends: [],
        );
}

class StatisticsDataLoadedState extends StatisticsState {
  final StatisticsState state;
  final List filteredRequestedMoney;
  final List filteredOwedMoney;
  final List friends;
  StatisticsDataLoadedState({
    required this.state,
    required this.filteredOwedMoney,
    required this.filteredRequestedMoney,
    required this.friends,
  }) : super(
          filteredOwedMoney: filteredOwedMoney,
          filteredRequestedMoney: filteredRequestedMoney,
          friends: friends,
        );
}
