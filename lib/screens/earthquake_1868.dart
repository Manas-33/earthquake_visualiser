import 'package:dartssh2/dartssh2.dart';
import 'package:earthquake_visualiser/connections/lg.dart';
import 'package:earthquake_visualiser/constants.dart';
import 'package:earthquake_visualiser/models/kml_helper.dart';
import 'package:earthquake_visualiser/screens/information1868.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:earthquake_visualiser/connections/lg.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:earthquake_visualiser/widget/kmlStrings.dart';

class Earthquake1868 extends StatefulWidget {
  const Earthquake1868({super.key});

  @override
  State<Earthquake1868> createState() => _Earthquake1868State();
}

bool connectionStatus = false;

class _Earthquake1868State extends State<Earthquake1868> {
  late LGConnection ssh;
  @override
  void initState() {
    // TODO: implement initState
    ssh = LGConnection();
    _connectToLG();
    super.initState();
  }

  Future<void> _connectToLG() async {
    bool? result = await ssh.connectToLG();
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
                          "Earthquake Visualiser",
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
                            print("Bay Area Faults");
                            await ssh
                                .sendToLG(
                                    earthquake68[0],
                                    "bayAreaAFaults68",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake68[0]))
                                .then((value) {
                              goToPage(0);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1868()));
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

                    //TODO this is not working
                    Bounceable(
                        onTap: () async {
                          try {
                            print("Global Positioning Systems ");
                            

                            await ssh
                                .sendToLG(gps, "gps68",
                                    KmlHelper().getFlyToDetails(gps))
                                .then((value) {
                              goToPage(1);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1868()));
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
                                "assets/images/gps.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Global Positioning Systems ",
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
                    //TODO this is not working
                    Bounceable(
                        onTap: () async {
                          try {
                            print("insar");
                            

                            await ssh
                                .sendToLG(insar, "insar68",
                                    KmlHelper().getFlyToDetails(insar))
                                .then((value) {
                              goToPage(2);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1868()));
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
                                "assets/images/satellite.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Text(
                                  "InSAR",
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
                            print("shaking");
                            
                            await ssh
                                .sendToLG(
                                    earthquake68[3],
                                    "shaking68",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake68[3]))
                                .then((value) {
                              goToPage(3);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1868()));
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
                            print("bed vs soft");
                            

                            await ssh
                                .sendToLG(
                                    earthquake68[4],
                                    "bedsoft",
                                    KmlHelper()
                                        .getFlyToDetails(earthquake68[4]))
                                .then((value) {
                              goToPage(4);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1868()));
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
                                "assets/images/bedrock.png",
                                // color: Colors.white,
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Text(
                                  "Bedrock vs. Soft Ground",
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
                            print("bay area in 68");
                            
                            await ssh
                                .sendToLG(bayin1868, "bayin68",
                                    KmlHelper().getFlyToDetails(bayin1868))
                                .then((value) {
                              goToPage(5);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen1868()));
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
                                width: 15,
                              ),
                              Icon(
                                Icons.av_timer,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Text(
                                  "The Bay Area in 1868",
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
