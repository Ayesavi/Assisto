import "package:flutter/material.dart";
import "package:material_color_utilities/hct/hct.dart";
import "package:material_color_utilities/palettes/tonal_palette.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  ThemeData light() {
    return theme(ColorScheme.fromSeed(
        seedColor: const Color(0xff1e1e1e),
        primary: const Color(0xff005fff), // Primary color

        dynamicSchemeVariant: DynamicSchemeVariant.fidelity));
  }

  ThemeData dark() {
    return theme(ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xff1e1e1e),
        primary: const Color(0xff005fff).tone(60),
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity));
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: colorScheme.inversePrimary),
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          minimumSize: const WidgetStatePropertyAll(
            Size(double.infinity, 50),
          ),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          minimumSize: const WidgetStatePropertyAll(
            Size(double.infinity, 50),
          ),
        )),
        inputDecorationTheme: InputDecorationTheme(
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: colorScheme.onInverseSurface),
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        canvasColor: colorScheme.surface,
      );

  /// green
  static const green = ExtendedColor(
    seed: Color(0xff122903),
    value: Color(0xff122903),
    light: ColorFamily(
      color: Color(0xff476730),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc8eea8),
      onColorContainer: Color(0xff0b2000),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff476730),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc8eea8),
      onColorContainer: Color(0xff0b2000),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff476730),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffc8eea8),
      onColorContainer: Color(0xff0b2000),
    ),
    dark: ColorFamily(
      color: Color(0xffacd28e),
      onColor: Color(0xff1a3705),
      colorContainer: Color(0xff304f1a),
      onColorContainer: Color(0xffc8eea8),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffacd28e),
      onColor: Color(0xff1a3705),
      colorContainer: Color(0xff304f1a),
      onColorContainer: Color(0xffc8eea8),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffacd28e),
      onColor: Color(0xff1a3705),
      colorContainer: Color(0xff304f1a),
      onColorContainer: Color(0xffc8eea8),
    ),
  );

  /// lushGreen
  static const lushGreen = ExtendedColor(
    seed: Color(0xff002f30),
    value: Color(0xff002f30),
    light: ColorFamily(
      color: Color(0xff00696b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9cf1f3),
      onColorContainer: Color(0xff002020),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff00696b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9cf1f3),
      onColorContainer: Color(0xff002020),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff00696b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff9cf1f3),
      onColorContainer: Color(0xff002020),
    ),
    dark: ColorFamily(
      color: Color(0xff80d4d6),
      onColor: Color(0xff003738),
      colorContainer: Color(0xff004f51),
      onColorContainer: Color(0xff9cf1f3),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff80d4d6),
      onColor: Color(0xff003738),
      colorContainer: Color(0xff004f51),
      onColorContainer: Color(0xff9cf1f3),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff80d4d6),
      onColor: Color(0xff003738),
      colorContainer: Color(0xff004f51),
      onColorContainer: Color(0xff9cf1f3),
    ),
  );

  /// yellow
  static const yellow = ExtendedColor(
    seed: Color(0xffae8800),
    value: Color(0xffae8800),
    light: ColorFamily(
      color: Color(0xff745b0c),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdf91),
      onColorContainer: Color(0xff241a00),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff745b0c),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdf91),
      onColorContainer: Color(0xff241a00),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff745b0c),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdf91),
      onColorContainer: Color(0xff241a00),
    ),
    dark: ColorFamily(
      color: Color(0xffe5c36c),
      onColor: Color(0xff3e2e00),
      colorContainer: Color(0xff594400),
      onColorContainer: Color(0xffffdf91),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffe5c36c),
      onColor: Color(0xff3e2e00),
      colorContainer: Color(0xff594400),
      onColorContainer: Color(0xffffdf91),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffe5c36c),
      onColor: Color(0xff3e2e00),
      colorContainer: Color(0xff594400),
      onColorContainer: Color(0xffffdf91),
    ),
  );

  /// red
  static const red = ExtendedColor(
    seed: Color(0xff710e00),
    value: Color(0xff710e00),
    light: ColorFamily(
      color: Color(0xff904b3d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad3),
      onColorContainer: Color(0xff3a0a03),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff904b3d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad3),
      onColorContainer: Color(0xff3a0a03),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff904b3d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffdad3),
      onColorContainer: Color(0xff3a0a03),
    ),
    dark: ColorFamily(
      color: Color(0xffffb4a5),
      onColor: Color(0xff561f14),
      colorContainer: Color(0xff733427),
      onColorContainer: Color(0xffffdad3),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffb4a5),
      onColor: Color(0xff561f14),
      colorContainer: Color(0xff733427),
      onColorContainer: Color(0xffffdad3),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffb4a5),
      onColor: Color(0xff561f14),
      colorContainer: Color(0xff733427),
      onColorContainer: Color(0xffffdad3),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        green,
        lushGreen,
        yellow,
        red,
      ];
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
