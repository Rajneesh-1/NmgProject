import 'package:nmg/home/models/response/total_posts_response_data.dart';
import 'package:nmg/home/models/response/total_user_response_data.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class TotalUsersListLoading extends HomeState{}

class TotalUsersListSuccess extends HomeState{
  TotalUsersResponseData response;

  TotalUsersListSuccess({required this.response});

}
class TotalUsersListError extends HomeState{
  String errorMessage;

  TotalUsersListError({required this.errorMessage});
}

class TotalPostListLoading extends HomeState{}

class TotalPostListSuccess extends HomeState{
  TotalPostsResponseData response;

  TotalPostListSuccess({required this.response});

}
class TotalPostListError extends HomeState{
  String errorMessage;

  TotalPostListError({required this.errorMessage});
}

class PostDetailsLoading extends HomeState{}

class PostDetailsSuccess extends HomeState{
  TotalUsersResponseData response;

  PostDetailsSuccess({required this.response});

}
class PostDetailsError extends HomeState{
  String errorMessage;

  PostDetailsError({required this.errorMessage});
}