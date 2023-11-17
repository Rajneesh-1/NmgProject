import 'package:flutter/cupertino.dart';
import 'package:nmg/home/repository/home_repository.dart';
import 'package:nmg/utility/result.dart';
import 'models/response/particular_post_details_response_data.dart';

class PostDetailsCommentsLogic {
  static Future<Result<dynamic>> getParticularPostDetails(BuildContext context, int id) async {
    dynamic jsonMap = await HomeRepository.getParticularPostDetailsApi(context, id);

    try {
      var respObj = ParticularPostDetailsResponseData.fromJson(jsonMap);
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