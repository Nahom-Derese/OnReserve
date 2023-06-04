// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:on_reserve/helpers/routes.dart';

class ContinueCard extends StatelessWidget {
  final int index;
  final String date;
  final String title;
  final String bgImage;

  const ContinueCard({
    super.key,
    required this.date,
    required this.title,
    required this.index,
    required this.bgImage,
  });

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    Orientation isLandscape =
        displayWidth > 650 ? Orientation.landscape : Orientation.portrait;
    return GestureDetector(
        onTap: () {
          // Get.toNamed(Routes.contactUs);
        },
        child: Container(
          width: isLandscape == Orientation.portrait ? 820.w : 820.w * 0.65,
          margin: EdgeInsets.only(left: 75.w),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(bgImage),
                  fit: BoxFit.cover,
                  opacity: 0.5),
              gradient: LinearGradient(
                begin: const Alignment(-1, 1),
                end: const Alignment(1, -1),
                colors: index.isEven
                    ? [
                        Color(0xFFCDB599),
                        Color(0xFFB2A181),
                        Color(0xFF978B6F),
                        Color(0xFF7C765D),
                      ]
                    : [
                        Color(0xFFFFC07F),
                        Color(0xFFFF6F91),
                        Color(0xFFC45AFF),
                        Color(0xFF5F49FF),
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(85),
                  // spreadRadius: 0.25,
                  blurRadius: 15.r,
                  offset: Offset(5.w, 2.h),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(30.r))),
          child: Padding(
            padding: EdgeInsets.all(50.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250.w,
                  height: 105.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Center(
                    child: Text(
                      '$date',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(25.r)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            '$Title',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 10,
                                    color: Theme.of(context).canvasColor),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}

class Details extends StatelessWidget {
  final String text;
  final bool shade;
  final IconData icon;
  const Details(
      {super.key, required this.text, required this.icon, this.shade = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 33.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        // padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: shade ? Colors.black.withOpacity(0.2) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
                height: 12.h,
                width: 12.w,
                margin: EdgeInsets.only(bottom: 13.h, left: 4.w),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 25.r,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 8.5, color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}