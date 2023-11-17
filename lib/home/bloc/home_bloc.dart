import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg/home/home_logic.dart';
import 'package:nmg/home/models/response/total_posts_response_data.dart';
import 'package:nmg/home/models/response/total_user_response_data.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetTotalUsersApi>(_onTotalUsersEvent);
    on<GetTotalPostsApi>(_onTotalPostEvent);
  }
}

_onTotalUsersEvent(GetTotalUsersApi event, Emitter<HomeState> emit) async {
  emit(TotalUsersListLoading());

  BuildContext context = event.context;
  var response = await HomeLogic.getTotalUsersApi(context);

  try {
    response.when(
        idle: () {},
        networkFault: (value) {
          emit(TotalUsersListError(
              errorMessage: value["occurredErrorDescriptionMsg"]));
        },
        responseSuccess: (value) {
          TotalUsersResponseData successResponse = value as TotalUsersResponseData;
          emit(TotalUsersListSuccess(response: successResponse));
        },
        responseFailure: (value) {
          emit(TotalUsersListError(errorMessage: "Something went wrong while fetching data"));
        },
        failure: (value) {
          emit(TotalUsersListError(errorMessage: value["occurredErrorDescriptionMsg"]));
        });
  } catch (e) {
    emit(TotalUsersListError(errorMessage: "Technical Issue !"));
  }
}

_onTotalPostEvent(GetTotalPostsApi event, Emitter<HomeState> emit) async {
  emit(TotalUsersListLoading());

  BuildContext context = event.context;

  var response = await HomeLogic.getTotalPostsApi(context);

  try {
    response.when(
        idle: () {},
        networkFault: (value) {
          emit(TotalPostListError(
              errorMessage: value["occurredErrorDescriptionMsg"]));
        },
        responseSuccess: (value) {
          TotalPostsResponseData successResponse = value as TotalPostsResponseData;
          emit(TotalPostListSuccess(response: successResponse));
        },
        responseFailure: (value) {
          emit(TotalPostListError(errorMessage: "Something went wrong while fetching data"));
        },
        failure: (value) {
          emit(TotalPostListError(errorMessage: value["occurredErrorDescriptionMsg"]));
        });
  } catch (e) {
    emit(TotalPostListError(errorMessage: "Technical Issue !"));
  }
}