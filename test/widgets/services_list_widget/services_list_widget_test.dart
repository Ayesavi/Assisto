import 'package:assisto/models/service_model/service_model.dart';
import 'package:assisto/widgets/services_list_widget/services_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServicesList Widget Tests', () {
    final mockServices = [
      const ServiceModel(
          name: 'Eldercare',
          imageUrl: "https://www.svgrepo.com/show/525187/washing-machine.svg"),
      const ServiceModel(
          name: 'Plumbing',
          imageUrl: "https://www.svgrepo.com/show/525187/washing-machine.svg"),
      const ServiceModel(
          name: 'Teaching',
          imageUrl: "https://www.svgrepo.com/show/525187/washing-machine.svg"),
    ];

    testWidgets('renders without errors', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ServicesList(
              services: mockServices,
              onPressViewAll: () {},
            ),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ServicesList), findsOneWidget);
    });

    testWidgets('displays all services', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ServicesList(
              services: mockServices,
              onPressViewAll: () {},
            ),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      for (var service in mockServices) {
        expect(find.text(service.name), findsOneWidget);
        expect(find.byElementType(SvgPicture), findsOneWidget);
      }
    });

    testWidgets('displays "View All" button and triggers callback',
        (WidgetTester tester) async {
      // Arrange
      var isButtonPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ServicesList(
              services: mockServices,
              onPressViewAll: () {
                isButtonPressed = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('View All >>'));
      await tester.pumpAndSettle();

      // Assert
      expect(isButtonPressed, isTrue);
    });

    testWidgets('displays horizontal list of services',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ServicesList(
              services: mockServices,
              onPressViewAll: () {},
            ),
          ),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(mockServices.length + 1));
    });
  });
}
