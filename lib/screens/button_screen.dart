import 'package:earthquake_visualiser/api/usgsController.dart';
import 'package:earthquake_visualiser/constants.dart';
import 'package:earthquake_visualiser/models/flyto.dart';
import 'package:earthquake_visualiser/models/kml_helper.dart';
import 'package:earthquake_visualiser/widget/kmlStrings.dart';
import 'package:earthquake_visualiser/widget/connection_flag.dart';
import 'package:flutter/material.dart';
// TODO 12: Import connections/ssh.dart
import 'package:earthquake_visualiser/connections/lg.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xml/xml.dart';

bool connectionStatus = false;
// TODO 17: Initialize const String searchPlace
const String place = "India";

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  // TODO 13: Initialize SSH instance just like you did in the settings_page.dart, just uncomment the lines below, this time use the same instance for each of the tasks
  late LGConnection lg;
  @override
  void initState() {
    super.initState();
    lg = LGConnection();
    _connectToLG();
  }

  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
    setState(() {
      connectionStatus = result!;
    });
  }

  USGSController usgs = USGSController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Liquid Galaxy Functions",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Colors.black,
              letterSpacing: .5,
              // fontSize: 3.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await Navigator.pushNamed(context, '/settings');
              _connectToLG();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10, left: 20),
              width: 200,
              child: ConnectionFlag(
                status: connectionStatus,
              )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Bounceable(
                        onTap: () async {
                          await lg.relaunchLG();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 180.h,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Icon(
                                Icons.replay_sharp,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Relaunch Rig",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Bounceable(
                        onTap: () async {
                          await lg.shutdownLG();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 180.h,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Icon(
                                Icons.power_settings_new_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Shut Down Rig",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Bounceable(
                        onTap: () async {
                          await lg.cleanVisualization();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 180.h,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Icon(
                                Icons.cleaning_services_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Clean KML",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Bounceable(
                        onTap: () async {
                          await lg.rebootLG();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 180.h,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Icon(
                                Icons.restart_alt,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Reboot Rig",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Bounceable(
                        onTap: () async {
                          await lg.searchPlace("India");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 180.h,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Icon(
                                Icons.search_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Search Command",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Bounceable(
                        onTap: () async {
                          await lg.sendToLG("kmlthis", "nameod",
                              KmlHelper().getFlyToDetails("kmlthis"));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          height: 180.h,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 15,
                              // ),
                              Icon(
                                Icons.public_rounded,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Send KML",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: .5,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
