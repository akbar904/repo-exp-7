
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_animal_app/widgets/animal_text_widget.dart';
import 'package:simple_animal_app/cubits/animal_cubit.dart';
import 'package:simple_animal_app/models/animal_model.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalTextWidget', () {
		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			when(() => mockAnimalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: mockAnimalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalTextWidget(),
						),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after toggle', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([Animal(name: 'Cat', icon: Icons.access_time), Animal(name: 'Dog', icon: Icons.person)]),
				initialState: Animal(name: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: mockAnimalCubit,
					child: MaterialApp(
						home: Scaffold(
							body: AnimalTextWidget(),
						),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
