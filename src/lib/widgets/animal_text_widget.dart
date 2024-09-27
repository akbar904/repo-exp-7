
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/animal_cubit.dart';
import '../models/animal_model.dart';

class AnimalTextWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, AnimalState>(
			builder: (context, state) {
				if (state is Animal) {
					return GestureDetector(
						onTap: () => context.read<AnimalCubit>().toggleAnimal(),
						child: Row(
							children: [
								Text(state.name),
								Icon(state.icon),
							],
						),
					);
				}
				return Container();
			},
		);
	}
}
