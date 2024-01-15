import 'package:earthquake_visualiser/constants.dart';
import 'package:earthquake_visualiser/models/kml_helper.dart';
import 'package:earthquake_visualiser/widget/kmlStrings.dart';
import 'package:earthquake_visualiser/screens/earthquake_1868.dart';
import 'package:earthquake_visualiser/screens/information1906.dart';
import 'package:earthquake_visualiser/widget/custom_range_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:earthquake_visualiser/connections/lg.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

class Earthquake1906 extends StatefulWidget {
  const Earthquake1906({super.key});

  @override
  State<Earthquake1906> createState() => _Earthquake1906State();
}

class _Earthquake1906State extends State<Earthquake1906> {
  late LGConnection lg;
  @override
  void initState() {
    lg = LGConnection();
    _connectToLG();
    super.initState();
  }

 Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "The 1906 San Fransisco Earthquake",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 30, bottom: 30, right: 30),

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounceable(
                        onTap: () async {
                          try {
                            print("plate boundaries");

                            await lg
                                .sendToLG(
                                    earthquake06[0],
                                    "plateboundaries06",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake06[0]))
                                .then((value) {
                              goToPage1906(0);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1906()));
                            });
                          } catch (e) {
                            print("the error is $e");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 125.h,
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
                                "assets/images/tect.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Plate Boundaries",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w500,
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
                        onTap: () async {
                          try {
                            print("bay area");
                          
                            await lg
                                .sendToLG(
                                    earthquake06[1],
                                    "bayarea06",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake06[1]))
                                .then((value) {
                              goToPage1906(1);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1906()));
                            });
                          } catch (e) {
                            print("the error is $e");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 125.h,
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
                                "assets/images/fault.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Bay Area Faults",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w500,
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
                        onTap: () async {
                          try {
                            print("historic ruptures");
                         

                            await lg
                                .sendToLG(
                                    earthquake06[2],
                                    "historicrup06",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake06[2]))
                                .then((value) {
                              goToPage1906(2);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1906()));
                            });
                          } catch (e) {
                            print("the error is $e");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 125.h,
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
                                  "Historic Ruptures",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w500,
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
                        onTap: () async {
                          try {
                            print("rupture length");
                            

                            await lg
                                .sendToLG(
                                    earthquake06[3],
                                    "rupturelen06",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake06[3]))
                                .then((value) {
                              goToPage1906(3);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1906()));
                            });
                          } catch (e) {
                            print("the error is $e");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 125.h,
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
                                "assets/images/search.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Text(
                                  "Rupture Length and Slip",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w500,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounceable(
                        onTap: () async {
                          try {
                            print("shaking intensity");
                          

                            await lg
                                .sendToLG(
                                    earthquake06[4],
                                    "shaking06",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake06[4]))
                                .then((value) {
                              goToPage1906(4);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1906()));
                            });
                          } catch (e) {
                            print("the error is $e");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 125.h,
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
                                "assets/images/rumble.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Text(
                                  "Shaking Intensity",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w500,
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

                    //TODO this is not working
                    Bounceable(
                        onTap: () async {
                          try {
                            print("historical photss");
                           
                            await lg
                                .sendToLG(bayin1906, "photos06",
                                    KmlHelper().getFlyToDetails(bayin1906))
                                .then((value) {
                              goToPage1906(5);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1906()));
                            });
                          } catch (e) {
                            print("the error is $e");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 125.h,
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
                                "assets/images/oldcamera.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Text(
                                  "Historic Photos",
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      overflow: TextOverflow.clip,
                                      color: Colors.white,
                                      letterSpacing: .5,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w500,
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
                //       color: Colors.grey,
                //       borderRadius: BorderRadius.circular(12)),
                //   child: GestureDetector(
                //       onTap: () {},
                //       child: Center(child: Text("Visualize it!"))),
                // ),

                // SizedBox(
                //   height: 10.h,
                // ),
              ]),
              // color: Colors.red,
            ),
          ),
        ));
  }
}
