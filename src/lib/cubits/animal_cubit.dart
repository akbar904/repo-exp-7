
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../models/animal_model.dart';

class AnimalState {
	final String name;
	final IconData icon;

	AnimalState.animal({required this.name, required this.icon});

	static const AnimalState initial = AnimalState.animal(name: 'Cat', icon: Icons.access_time);
}

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState.initial);

	void toggleAnimal() {
		if (state.name == 'Cat') {
			emit(AnimalState.animal(name: 'Dog', icon: Icons.person));
		} else {
			emit(AnimalState.animal(name: 'Cat', icon: Icons.access_time));
		}
	}
}
