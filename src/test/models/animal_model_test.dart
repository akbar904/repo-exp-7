
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:my_package/models/animal_model.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should have a name and an icon', () {
			final animal = Animal(name: 'Cat', icon: Icons.access_time);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.access_time);
		});

		test('Animal model should be able to change its properties', () {
			var animal = Animal(name: 'Cat', icon: Icons.access_time);

			animal = Animal(name: 'Dog', icon: Icons.person);

			expect(animal.name, 'Dog');
			expect(animal.icon, Icons.person);
		});

		test('Animal model should handle null name and icon', () {
			final animal = Animal(name: null, icon: null);

			expect(animal.name, null);
			expect(animal.icon, null);
		});
	});
}
