// this file cotain classes that halps our clock to be responsive.
/*
I tried to mimick the css grid style
as i like the grid very much, I make the whole screen into 100*100 blocks
and placed the component according to this

Here I use mainly mediaqueries to figure out the width and heights.
*/
import 'package:flutter/widgets.dart';

class Responsive {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  static double screenWidth;
  static double boxSizeHorizontal;
  static double boxSizeVerticle;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    boxSizeHorizontal = screenWidth / 100;
    boxSizeVerticle = screenHeight / 100;
  }
}

//Manupulating digital clock font depending on the screensize
class DigitalClockFont {
  final double gridwidth;
  DigitalClockFont({this.gridwidth});
  double fontsize() {
    //this resize the font linearly according to the device width
    return gridwidth * 15;
  }
}

class DigitalBackgroundFont {
  final double gridwidth;
  DigitalBackgroundFont({this.gridwidth});
  double fontsize() {
    //this resize the font linearly according to the device width
    return gridwidth * 23;
  }
}
