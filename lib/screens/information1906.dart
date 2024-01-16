import 'package:carousel_slider/carousel_slider.dart';
import 'package:earthquake_visualiser/connections/lg.dart';
import 'package:earthquake_visualiser/constants.dart';
import 'package:earthquake_visualiser/models/kml_helper.dart';
import 'package:earthquake_visualiser/widget/kmlStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class InfoScreen1906 extends StatefulWidget {
  const InfoScreen1906({super.key});

  @override
  State<InfoScreen1906> createState() => _InfoScreen1906State();
}

int x = 0;
goToPage1906(int index) {
  x = index;
}

class _InfoScreen1906State extends State<InfoScreen1906> {
  static const _colors = [
    Colors.green,
    Colors.blue,
  ];

  static const _durations = [
    4000,
    4000,
  ];

  static const _heightPercentages = [
    -0.05,
    0.0,
  ];
  late LGConnection lg;
  @override
  void initState() {
    lg = LGConnection();
    _connectToLG();
    super.initState();
  }

  Future<void> _connectToLG() async {
    bool? result = await lg.connectToLG();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      //Plate Boundary
      Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // border: Border.all()
        ),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ruptures Along Western North America",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "In addition to the 1906 rupture of the San Andreas fault in northern California, the San Andreas fault in south-central California also experienced a similar size earthquake in 1857, rupturing the San Andreas fault from Parkfield to just northwest of San Bernardino. A 112-mile (180 km) long creeping section exists on the central portion of the San Andreas between the 1857 and 1906 ruptures. The San Andreas fault southeast of San Bernardino has not experienced a major earthquake in the historical record, and paleoseismic investigations of this reach of the fault suggests it last ruptured in the late 17th Century. North of Cape Mendocino, the San Andreas fault merges with the plate boundary of the Cascadia subduction zone that lies offshore of northernmost California, Oregon, and Washington.",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("plate boundaries");

                          await lg.sendToLG(
                              earthquake06[0],
                              "plateboundaries06",
                              KmlHelper().getFlyToDetails(earthquake06[0]));
                        } catch (e) {
                          print("the error is $e");
                        }
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),

      //Bay area faults
      Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // border: Border.all(strokeAlign: BorderSide.strokeAlignOutside)
        ),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bay Area Faults",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "The San Francisco Bay Area is transected by a series of subparallel faults that together accommodate the relative motion between the Pacific and North American plates. The San Andreas Fault and 6 other significant fault zones are present in the Bay Area: the Calaveras, Concord-Green Valley, Greenville, Hayward, Rodgers Creek, and San Gregorio Faults. The faults shown here are represented by simple lines which do not convey how complicated they can be. In reality, active faults can be very complex, consisting of multiple breaks along curved, complex traces. See for yourself by examining the detailed mapping of the Hayward Fault.",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("bay area");

                          await lg.sendToLG(earthquake06[1], "bayarea06",
                              KmlHelper().getFlyToDetails(earthquake06[1]));
                        } catch (e) {
                          print("the error is $e");
                        }
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),

      //Historic Ruptures
      Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // border: Border.all()
        ),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Historic Ruptures",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "In the last half of the 1800’s, potentially damaging earthquakes (magnitude 6.0 or greater) occurred in the San Francisco Bay Area at an average rate of once every four years. However, seismicity rates dropped dramatically after the 1906 earthquake: scientists believe the large stress release of the 1906 earthquake also relieved stresses on faults throughout the Bay Area. Seismic activity was very low until the 1989 Loma Prieta (6.9 magnitude) earthquake. The level of seismic activity has not yet returned to that of the late 1800’s, but as stresses continue to build scientists expect more frequent and stronger earthquakes in the future. The following file is an interpretation of historic ruptures in the Bay Area from 1836 until today.",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("historic ruptures");

                          await lg.sendToLG(earthquake06[2], "historicrup06",
                              KmlHelper().getFlyToDetails(earthquake06[2]));
                        } catch (e) {
                          print("the error is $e");
                        }
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),

      //Rupture length and slip
      Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // border: Border.all()
        ),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rupture Length and Slip",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "The 1906 earthquake ruptured the northernmost 296 miles (477 km) of the San Andreas Fault between San Juan Bautista and Cape Mendocino. By comparison, the 1989 Loma Prieta earthquake had a rupture length of only 25 miles. The San Andreas fault today has locked and creeping segments along its approximately 800 mile (1300 km) length in California. The 1906 earthquake ruptured all locked segments of the fault in northern California. The amount of horizontal slip, or relative movement along the fault, varied from 2 to 32 feet (0.5 m to 9.7 m). ",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("rupture length");

                          await lg.sendToLG(earthquake06[3], "rupturelen06",
                              KmlHelper().getFlyToDetails(earthquake06[3]));
                        } catch (e) {
                          print("the error is $e");
                        }
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),

      //Shaking Intensity
      Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          //  border: Border.all()
        ),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Shaking Intensity",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Earthquake ruptures travel at phenomenal speeds. Seismologists have estimated the average speed of the 1906 rupture along the San Andreas Fault to the north of the epicenter to be 8,300 mi/hour (3.7 km/sec), and 6,300 mi/hour (2.8 km/sec) to the south. By comparison, a Boeing 747 jet cruises at only 550 mi/hour. The following rupture tour shows how fast the rupture traveled north from the 1906 epicenter. Most earthquake damage results from strong shaking. Damage caused by fault rupture, landslides, and ground failure typically accounts for only a small fraction of the total damage from earthquakes. The 1906 earthquake is remembered mainly for the fire damage in San Francisco, yet in most places throughout northern California shaking damage dominated.",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("shaking intensity");

                          await lg.sendToLG(earthquake06[4], "shaking06",
                              KmlHelper().getFlyToDetails(earthquake06[4]));
                        } catch (e) {
                          print("the error is $e");
                        }
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),

      //Photographs of Fault and Earthquake Damage
      Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // border: Border.all()
        ),
        child: Stack(children: [
          WaveWidget(
            config: CustomConfig(
              colors: _colors,
              durations: _durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: Colors.white,
            size: Size(MediaQuery.of(context).size.width * .8,
                MediaQuery.of(context).size.height),
            waveAmplitude: 5,
            isLoop: true,
            waveFrequency: 2,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.black,
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Photographs of Earthquake Damage",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .2,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "The 1906 earthquake was the first natural disaster to be well-documented by photographs. The Bancroft Library of the University of California, Berkeley, holds the single largest collection of 1906 photographs, including thousands from their own archive and those of contributing institutions. The file below includes 73 photographs taken at known locations, organized into groups showing fault rupture, shaking damage, landslides, and ground failure including liquefaction. This file also includes links to other collections of 1906 photographs, as well as to “then and now” repeat photography documenting changes in San Francisco over the past 100 years.",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .5,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("historical photss");

                          await lg.sendToLG(bayin1906, "photos06",
                              KmlHelper().getFlyToDetails(bayin1906));
                        } catch (e) {
                          print("the error is $e");
                        }
                      },
                      child: Text(
                        "Visualize it!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Information about the 1906 Earthquake",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: .6,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CarouselSlider(
              items: pages,
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 700,
                initialPage: x,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: const Duration(milliseconds: 5000),
                autoPlay: false,
              )),
        ));
  }
}
