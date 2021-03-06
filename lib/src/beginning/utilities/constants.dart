import 'package:flutter/material.dart';
import 'package:phoenix/src/beginning/widgets/custom/ripple.dart';

/// The default black Color
Color kMaterialBlack = const Color(0xFF000000);

/// Green/Correct Color
Color kCorrect = const Color(0xFF1DB954);

/// Roundedness of widgets
double kRounded = 12;

/// Phoenix color
Color kPhoenixColor = const Color(0xFF028ac4);

/// Crossfade duration.
int crossfadeDuration = 300;

/// Blur constant for artwork background
double artworkBlurConst = 14;

/// Blur constant for glass shadow
double glassShadowBlur = 13;

/// Shadow ffset of every glassmorphic widgets
Offset kShadowOffset = const Offset(0, 3);

/// Shadow for nowart
BoxShadow nowArtShadow =
    BoxShadow(color: Colors.black54, blurRadius: 13.0, offset: kShadowOffset);

/// Aesthetic Quotes.
Map quotes = {
  "İnanmak istemiyorum. Bilmek istiyorum.": "Carl Sagan",
  "Gerçek şu ki, siyah bir buket gibi, Para hepimizi köleleştirdi, yaptığımız kurşunlar ve bombalar, oh, hayır.":
      "Stephen Swartz",
  "Hiçbir çocuğumuz açlıktan ölmemeli, bizim için ölmemeli.":
      "Stephen Swartz",
  "Bana verilene güvenebilir miyim?\n İnanç hala bir silaha ihtiyaç duyduğunda.":
      "Stephen Swartz"
};

/// Changelogs
Map<String, String> changelogs = {
  "HERTZ - 2.0.0": "• Initial Awaken release.\n• Rebuilt entire app.",
  "FALL - 2.1.0":
      "• Add option to change default artwork.\n• Add option to change glass look.\n• Add pull to refresh.",
  "FORTRESS - 2.2.0":
      "• Biggest update ever — literally, app is almost thrice the size it used to be.\n• Add ringtone/crossfade/trim.\n• New search UI.\n• New now playing design.\n• Wider lyrics support.\n• Progress bar in mini-playing.\n• Performance improvements.\n• Minor UI changes.\n• Accurate artworks for songs.\n• Support editing songs for all android versions.\n• Smoother seekbar.",
  "PERSEUS - 2.3.0":
      "• Upstream everything.\n• Fix crashes during loading.\n• Sort music in albums with date."
};

/// Theme data of entire app
ThemeData themeOfApp = ThemeData(
  splashFactory: CustomRipple.splashFactory,
  unselectedWidgetColor: Colors.grey[900],
  scaffoldBackgroundColor: kMaterialBlack,
  fontFamily: "Urban",
  scrollbarTheme: ScrollbarThemeData(
    interactive: true,
    isAlwaysShown: false,
    radius: const Radius.circular(50),
    thickness: MaterialStateProperty.all(4),
    crossAxisMargin: 2,
    thumbColor: MaterialStateProperty.all(Colors.white30),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
);

/// BoxContraints for artwork shape in listtile
BoxConstraints kSqrConstraint = const BoxConstraints(
  minWidth: 48,
  minHeight: 48,
  maxWidth: 48,
  maxHeight: 48,
);
BoxConstraints kRectConstraint = const BoxConstraints(
  minWidth: 44,
  minHeight: 44,
  maxWidth: 64,
  maxHeight: 64,
);
