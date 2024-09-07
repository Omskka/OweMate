abstract class ActivityState {
  final List requestNumber;
  final List<double> requestedMoneyTotals;
  final List<double> owedMoneyTotals;
  final int? requestCurrencyIndex;
  final int? debtCurrencyIndex;
  ActivityState(
      {required this.requestNumber,
      required this.requestedMoneyTotals,
      required this.owedMoneyTotals,
      this.requestCurrencyIndex,
      this.debtCurrencyIndex});
}

class ActivityInitialState extends ActivityState {
  ActivityInitialState()
      : super(
          requestNumber: [],
          requestedMoneyTotals: [],
          owedMoneyTotals: [],
        );
}

class ActivityDataLoadedState extends ActivityState {
  ActivityDataLoadedState(
      {required List requestNumber,
      required List<double> requestedMoneyTotals,
      required List<double> owedMoneyTotals,
      required int? requestCurrencyIndex,
      required int? debtCurrencyIndex})
      : super(
          requestNumber: requestNumber,
          requestedMoneyTotals: requestedMoneyTotals,
          owedMoneyTotals: owedMoneyTotals,
          requestCurrencyIndex: requestCurrencyIndex,
          debtCurrencyIndex: debtCurrencyIndex,
        );
}

class ActivityGetIndexState extends ActivityState {
  ActivityGetIndexState({
    required ActivityState state,
    required List requestNumber,
    required List<double> requestedMoneyTotals,
    required List<double> owedMoneyTotals,
    required int? requestCurrencyIndex,
    required int? debtCurrencyIndex,
  }) : super(
          requestNumber: state.requestNumber,
          owedMoneyTotals: state.owedMoneyTotals,
          requestedMoneyTotals: state.requestedMoneyTotals,
          requestCurrencyIndex: requestCurrencyIndex,
          debtCurrencyIndex: debtCurrencyIndex,
        );
}

class ActivityDrawerOpenedState extends ActivityState {
  ActivityDrawerOpenedState({
    required ActivityState state,
    required List requestNumber,
  }) : super(
            requestNumber: state.requestNumber,
            requestedMoneyTotals: state.requestedMoneyTotals,
            owedMoneyTotals: state.owedMoneyTotals);
}

class ActivityDrawerClosedState extends ActivityState {
  ActivityDrawerClosedState({
    required ActivityState state,
    required List requestNumber,
  }) : super(
            requestNumber: state.requestNumber,
            requestedMoneyTotals: state.requestedMoneyTotals,
            owedMoneyTotals: state.owedMoneyTotals);
}
