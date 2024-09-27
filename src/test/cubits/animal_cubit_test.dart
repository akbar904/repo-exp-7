
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_animal_app/cubits/animal_cubit.dart';

// Mock class for AnimalCubit
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Cat', () {
			expect(animalCubit.state, AnimalState.animal(name: 'Cat', icon: Icons.access_time));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits Dog state when toggleAnimal is called from Cat state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				AnimalState.animal(name: 'Dog', icon: Icons.person),
			],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits Cat state when toggleAnimal is called from Dog state',
			build: () => animalCubit,
			seed: () => AnimalState.animal(name: 'Dog', icon: Icons.person),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				AnimalState.animal(name: 'Cat', icon: Icons.access_time),
			],
		);
	});
}
