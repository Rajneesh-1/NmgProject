import 'package:nmg/post_details_comments/models/response/particular_post_details_response_data.dart';

abstract class ParticularPostDetailsCommentsState {}

class ParticularPostDetailsInitial extends ParticularPostDetailsCommentsState {}

class ParticularPostDetailsLoading extends ParticularPostDetailsCommentsState{}

class ParticularPostDetailsSuccess extends ParticularPostDetailsCommentsState{
  ParticularPostDetailsResponseData response;
  ParticularPostDetailsSuccess({required this.response});

}
class ParticularPostDetailsError extends ParticularPostDetailsCommentsState{
  String errorMessage;

  ParticularPostDetailsError({required this.errorMessage});
}