
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animal_app/screens/home_screen.dart';
import 'package:simple_animal_app/cubits/animal_cubit.dart';
import 'package:simple_animal_app/widgets/animal_text_widget.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display Cat with clock icon initially', (WidgetTester tester) async {
			// Arrange
			final mockAnimalCubit = MockAnimalCubit();
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: HomeScreen(),
					),
				)
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('should display Dog with person icon after tap', (WidgetTester tester) async {
			// Arrange
			final mockAnimalCubit = MockAnimalCubit();
			whenListen<AnimalState>(
				mockAnimalCubit,
				Stream.fromIterable([Animal(name: 'Cat', icon: Icons.access_time), Animal(name: 'Dog', icon: Icons.person)]),
				initialState: Animal(name: 'Cat', icon: Icons.access_time)
			);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: HomeScreen(),
					),
				)
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
