import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg/home/widget/my_scaffold.dart';
import 'package:nmg/post_details_comments/bloc/post_details_comments_bloc.dart';
import 'package:nmg/post_details_comments/bloc/post_details_comments_event.dart';
import 'package:nmg/post_details_comments/bloc/post_details_comments_state.dart';
import 'package:nmg/post_details_comments/models/response/particular_post_details_response_data.dart';
import 'package:nmg/utility/app_color.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class PostDetailsCommentsScreen extends StatefulWidget {
  final Map<String, String> particularPostRelatedData;
  const PostDetailsCommentsScreen({Key? key, required this.particularPostRelatedData}) : super(key: key);

  @override
  State<PostDetailsCommentsScreen> createState() => _PostDetailsCommentsScreenState();
}

class _PostDetailsCommentsScreenState extends State<PostDetailsCommentsScreen> {
  ParticularPostDetailsResponseData? particularPostDetailsResponseData;

  ValueNotifier<bool> isApiLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ParticularPostDetailsBloc>(context).add(ParticularPostDetailsApi(context: context, id: int.parse(widget.particularPostRelatedData["selectedPostId"] ?? "")));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MyScaffold(
        showAppBar: true,
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColor.lightYellow,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Post's comments", style: TextStyle(color: AppColor.brown, fontSize: 34, fontWeight: FontWeight.w800)).pOnly(top: 16, bottom: 8),
              BlocListener<ParticularPostDetailsBloc, ParticularPostDetailsCommentsState>(
                  listener: (context, state) {
                    if (state is ParticularPostDetailsLoading) {
                      isApiLoading.value = true;

                    } else if (state is ParticularPostDetailsSuccess) {
                      isApiLoading.value = false;
                      setState(() {
                        particularPostDetailsResponseData = state.response;
                      });
                    } else if (state is ParticularPostDetailsError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage),
                      ));
                    }
                  },
                  child: ValueListenableBuilder<bool>(
                      valueListenable: isApiLoading,
                      builder: (context, value, child) {
                        return value
                            ? Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300]!,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Shimmer.fromColors(
                                period: const Duration(milliseconds: 1000),
                                baseColor: Colors.grey[400]!,
                                highlightColor: Colors.grey[200]!,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 170,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: AppColor.cyan,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(width: 1, color: AppColor.blue)
                                      ),
                                      child: Container(width: 120, height: 10, color: Colors.black).pOnly(left:4),
                                    ).pOnly(top:4, bottom: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.mail, color: AppColor.green, size: 16),
                                            Container(width: 120, height: 10, color: Colors.black).pOnly(left:4),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_enabled, color: AppColor.red, size: 16),
                                            Container(width: 120, height: 10, color: Colors.black).pOnly(left:4),
                                          ],
                                        )
                                      ],
                                    ).p(4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined, color: AppColor.red, size: 16),
                                            Container(width: 120, height: 10, color: Colors.black).pOnly(left:4),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_city_sharp, color: AppColor.warmGrey, size: 16),
                                            Container(width: 120, height: 10, color: Colors.black).pOnly(left:4),
                                          ],
                                        )
                                      ],
                                    ).p(4),
                                    Container(
                                      decoration: DottedDecoration(
                                        color: AppColor.brown,
                                        strokeWidth: 0.5,
                                        linePosition: LinePosition.bottom,
                                      ),
                                      height:1,
                                      width: MediaQuery.of(context).size.width,
                                    ).pOnly(bottom: 8),
                                    const Text("Posts Detailed View ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: AppColor.cyan,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(width: 1, color: AppColor.blue)
                                      ),
                                      child: Container(width: 120, height: 10, color: Colors.black).pOnly(left:8, top: 16, bottom: 16),
                                    ).pOnly(top: 8, bottom: 8),
                                    Container(
                                      decoration: DottedDecoration(
                                        color: AppColor.brown,
                                        strokeWidth: 0.5,
                                        linePosition: LinePosition.bottom,
                                      ),
                                      height:1,
                                      width: MediaQuery.of(context).size.width,
                                    ).pOnly(bottom: 8),
                                    const Text("People Comment's ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.black,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(width: 1, color: AppColor.warmGrey)
                                      ),
                                      child: Container(width: MediaQuery.of(context).size.width, height: 100, color: Colors.black).pOnly(left:8, top: 16, bottom: 16),
                                    ).p(4),
                                  ],
                                ).p(4)
                              ),
                            ).p(8)
                            : Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.particularPostRelatedData["authorName"] ?? "NA", style: const TextStyle(color: AppColor.black,
                                    fontSize: 20, fontWeight: FontWeight.bold)).pOnly(left:8, top: 16, bottom: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.mail, color: AppColor.green, size: 16),
                                        Text(widget.particularPostRelatedData["email"] ?? "NA", style: const TextStyle(color: AppColor.black,
                                            fontSize: 10, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.phone_enabled, color: AppColor.red, size: 16),
                                        Text(widget.particularPostRelatedData["phone"] ?? "NA", style: const TextStyle(color: AppColor.black,
                                            fontSize: 10, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                      ],
                                    )
                                  ],
                                ).p(4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, color: AppColor.red, size: 16),
                                        Text(widget.particularPostRelatedData["city"] ?? "NA", style: const TextStyle(color: AppColor.black,
                                            fontSize: 10, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_city_sharp, color: AppColor.warmGrey, size: 16),
                                        Text(widget.particularPostRelatedData["zipCode"] ?? "NA", style: const TextStyle(color: AppColor.black,
                                            fontSize: 10, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                      ],
                                    )
                                  ],
                                ).p(4),
                                Container(
                                  decoration: DottedDecoration(
                                    color: AppColor.brown,
                                    strokeWidth: 0.5,
                                    linePosition: LinePosition.bottom,
                                  ),
                                  height:1,
                                  width: MediaQuery.of(context).size.width,
                                ).pOnly(top: 8, bottom: 8),
                                const Text("Posts Detailed View ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: AppColor.cyan,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(width: 1, color: AppColor.blue)
                                  ),
                                  child: Text("• ${particularPostDetailsResponseData?.title}", style: const TextStyle(color: AppColor.black,
                                      fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 8, right: 8, top: 8, bottom: 8),
                                ).p(4),
                                Container(
                                  decoration: DottedDecoration(
                                    color: AppColor.brown,
                                    strokeWidth: 0.5,
                                    linePosition: LinePosition.bottom,
                                  ),
                                  height:1,
                                  width: MediaQuery.of(context).size.width,
                                ).pOnly(top: 8, bottom: 8),
                                const Text("People Comment's ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(width: 1, color: AppColor.warmGrey)
                                  ),
                                  child: Text("${particularPostDetailsResponseData?.body}", style: const TextStyle(color: AppColor.black,
                                      fontSize: 14)).pOnly(left: 8, right: 8, top: 8, bottom: 8),
                                ).p(4),
                              ],
                            ).p(4),
                              ),
                            ).p(8);
                      })
              )
            ],
          ),
        ),
      ),
    );
  }
}
