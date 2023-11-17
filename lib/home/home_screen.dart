import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg/home/models/response/total_user_response_data.dart' as total_user_response_data;
import 'package:nmg/home/widget/my_scaffold.dart';
import 'package:nmg/utility/app_color.dart';
import 'package:nmg/utility/app_screens.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  total_user_response_data.TotalUsersResponseData? totalUsersResponseData;

  ValueNotifier<bool> isApiLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetTotalUsersApi(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MyScaffold(
        showAppBar: true,
        extendBodyBehindAppBar: true,
        body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            color: AppColor.black,
            displacement: 60,
            edgeOffset: 1,
            strokeWidth: 2,
            onRefresh: () {
              return Future.delayed(
                const Duration(milliseconds: 200),
                    () {
                  BlocProvider.of<HomeBloc>(context).add(GetTotalUsersApi(context: context));
                },
              );
            },
            child: Container(
              color: AppColor.lightYellow,
              child: Column(
                children: [
                  const Text("Author's Posts", style: TextStyle(color: AppColor.brown,
                      fontSize: 34,
                      fontWeight: FontWeight.w800)).pOnly(top: 16, bottom: 8),
                  Expanded(
                    child: BlocConsumer<HomeBloc, HomeState>(
                        listener: (context, state) {
                          if (state is TotalUsersListSuccess) {
                            BlocProvider.of<HomeBloc>(context).add(GetTotalPostsApi(context: context));
                            setState(() {
                              totalUsersResponseData = state.response;
                            });
                          } else if (state is TotalPostListError || state is TotalPostListError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.errorMessage),
                            ));
                          }
                        },
                        builder: (context, state) {
                          if (state is TotalUsersListLoading) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
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
                                              ).pOnly(bottom: 4),
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
                                              const Text("Posts ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    color: AppColor.cyan,
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(width: 1, color: AppColor.blue)
                                                ),
                                                child: Container(width: 120, height: 100, color: Colors.black).pOnly(left:4),
                                              ),
                                            ],
                                          ).p(8)
                                      ).pOnly(top: 8),
                                    ).pOnly(top: 8);
                                  }).p(10),
                            );
                          }
                          else if (state is TotalUsersListSuccess) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
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
                                              ).pOnly(bottom: 4),
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
                                              const Text("Posts ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                              Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    color: AppColor.cyan,
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(width: 1, color: AppColor.blue)
                                                ),
                                                child: Container(width: 120, height: 100, color: Colors.black).pOnly(left:4),
                                              ),
                                            ],
                                          ).p(8)
                                      ).pOnly(top: 8),
                                    ).pOnly(top: 8);
                                  }).p(10),
                            );
                          }
                          else if (state is TotalUsersListError) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(child: Text(state.errorMessage)),
                            );
                          }
                          else if (state is TotalPostListSuccess) {
                            return SingleChildScrollView(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: totalUsersResponseData?.data?.length ?? 0,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var particularPostList = state.response.data?.where((element) => element.userId.toString() == totalUsersResponseData?.data?[index].id.toString()).toList();

                                    return Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12.0),
                                      ),
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(totalUsersResponseData?.data?[index].name ?? "NA", style: const TextStyle(color: AppColor.black,
                                                fontSize: 20, fontWeight: FontWeight.bold)).pOnly(left:8, top: 16, bottom: 16),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(Icons.mail, color: AppColor.green, size: 16),
                                                    Text(totalUsersResponseData?.data?[index].email ?? "NA", style: const TextStyle(color: AppColor.black,
                                                        fontSize: 10, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.phone_enabled, color: AppColor.red, size: 16),
                                                    Text(totalUsersResponseData?.data?[index].phone ?? "NA", style: const TextStyle(color: AppColor.black,
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
                                                    Text(totalUsersResponseData?.data?[index].address?.city ?? "NA", style: const TextStyle(color: AppColor.black,
                                                        fontSize: 10, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_city_sharp, color: AppColor.warmGrey, size: 16),
                                                    Text(totalUsersResponseData?.data?[index].address?.zipcode ?? "NA", style: const TextStyle(color: AppColor.black,
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
                                            ).pOnly(bottom: 8),
                                            const Text("Posts ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                            Flexible(
                                              child: Wrap(
                                                  children: List.generate(particularPostList?.length ?? 0, (postsIndex) {
                                                    return Material(
                                                      color: AppColor.cyan,
                                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Map<String, String> particularPostRelatedData = {};
                                                          particularPostRelatedData["authorName"]     = totalUsersResponseData?.data?[index].name ?? "";
                                                          particularPostRelatedData["email"]          = totalUsersResponseData?.data?[index].email ?? "";
                                                          particularPostRelatedData["phone"]          = totalUsersResponseData?.data?[index].phone ?? "";
                                                          particularPostRelatedData["city"]           = totalUsersResponseData?.data?[index].address?.city ?? "";
                                                          particularPostRelatedData["zipCode"]        = totalUsersResponseData?.data?[index].address?.zipcode ?? "";
                                                          particularPostRelatedData["selectedPostId"] = particularPostList?[postsIndex].id.toString() ?? "";

                                                          Navigator.pushNamed(context, AppScreens.postDetailsCommentsScreen, arguments: particularPostRelatedData);
                                                        },
                                                        customBorder: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Container(
                                                          width: 150,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8),
                                                              border: Border.all(width: 1, color: AppColor.blue)
                                                          ),
                                                          child: Text("• ${particularPostList?[postsIndex].title}", overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColor.black,
                                                              fontSize: 12, fontWeight: FontWeight.w400)).pOnly(left: 8, right: 8, top: 8, bottom: 8),
                                                        ),
                                                      ),
                                                    ).p(4);
                                                  })),
                                            ),
                                          ],
                                        ).p(4),
                                      ),
                                    ).pOnly(top: 8);
                                  }).p(10),
                            );
                          }
                          else if (state is TotalPostListError) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Center(child: Text(state.errorMessage)),
                            );
                          }
                          return SingleChildScrollView(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
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
                                            ).pOnly(bottom: 4),
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
                                            const Text("Posts ‣", style: TextStyle(color: AppColor.brown, fontSize: 14, fontWeight: FontWeight.w400)).pOnly(left: 4),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  color: AppColor.cyan,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(width: 1, color: AppColor.blue)
                                              ),
                                              child: Container(width: 120, height: 100, color: Colors.black).pOnly(left:4),
                                            ),
                                          ],
                                        ).p(8)
                                    ).pOnly(top: 8),
                                  ).pOnly(top: 8);
                                }).p(10),
                          );
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
