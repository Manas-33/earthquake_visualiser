import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:earthquake_visualiser/api/usgsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CustomRangeSelector extends StatefulWidget {
  const CustomRangeSelector({super.key});

  @override
  State<CustomRangeSelector> createState() => _CustomRangeSelectorState();
}

class _CustomRangeSelectorState extends State<CustomRangeSelector> {
  String startDate = "2024-01-09";
  String endDate = "2024-01-12";
  USGSController usgs = USGSController();
  TextEditingController _magnitudeController = TextEditingController();
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now(),
  ];

  String _getValueText(
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (values.isNotEmpty) {
      final s = values[0].toString().replaceAll('00:00:00.000', '');
      final e = values.length > 1
          ? values[1].toString().replaceAll('00:00:00.000', '')
          : 'null';
      valueText = '$s to $e';
      setState(() {
        startDate = s;
        endDate = e;
      });
      print("$startDate");
      print("$endDate");
    } else {
      return 'null';
    }
    // print("this is debug $valueText");
    return valueText;
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.purple[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Container(
      // width: 400,
      // padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // padding: EdgeInsets.only(righ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black, // Set the bottom border color
                  width: 2.0, // Set the bottom border width
                ),
              ),
            ),
            width: 430,
            height: 50,
            child: GestureDetector(
              onTap: () async {
                final values = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: config,
                  dialogSize: const Size(325, 400),
                  borderRadius: BorderRadius.circular(15),
                  value: _dialogCalendarPickerValue,
                  dialogBackgroundColor: Colors.white,
                );
                if (values != null) {
                  // ignore: avoid_print
                  print(_getValueText(
                    values,
                  ));
                  setState(() {
                    _dialogCalendarPickerValue = values;
                  });
                }
              },
              child: Container(
                alignment: Alignment.bottomLeft,
                width: 450,
                height: 50,
                child: Text(
                  "$startDate - $endDate",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      letterSpacing: .5,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
              // alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  top: 100, left: 50, bottom: 50, right: 50),
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
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Container(
                        // padding: EdgeInsets.only(right: 50),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white
                                // Colors.blue
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        width: 500,
                        child: Container(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select the range",
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              _buildCalendarDialogButton(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white,
                                Colors.white
                                // Colors.blue
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        width: 500,
                        child: Container(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Minimum Magnitude",
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    letterSpacing: .5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: TextFormField(
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontSize: 6.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  controller: _magnitudeController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        var value = _magnitudeController.text;
                        if (value.isEmpty) {
                          print("object");
                          return;
                        }
                        final number = double.tryParse(value);
                        if (number == null || number < 1 || number > 10) {
                          String _getValueText(
                            List<DateTime?> values,
                          ) {
                            values = values
                                .map((e) =>
                                    e != null ? DateUtils.dateOnly(e) : null)
                                .toList();
                            var valueText =
                                (values.isNotEmpty ? values[0] : null)
                                    .toString()
                                    .replaceAll('00:00:00.000', '');

                            if (values.isNotEmpty) {
                              final startDateString = values[0]
                                  .toString()
                                  .replaceAll('00:00:00.000', '');
                              final endDateString = values.length > 1
                                  ? values[1]
                                      .toString()
                                      .replaceAll('00:00:00.000', '')
                                  : 'null';

                              DateTime startDate1 =
                                  DateTime.parse(startDateString);
                              DateTime endDate1 = DateTime.parse(endDateString);

                              if (startDate1.isAfter(DateTime.now()) ||
                                  (endDate1.isAfter(DateTime.now()))) {
                                //
                              }

                              valueText = '$startDateString to $endDateString';
                              setState(() {
                                startDate = startDateString;
                                endDate = endDateString;
                              });
                              print("$startDate");
                              print("$endDate");
                            } else {
                              return 'null';
                            }
                            // print("this is debug $valueText");
                            return valueText;
                          }

                          print('Please enter a number between 1 and 10');
                          return;
                        } else {
                          await usgs.getKML(startDate, endDate, number);
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
              // color: Colors.red,
            ),
          ),
        ));
  }
}
