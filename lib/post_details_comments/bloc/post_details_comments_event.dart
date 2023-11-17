import 'package:flutter/cupertino.dart';

abstract class ParticularPostDetailsEvent {}

class ParticularPostDetailsApi extends ParticularPostDetailsEvent {
  BuildContext context;
  int id;

  ParticularPostDetailsApi({required this.context, required this.id});
}
