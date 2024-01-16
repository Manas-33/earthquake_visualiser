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

class InfoScreen1868 extends StatefulWidget {
  const InfoScreen1868({super.key});

  @override
  State<InfoScreen1868> createState() => _InfoScreen1868State();
}

int x = 0;
goToPage(int index) {
  x = index;
}

class _InfoScreen1868State extends State<InfoScreen1868> {
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
  late LGConnection ssh;
  @override
  void initState() {
    ssh = LGConnection();
    _connectToLG();
    super.initState();
  }

  Future<void> _connectToLG() async {
    bool? result = await ssh.connectToLG();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      //Bay area
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
                      "How close to a fault do you live? The San Francisco Bay Area is sliced and diced by a series of faults that together accommodate the relative motion between the Pacific and North American plates. This Google Earth file shows the 8 significant earthquake producing faults in the Bay Area: the Hayward, Calaveras, Concord-Green Valley, Greenville, Rodgers Creek, San Andreas, Mt. Diablo, and San Gregorio Faults. In these files, the faults are represented by simple lines which do not convey how complicated they are.",
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
                          print("Bay Area Faults");
                          await ssh.sendToLG(
                              earthquake68[0],
                              "bayAreaAFaults68",
                              KmlHelper().getFlyToDetails(earthquake68[0]));
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

      //Global Positioning Systems (GPS)
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
                      "Global Positioning Systems (GPS)",
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
                      "Do you have a GPS on your cell phone? Well, scientists use highly-accurate GPS devices to measure the locations of benchmarks throughout the Bay Area, which they re-occupy over a span of years to measure how these benchmarks have moved. The arrows shown in this Google Earth file represent movement of benchmarks in the Bay Area over time. The length of the arrows shows the rate at which the benchmarks are moving.",
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
                          print("Global Positioning Systems ");

                          await ssh.sendToLG(
                              gps, "gps68", KmlHelper().getFlyToDetails(gps));
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

      //InSAR
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
                      "InSAR",
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
                      "Can movement along earthquake faults be detected from space? Yes, InSAR (Interferometric synthetic aperture radar) is a remote sensing method that uses satellite radar data to measure ground movement. Scientists produce maps like the one in this Google Earth file that shows ground deformation. Satellites passing above the ground emit radar that bounces off the earth and returns back to the satellite, measuring the topography of the earth. The satellite then re-images the same location after a period of time, which allows scientists to detect changes in the earth’s surface. The warmer colors indicate greater movement relative to the satellite.",
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
                          print("insar");

                          await ssh.sendToLG(insar, "insar68",
                              KmlHelper().getFlyToDetails(insar));
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
                      "What is shaking intensity? Most earthquake damage results from strong shaking, not from fault rupture, landslides, and ground failure. Since there were no seismic instruments in 1868, USGS scientists have used historic photographs and accounts of the damage it caused to produce a detailed map of the shaking intensity of the 1868 earthquake. This Google Earth file shows the 1868 “ShakeMap” and quotes from some of the historic accounts that were used to create it. The intensity of shaking that an area experiences during an earthquake depends on the magnitude of the earthquake, the site’s distance from the fault, and the type of geologic material at the site. Soft, water saturated sands and sediments amplify shaking even at great distances from an earthquake, while bedrock shakes to a much lesser extent.",
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
                          print("shaking");

                          await ssh.sendToLG(earthquake68[3], "shaking68",
                              KmlHelper().getFlyToDetails(earthquake68[3]));
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

      //Bedrock vs. Soft Ground
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
                      "Bedrock vs. Soft Ground",
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
                      "Do you live on soft ground or bedrock? A major factor affecting the shaking intensity at a site during an earthquake is the type of geologic material underneath that site. Materials in low-lying areas (where most of the people in the Bay Area live and work) consist of deep, loose soils that tend to amplify and prolong shaking more than firmer material on hillsides. This Google Earth file shows the general geology of the Bay Area - areas that consist of soft soils in the low-lying regions and areas of bedrock on the hillsides. A detailed geologic map of the Bay Area is also available.",
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
                          print("bed vs soft");

                          await ssh.sendToLG(earthquake68[4], "bedsoft",
                              KmlHelper().getFlyToDetails(earthquake68[4]));
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

      //The Bay Area in 1868
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
                      "The Bay Area in 1868",
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
                      "What was the Bay Area like in 1868? This Google Earth file shows the main transportation routes in the 1860’s, photographs showing earthquake damage from throughout the Bay Area from 1868, and modern photos showing what these same locations look like today. The 1868 earthquake caused damage throughout the Bay Area, then having a total population of about 260,000. Property loss was extensive and 30 people were killed. Damage was most severe in Hayward and nearby towns along the Hayward Fault in Alameda County. About 500 people lived in Hayward where almost every building in town was extensively damaged or wrecked.",
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
                          print("bay area in 68");

                          await ssh.sendToLG(bayin1868, "bayin68",
                              KmlHelper().getFlyToDetails(bayin1868));
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
                "Information about the 1868 Hayward Earthquake",
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
