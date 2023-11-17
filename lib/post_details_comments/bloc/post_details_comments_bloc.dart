import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg/post_details_comments/models/response/particular_post_details_response_data.dart';
import 'package:nmg/post_details_comments/post_details_comments_logic.dart';
import 'post_details_comments_event.dart';
import 'post_details_comments_state.dart';

class ParticularPostDetailsBloc extends Bloc<ParticularPostDetailsEvent, ParticularPostDetailsCommentsState> {
      ParticularPostDetailsBloc() : super(ParticularPostDetailsInitial()) {
    on<ParticularPostDetailsApi>(_onParticularPostDetailsEvent);
  }
}

_onParticularPostDetailsEvent(ParticularPostDetailsApi event, Emitter<ParticularPostDetailsCommentsState> emit) async {
  emit(ParticularPostDetailsLoading());

  BuildContext context = event.context;
  int id = event.id;

  var response = await PostDetailsCommentsLogic.getParticularPostDetails(context, id);

  try {
    response.when(
        idle: () {},
        networkFault: (value) {
          emit(ParticularPostDetailsError(
              errorMessage: value["occurredErrorDescriptionMsg"]));
        },
        responseSuccess: (value) {
          ParticularPostDetailsResponseData successResponse = value as ParticularPostDetailsResponseData;
          emit(ParticularPostDetailsSuccess(response: successResponse));
        },
        responseFailure: (value) {
          emit(ParticularPostDetailsError(errorMessage: "Something went wrong while fetching data"));
        },
        failure: (value) {
          emit(ParticularPostDetailsError(errorMessage: value["occurredErrorDescriptionMsg"]));
        });
  } catch (e) {
    emit(ParticularPostDetailsError(errorMessage: "Technical Issue !"));
  }
}




