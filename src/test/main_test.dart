
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

class MockAnimalState extends Mock implements AnimalState {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App shows HomeScreen with initial state', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>.value(
					value: mockAnimalCubit,
					child: MyApp(),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});

	group('AnimalCubits', () {
		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState] when toggleAnimal is called',
			build: () => AnimalCubit(),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				isA<AnimalState>().having((state) => state.animal.name, 'name', 'Dog'),
				isA<AnimalState>().having((state) => state.animal.icon, 'icon', Icons.person),
			],
		);
	});
}
