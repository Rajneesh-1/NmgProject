import 'package:flutter/cupertino.dart';

abstract class HomeEvent {}

class GetTotalUsersApi extends HomeEvent {
  BuildContext context;

  GetTotalUsersApi({required this.context});
}

class GetTotalPostsApi extends HomeEvent {
  BuildContext context;

  GetTotalPostsApi({required this.context});
}

class GetPostDetailsData extends HomeEvent {
  BuildContext context;
  int id;

  GetPostDetailsData({required this.context, required this.id});
}
