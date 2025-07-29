import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tp_dropdown_2list/dropdown_2list.dart';

void main() {
  group('Dropdown2List Widget Tests', () {
    testWidgets('should render dropdown with correct properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Dropdown2List(
              labelFirstList: 'Category A',
              labelSecondList: 'Category B',
              idItemsFirstList: ['id1', 'id2'],
              idItemsSecondList: ['id3', 'id4'],
              itemsFirstList: ['Item 1', 'Item 2'],
              itemsSecondList: ['Item 3', 'Item 4'],
              hintText: 'Select an option',
              backgroundColor: Colors.blue,
              dropdownBackgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
              width: 300,
              height: 50,
              dropdownIcon: Icons.arrow_drop_down,
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
      expect(find.byType(Dropdown2List), findsOneWidget);
    });

    testWidgets('should show hint text when no item is selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Dropdown2List(
              labelFirstList: 'Category A',
              labelSecondList: 'Category B',
              idItemsFirstList: ['id1'],
              idItemsSecondList: ['id2'],
              itemsFirstList: ['Item 1'],
              itemsSecondList: ['Item 2'],
              hintText: 'Please select',
              backgroundColor: Colors.blue,
              dropdownBackgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
              width: 300,
              height: 50,
              dropdownIcon: Icons.arrow_drop_down,
            ),
          ),
        ),
      );

      expect(find.text('Please select'), findsOneWidget);
    });

    testWidgets('should handle tap to open dropdown',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Dropdown2List(
              labelFirstList: 'Category A',
              labelSecondList: 'Category B',
              idItemsFirstList: ['id1'],
              idItemsSecondList: ['id2'],
              itemsFirstList: ['Item 1'],
              itemsSecondList: ['Item 2'],
              hintText: 'Select an option',
              backgroundColor: Colors.blue,
              dropdownBackgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
              width: 300,
              height: 50,
              dropdownIcon: Icons.arrow_drop_down,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Dropdown2List));
      await tester.pumpAndSettle();

      // The dropdown should be visible after tap
      expect(find.text('Category A'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('should handle single selection callback',
        (WidgetTester tester) async {
      String? selectedId;
      String? selectedText;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Dropdown2List(
              labelFirstList: 'Category A',
              labelSecondList: 'Category B',
              idItemsFirstList: const ['id1'],
              idItemsSecondList: const ['id2'],
              itemsFirstList: const ['Item 1'],
              itemsSecondList: const ['Item 2'],
              hintText: 'Select an option',
              backgroundColor: Colors.blue,
              dropdownBackgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
              width: 300,
              height: 50,
              dropdownIcon: Icons.arrow_drop_down,
              onItemSelected: (id, text) {
                selectedId = id;
                selectedText = text;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Dropdown2List));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(selectedId, equals('id1'));
      expect(selectedText, equals('Item 1'));
    });

    testWidgets('should handle multi-select mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Dropdown2List(
              labelFirstList: 'Category A',
              labelSecondList: 'Category B',
              idItemsFirstList: ['id1', 'id2'],
              idItemsSecondList: ['id3'],
              itemsFirstList: ['Item 1', 'Item 2'],
              itemsSecondList: ['Item 3'],
              hintText: 'Select options',
              backgroundColor: Colors.blue,
              dropdownBackgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
              width: 300,
              height: 50,
              dropdownIcon: Icons.arrow_drop_down,
              isMultiSelect: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Dropdown2List));
      await tester.pumpAndSettle();

      // In multi-select mode, checkboxes should be visible
      expect(find.byType(Checkbox), findsNWidgets(3)); // 3 items total
    });
  });
}
