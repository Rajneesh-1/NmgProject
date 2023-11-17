import 'package:flutter/material.dart';
import 'package:nmg/utility/app_color.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    this.myKey,
    Key? key,
    this.title,
    this.showBalance,
    this.showBell,
    this.showDrawer,
    this.appBackGroundColor,
    this.showBottomAppBar = false,
    this.showLoginBtnOnAppBar = true,
    this.centeredTitle = false,
    this.bottomTapvalue,
    this.bottomTapLoginValue,
    this.onBackButton,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? myKey;
  final String? title;
  final bool? bottomTapvalue;
  final bool? bottomTapLoginValue;
  final bool? showDrawer;
  final bool? showBalance;
  final bool? showBell;
  final Color? appBackGroundColor;
  final bool? showBottomAppBar;
  final bool? showLoginBtnOnAppBar;
  final bool? centeredTitle;
  final VoidCallback? onBackButton;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => showBottomAppBar == false
      ? const Size(double.infinity, kToolbarHeight)
      : const Size(double.infinity, kToolbarHeight * 2);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: widget.appBackGroundColor ?? Colors.transparent,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Text(
            widget.title != null ? widget.title! : '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: AppColor.green,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
          ),
        ),
        leading: Visibility(
          visible: widget.showDrawer ?? true,
          child: widget.title == null
              ? Container()
              : MaterialButton(
              onPressed: () {
                widget.onBackButton != null ? widget.onBackButton!() : Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_sharp, size: 16, color: AppColor.black)
          ),
        )
    );
  }
}
