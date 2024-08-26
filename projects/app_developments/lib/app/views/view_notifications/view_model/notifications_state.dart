abstract class NotificationsState {
  final List friendRequests;
  NotificationsState({required this.friendRequests});
}

class NotificationsInitialState extends NotificationsState {
  NotificationsInitialState() : super(friendRequests: []);
}

class NotificationsFetchDataState extends NotificationsState{
  NotificationsFetchDataState({
    required List friendRequests,
  }):super(friendRequests: friendRequests);
}
