import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:nmg/home/models/response/total_user_response_data.dart';
import 'package:nmg/home/repository/home_repository.dart';
import 'package:nmg/utility/result.dart';

import 'models/response/total_posts_response_data.dart';

class HomeLogic {

  static Future<Result<dynamic>> getTotalUsersApi(BuildContext context) async {
    dynamic jsonMap = await HomeRepository.getTotalUsersApi(context);
    dynamic parsableData = '{"data": ${jsonEncode(jsonMap)}}'; // Here parsing was required as we are receiving a list.
    try {
      var respObj = TotalUsersResponseData.fromJson(jsonDecode(parsableData));
      return Result.responseSuccess(data: respObj);

    } catch (e) {
      if (jsonMap["occurredErrorDescriptionMsg"] == "No connection") {
        return Result.networkFault(data: jsonMap);
      } else {
        return Result.failure(
            data: jsonMap["occurredErrorDescriptionMsg"] != null
                ? jsonMap
                : {"occurredErrorDescriptionMsg": e});
      }
    }
  }

  static Future<Result<dynamic>> getTotalPostsApi(BuildContext context) async {
    dynamic jsonMap = await HomeRepository.getTotalPostsApi(context);
    dynamic parsableData = '{"data": ${jsonEncode(jsonMap)}}'; // Here parsing was required as we are receiving a list.
    try {
      var respObj = TotalPostsResponseData.fromJson(jsonDecode(parsableData));
      return Result.responseSuccess(data: respObj);

    } catch (e) {
      if (jsonMap["occurredErrorDescriptionMsg"] == "No connection") {
        return Result.networkFault(data: jsonMap);
      } else {
        return Result.failure(
            data: jsonMap["occurredErrorDescriptionMsg"] != null
                ? jsonMap
                : {"occurredErrorDescriptionMsg": e});
      }
    }
  }
}
