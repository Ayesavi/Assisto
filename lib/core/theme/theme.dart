import "package:assisto/core/theme/color_schemes.g.dart";
import "package:flutter/material.dart";
import "package:material_color_utilities/hct/hct.dart";
import "package:material_color_utilities/palettes/tonal_palette.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme get lightScheme => lightColorScheme;

  ThemeData light() {
    return theme(lightScheme);
  }

  ThemeData lightContrast() {
    return theme(lightColorScheme);
  }

  // static MaterialScheme lightHighContrastScheme() {
  //   return const MaterialScheme(
  //     brightness: Brightness.light,
  //     primary: Color(0xff002051),
  //     surfaceTint: Color(0xff465d91),
  //     onPrimary: Color(0xffffffff),
  //     primaryContainer: Color(0xff294174),
  //     onPrimaryContainer: Color(0xffffffff),
  //     secondary: Color(0xff1b2233),
  //     onSecondary: Color(0xffffffff),
  //     secondaryContainer: Color(0xff3c4355),
  //     onSecondaryContainer: Color(0xffffffff),
  //     tertiary: Color(0xff311933),
  //     onTertiary: Color(0xffffffff),
  //     tertiaryContainer: Color(0xff553a56),
  //     onTertiaryContainer: Color(0xffffffff),
  //     error: Color(0xff4e0002),
  //     onError: Color(0xffffffff),
  //     errorContainer: Color(0xff8c0009),
  //     onErrorContainer: Color(0xffffffff),
  //     background: Color(0xfffaf8ff),
  //     onBackground: Color(0xff1a1b20),
  //     surface: Color(0xfffaf8ff),
  //     onSurface: Color(0xff000000),
  //     surfaceVariant: Color(0xffe1e2ec),
  //     onSurfaceVariant: Color(0xff21242b),
  //     outline: Color(0xff40434b),
  //     outlineVariant: Color(0xff40434b),
  //     shadow: Color(0xff000000),
  //     scrim: Color(0xff000000),
  //     inverseSurface: Color(0xff2f3036),
  //     inverseOnSurface: Color(0xffffffff),
  //     inversePrimary: Color(0xffe7ebff),
  //     primaryFixed: Color(0xff294174),
  //     onPrimaryFixed: Color(0xffffffff),
  //     primaryFixedDim: Color(0xff0f2b5c),
  //     onPrimaryFixedVariant: Color(0xffffffff),
  //     secondaryFixed: Color(0xff3c4355),
  //     onSecondaryFixed: Color(0xffffffff),
  //     secondaryFixedDim: Color(0xff262c3e),
  //     onSecondaryFixedVariant: Color(0xffffffff),
  //     tertiaryFixed: Color(0xff553a56),
  //     onTertiaryFixed: Color(0xffffffff),
  //     tertiaryFixedDim: Color(0xff3d243e),
  //     onTertiaryFixedVariant: Color(0xffffffff),
  //     surfaceDim: Color(0xffdad9e0),
  //     surfaceBright: Color(0xfffaf8ff),
  //     surfaceContainerLowest: Color(0xffffffff),
  //     surfaceContainerLow: Color(0xfff4f3fa),
  //     surfaceContainer: Color(0xffeeedf4),
  //     surfaceContainerHigh: Color(0xffe8e7ef),
  //     surfaceContainerHighest: Color(0xffe2e2e9),
  //   );
  // }

  static ColorScheme get darkScheme {
    return darkColorScheme;
  }

  ThemeData darkMediumContrast() {
    return theme(darkColorScheme);
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        dividerTheme:
            DividerThemeData(thickness: 2, color: colorScheme.outline),
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

extension Material3Palette on Color {
  Color tone(int tone) {
    assert(tone >= 0 && tone <= 100);
    final color = Hct.fromInt(value);
    final tonalPalette = TonalPalette.of(color.hue, color.chroma);
    return Color(tonalPalette.get(tone));
  }
}
