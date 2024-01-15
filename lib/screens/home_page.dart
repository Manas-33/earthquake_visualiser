import 'dart:ui';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:earthquake_visualiser/api/usgsController.dart';
import 'package:earthquake_visualiser/connections/lg.dart';
import 'package:earthquake_visualiser/models/flyto.dart';
import 'package:earthquake_visualiser/models/kml_helper.dart';
import 'package:earthquake_visualiser/screens/about_screen.dart';
import 'package:earthquake_visualiser/screens/button_screen.dart';
import 'package:earthquake_visualiser/screens/earthquake_1868.dart';
import 'package:earthquake_visualiser/screens/earthquake_1906.dart';
import 'package:earthquake_visualiser/screens/settings.dart';
import 'package:earthquake_visualiser/widget/custom_range_selector.dart';
import 'package:earthquake_visualiser/widget/kmlStrings.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.withOpacity(0.2),
              Colors.white,
              Colors.blue.withOpacity(.7),
              // Colors.blue
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      animateChildDecoration: true,
      rtlOpening: true,
      openScale: 0.8,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                    width: 300.h,
                    child: GestureDetector(
                      child: Text(
                        "Connect To Rig",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle item tap here
                        print('itemName" tapped');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            )); // Close the dialog after item tap if needed
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 50.h,
                    width: 300.h,
                    child: GestureDetector(
                      child: Text(
                        "LG Functions",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle item tap here
                        print('funct" tapped');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ButtonScreen(),
                            )); // Close the dialog after item tap if needed
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 50.h,
                    width: 300.h,
                    child: GestureDetector(
                      child: Text(
                        "About",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle item tap here
                        print('itemName" tapped');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            )); // Close the dialog after item tap if needed
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125.0),
            child: Container(
              // padding: const EdgeInsets.only(top: 10, left: 30.w),
              child: AppBar(
                  toolbarHeight: 150,
                  elevation: 0,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width * .1,
                        // padding: const EdgeInsets.only(bottom: 25),
                        child: Image.asset(
                          'assets/images/image.png',
                          scale: 1.85.w,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Earthquake Visualiser",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    Builder(
                        builder: (context) => Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: IconButton(
                                icon:
                                    ValueListenableBuilder<AdvancedDrawerValue>(
                                  valueListenable: _advancedDrawerController,
                                  builder: (_, value, __) {
                                    return AnimatedSwitcher(
                                      duration: Duration(milliseconds: 250),
                                      child: Icon(
                                        value.visible
                                            ? Icons.clear
                                            : Icons.menu,
                                        key: ValueKey<bool>(value.visible),
                                      ),
                                    );
                                  },
                                ),
                                onPressed: _handleMenuButtonPressed,
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       contentPadding: EdgeInsets.all(
                                //           16), // Adjust padding as needed
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(10.0),
                                //       ),
                                //       content: BackdropFilter(
                                //         filter: ImageFilter.blur(
                                //             sigmaX: 1, sigmaY: 1),
                                //         child: Container(
                                //           padding: const EdgeInsets.all(20),
                                //           height: 300.h,
                                //           width: 350.h,
                                //           child: Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [],
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );
                                // print("debug pressed");
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => SettingsPage(),
                                //     ));
                                // },
                              ),
                            ))
                  ]),
            ),
          ),
          body: MainChoices()),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class MainChoices extends StatefulWidget {
  const MainChoices({
    super.key,
  });

  @override
  State<MainChoices> createState() => _MainChoicesState();
}

class _MainChoicesState extends State<MainChoices> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(
        child: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.only(left: 30, bottom: 30, right: 30),
          // decoration: BoxDecoration(
          //     // color: Colors.grey,
          //     borderRadius: BorderRadius.circular(50)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bounceable(
                    onTap: () async {
                      FlyToView ftv = KmlHelper().getFlyToDetails(realtime);

                      LGConnection client = LGConnection();
                      await client.connectToLG();
                      await client
                          .sendToLG(realtime, "realtime", ftv)
                          .then((value) {
                        ToastService.showSuccessToast(
                          context,
                          length: ToastLength.medium,
                          expandedHeight: 100,
                          message: "Visualisation successful",
                        );
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 150.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.green.withOpacity(0.75),
                              Colors.blue.withOpacity(0.75),
                              // Colors.blue
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            "assets/images/realtime.png",
                            // color: Colors.white,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Realtime Quakes",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    )),
                Bounceable(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomRangeSelector(),
                          ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 150.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.green.withOpacity(0.75),
                              Colors.blue.withOpacity(0.75),
                              // Colors.blue
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SvgPicture.asset(
                          //   "assets/images/realtime2.svg",
                          //   color: Colors.white,
                          //   height: 50,
                          //   width: 50,
                          // ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            "assets/images/calendar.png",
                            // color: Colors.white,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Custom Range",
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bounceable(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Earthquake1868(),
                          ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 150.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.green.withOpacity(0.75),
                              Colors.blue.withOpacity(0.75),
                              // Colors.blue
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            "assets/images/earthquake2.png",
                            // color: Colors.white,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Text(
                              "1868 Hayward earthquake",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    )),
                Bounceable(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Earthquake1906(),
                          ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .4,
                      height: 150.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.green.withOpacity(0.75),
                              Colors.blue.withOpacity(0.75),
                              // Colors.blue
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            "assets/images/earthquake.png",
                            // color: Colors.white,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Text(
                              "1906 San Francisco earthquake",
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  overflow: TextOverflow.clip,
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * .25,
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            //   child: GestureDetector(
            //       onTap: () {}, child: Center(child: Text("Visualize it!"))),
            // ),

            // SizedBox(
            //   height: 10.h,
            // ),
          ]),
          // color: Colors.red,
        ),
      ),
    );
  }
}
