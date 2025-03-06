import 'dart:ui';

class ScreenUtil {
  static final ScreenUtil _instance = ScreenUtil._();
  static const int defaultWidth = 414;
  static const int defaultHeight = 896;

  /// Size of the phone in UI Design , px
  num uiWidthPx = defaultWidth;
  num uiHeightPx = defaultHeight;

  /// allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  bool allowFontScaling = false;

  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _pixelRatio = 1;
  static double _statusBarHeight = 0;
  static double _bottomBarHeight = 0;
  static double _textScaleFactor = 1;

  ScreenUtil._();

  factory ScreenUtil() => _instance;

  static void init(
      {num width = defaultWidth,
        num height = defaultHeight,
        bool allowFontScaling = false}) {
    _instance.uiWidthPx = width;
    _instance.uiHeightPx = height;
    _instance.allowFontScaling = allowFontScaling;

    _pixelRatio = window.devicePixelRatio;
    _screenWidth = window.physicalSize.width;
    _screenHeight = window.physicalSize.height;
    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;
    _textScaleFactor = window.textScaleFactor;
  }

  /// The number of font pixels for each logical pixel.
  static double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  static double get screenWidth => _screenWidth / _pixelRatio;

  ///The vertical extent of this size. dp
  static double get screenHeight => _screenHeight / _pixelRatio;

  /// The vertical extent of this size. px
  static double get screenWidthPx => _screenWidth;

  /// The vertical extent of this size. px
  static double get screenHeightPx => _screenHeight;

  /// The offset from the top
  static double get statusBarHeight => _statusBarHeight / _pixelRatio;

  /// The offset from the top
  static double get statusBarHeightPx => _statusBarHeight;

  /// The offset from the bottom.
  static double get bottomBarHeight => _bottomBarHeight;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => screenWidth / uiWidthPx;

  double get scaleHeight =>
      (_screenHeight - _statusBarHeight - _bottomBarHeight) / uiHeightPx;

  double get scaleText => scaleWidth;

  /// Width function
  num setWidth(num width) => width * scaleWidth;

  /// Height function
  num setHeight(num height) => height * scaleHeight;

  /// FontSize function
  num setSp(num fontSize, {bool allowFontScalingSelf = false}) =>
      allowFontScalingSelf
          ? (fontSize * scaleText)
          : ((fontSize * scaleText) / _textScaleFactor);
}
