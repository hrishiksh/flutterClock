//this file is provided by the flutter team.
//as the task is to build the ui, I don't have made much modification to it.
import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:analog_clock/abstracts/constants.dart';
import 'package:analog_clock/clock/clock_design.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _condition = '';
  var _location = '';
  Timer _timer;
  bool twentyfour;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
      twentyfour = widget.model.is24HourFormat;
    });
  }

  void _updateTime() {
    setState(
      () {
        _now = DateTime.now();
        // Update once per second. Make sure to do it at the beginning of each
        // new second, so that the clock is accurate.
        _timer = Timer(
          Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
          _updateTime,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //let's define custome theme
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            //colors are defind on the abstract/constants.dart file
            primaryColor:
                kprimaryColorlight, //used for digital time, minute and hour hand
            accentColor:
                kbackgroundTextlight, //used for the background text color
            backgroundColor:
                kbackgroundColorlight, //used for the background color
          )
        : Theme.of(context).copyWith(
            primaryColor:
                kprimaryColordark, //used for digital time, minute and hour hand
            accentColor:
                kbackgroundTextdark, //used for the background text color
            backgroundColor:
                kbackgroundColordark, //used for the background color
          );

    final time = DateFormat.Hms().format(DateTime.now());
    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: AspectRatio(
        //as the clock should have a aspect ratio of 5:3
        aspectRatio: 5 / 3,
        child: ClockDesign(
          twentyfour: twentyfour,
          customTheme: customTheme,
          now: _now,
          temperature: _temperature,
          condition: _condition,
          location: _location,
        ),
      ),
    );
  }
}
