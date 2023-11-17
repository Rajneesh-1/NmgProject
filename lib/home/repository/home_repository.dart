import 'package:flutter/material.dart';
import 'package:nmg/network/api_base_url.dart';
import 'package:nmg/network/api_call.dart';
import 'package:nmg/network/api_relative_urls.dart';
import 'package:nmg/network/network_utils.dart';

class HomeRepository {

  static dynamic getTotalUsersApi(BuildContext context) async =>
      await CallApi.callApi(baseUrl, MethodType.get, getTotalUsers);

  static dynamic getTotalPostsApi(BuildContext context) async =>
      await CallApi.callApi(baseUrl, MethodType.get, getTotalPost);

  static dynamic getParticularPostDetailsApi(BuildContext context, int id) async =>
      await CallApi.callApi(baseUrl, MethodType.get, getTotalPost, pathId: id);
}